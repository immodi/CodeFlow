import 'package:dio/dio.dart';
import '../../../../../core/services/network_services.dart';
import '../models/compile_model.dart';
import '../models/root_model.dart';
import 'compile_data_source.dart';



class CompileRemoteDataSourceImpl implements CompileRemoteDataSource {
  final NetworkServices networkServices;

  CompileRemoteDataSourceImpl({required this.networkServices});

  @override
  Future<RootModel> getSupportedLanguages() async {
    try {
      final response = await networkServices.dio.get("");
      if (response.statusCode == 200) {
        return RootModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch supported languages: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching supported languages: $e");
    }
  }

  @override
  Future<CompileModel> compileCode(String token, String language, String code) async {
    try {
      final response = await networkServices.dio.post(
        "compile",
        data: {
          "language": language,
          "codeToRun": code,
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        return CompileModel.fromJson(response.data);
      } else {
        throw Exception("Failed to compiler_tab code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error during compilation: $e");
    }
  }
}

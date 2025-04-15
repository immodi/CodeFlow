import '../models/compile_model.dart';
import '../models/root_model.dart';

abstract class CompileRemoteDataSource {
  Future<RootModel> getSupportedLanguages();
  Future<CompileModel> compileCode(String token, String language, String code);
}
import '../../domain/repo/compile_repository.dart';
import '../data_source/compile_data_source.dart';
import '../models/compile_model.dart';
import '../models/root_model.dart';

class CompileRepositoryImpl implements CompileRepository {
  final CompileRemoteDataSource remoteDataSource;

  CompileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<RootModel> getSupportedLanguages() {
    return remoteDataSource.getSupportedLanguages();
  }

  @override
  Future<CompileModel> compileCode(String token, String language, String code) {
    return remoteDataSource.compileCode(token, language, code);
  }
}

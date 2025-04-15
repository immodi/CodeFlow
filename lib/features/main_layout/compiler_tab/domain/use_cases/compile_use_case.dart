import '../../data/models/compile_model.dart';
import '../../data/models/root_model.dart';
import '../repo/compile_repository.dart';

class CompileFeatureUseCase {
  final CompileRepository repository;

  CompileFeatureUseCase({required this.repository});

  Future<RootModel> getSupportedLanguages() {
    return repository.getSupportedLanguages();
  }

  Future<CompileModel> compileCode(String token, String language, String code) {
    return repository.compileCode(token, language, code);
  }
}

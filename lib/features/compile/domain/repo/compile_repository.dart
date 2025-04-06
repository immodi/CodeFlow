import '../../data/models/compile_model.dart';
import '../../data/models/root_model.dart';

abstract class CompileRepository {
  Future<RootModel> getSupportedLanguages();
  Future<CompileModel> compileCode(String token, String language, String code);
}

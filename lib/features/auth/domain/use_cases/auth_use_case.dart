import 'package:graduation_project/features/auth/data/models/auth_model.dart';
import 'package:graduation_project/features/auth/domain/repo/repo.dart';

class AuthUseCase {
  final AuthRepo repository;

  AuthUseCase(this.repository);

  Future<AuthModel> login(String username, String password) async {
    return await repository.login(username, password);
  }

  Future<AuthModel> register(String username, String password) async {
    return await repository.register(username, password);
  }
}

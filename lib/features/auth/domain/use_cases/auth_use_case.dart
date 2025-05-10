import 'package:graduation_project/features/auth/data/models/auth_model.dart';
import 'package:graduation_project/features/auth/domain/repo/repo.dart';

import '../../data/models/password_reset_model.dart';

class AuthUseCase {
  final AuthRepo repository;

  AuthUseCase(this.repository);

  Future<AuthModel> login(String username, String password) async {
    return await repository.login(username, password);
  }

  Future<AuthModel> register(String username, String password, String email) async {
    return await repository.register(username, password, email);
  }

  Future<PasswordResetModel> requestPasswordReset(String username) async {
    return await repository.requestPasswordReset(username);
  }

  Future<AuthModel> resetPassword(String code, String username, String newPassword) async {
    return await repository.resetPassword(code, username, newPassword);
  }
}


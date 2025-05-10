
import '../../data/models/auth_model.dart';
import '../../data/models/password_reset_model.dart';

abstract class AuthRepo{
  Future<AuthModel> login(String username, String password);
  Future<AuthModel> register(String username,  String password,String email);
  Future<PasswordResetModel> requestPasswordReset(String username);
  Future<AuthModel> resetPassword(String code, String username, String newPassword);
}

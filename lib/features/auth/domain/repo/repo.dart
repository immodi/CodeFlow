
import '../../data/models/auth_model.dart';

abstract class AuthRepo{
  Future<AuthModel> login(String username, String password);
  Future<AuthModel> register(String username,  String password,String email);
  Future<void> requestPasswordReset(String username);
  Future<AuthModel> resetPassword(String code, String username, String newPassword);
}

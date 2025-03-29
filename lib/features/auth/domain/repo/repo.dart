
import '../../data/models/auth_model.dart';

abstract class AuthRepo{
  Future<AuthModel> login(String username, String password);
  Future<AuthModel> register(String username,  String password);
}

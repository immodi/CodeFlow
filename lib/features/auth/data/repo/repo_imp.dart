import 'package:graduation_project/features/auth/data/models/auth_model.dart';
import '../../domain/repo/repo.dart';
import '../data_source/data_source.dart';

class AuthRepositoryImpl implements AuthRepo {
  final AuthDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthModel> login(String name, String password) async {
    final response = await remoteDataSource.login(username: name, password: password);
    return AuthModel.fromJson(response.data);
  }

  @override
  Future<AuthModel> register(String name,  String password,String email) async {
    final response = await remoteDataSource.register(username: name,  password: password,email: email);
    return AuthModel.fromJson(response.data);
  }
  @override
  Future<void> requestPasswordReset(String username) async {
    await remoteDataSource.requestPasswordReset(username: username);
  }

  @override
  Future<AuthModel> resetPassword(String code, String username, String newPassword) async {
    final response = await remoteDataSource.resetPassword(
      code: code,
      username: username,
      newPassword: newPassword,
    );
    return AuthModel.fromJson(response.data);
  }
}

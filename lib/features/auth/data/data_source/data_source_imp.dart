import 'package:dio/dio.dart';
import 'package:graduation_project/core/services/network_services.dart';
import 'data_source.dart';

class AuthRemoteDataSourceImp implements AuthDataSource {
  final NetworkServices _networkService = NetworkServices();

  @override
  Future<Response> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _networkService.dio.post(
        "/login",
        data: {"username": username, "password": password},
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Response> register({
    required String username,
    required String password,
    required String email,
  }) async {
    try {
      final response = await _networkService.dio.post(
        "/register",
        data: {"username": username, "password": password, 'email':email},
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
  @override
  Future<Response> requestPasswordReset({required String username}) async {
    try {
      final response = await _networkService.dio.post(
        "/request-password-reset",
        data: {"username": username},
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Response> resetPassword({
    required String code,
    required String username,
    required String newPassword,
  }) async {
    try {
      final response = await _networkService.dio.post(
        "/reset-password",
        data: {
          "code": code,
          "username": username,
          "newPassword": newPassword,
        },
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

}

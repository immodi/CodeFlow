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
  }) async {
    try {
      final response = await _networkService.dio.post(
        "/register",
        data: {"username": username, "password": password},
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}

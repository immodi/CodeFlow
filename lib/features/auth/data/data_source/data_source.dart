import 'package:dio/dio.dart';

abstract class AuthDataSource {
  Future<Response> login({required String username, required String password});
  Future<Response> register({required String username, required String password});
}

import 'package:dio/dio.dart';

class NetworkServices {
  static final NetworkServices _instance = NetworkServices._internal();

  factory NetworkServices() => _instance;

  late Dio dio;
  String? _token;

  NetworkServices._internal() {
    dio = Dio(BaseOptions(
      baseUrl: "https://gradapi.duckdns.org/",
      followRedirects: false,
      validateStatus: (int? status) {
        if (status == null) return false;
        return status < 300;
      },
    ));
  }

  void updateToken(String? token) {
    _token = token;
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      dio.options.headers.remove('Authorization');
    }
  }

  String? get token => _token; // ✅ ده اللي تستخدمه في ViewModel
}


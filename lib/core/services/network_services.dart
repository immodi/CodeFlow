import 'package:dio/dio.dart';

class NetworkServices {
  late Dio dio;

  NetworkServices._() {
    init();
  }

  static final NetworkServices _instance = NetworkServices._();

  factory NetworkServices() => _instance;

  void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://gradapi.duckdns.org/",
        followRedirects: false,
        validateStatus: (int? status) {
          if (status == null) return false;
          if (status < 300) {
            return true;
          } else if (status == 401) {
            // Handle unauthorized case
            return false;
          } else {
            return false;
          }
        },
      ),
    );
  }

  void updateToken(String? token) {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      dio.options.headers.remove('Authorization');
    }
  }
}

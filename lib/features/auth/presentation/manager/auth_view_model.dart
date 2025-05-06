import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/network_services.dart';
import '../../domain/use_cases/auth_use_case.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthUseCase authUseCase;

  AuthViewModel({required this.authUseCase});

  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;
  String? token;

  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ✅ Login Method
  Future<void> login(String username, String password) async {
    try {
      _setLoading(true);

      final result = await authUseCase.login(username, password);

      token = result.token;
      await _saveAndApplyToken(token!);

      isSuccess = true;
      errorMessage = null;
      _setLoading(false);
    } catch (e) {
      _handleError(e);
    }
  }

  // ✅ Register Method
  Future<void> register(String username, String password, String email) async {
    try {
      _setLoading(true);

      final result = await authUseCase.register(username, password, email);

      token = result.token;
      await _saveAndApplyToken(token!);

      isSuccess = true;
      errorMessage = null;
      _setLoading(false);
    } catch (e) {
      _handleError(e);
    }
  }

  // ✅ Request Password Reset
  Future<void> requestPasswordReset(String username) async {
    try {
      _setLoading(true);

      await authUseCase.requestPasswordReset(username);

      isSuccess = true;
      errorMessage = null;
      _setLoading(false);
    } catch (e) {
      _handleError(e);
    }
  }

  // ✅ Reset Password Method
  Future<void> resetPassword({
    required String code,
    required String username,
    required String newPassword,
  }) async {
    try {
      _setLoading(true);

      final result =
      await authUseCase.resetPassword(code, username, newPassword);

      token = result.token;
      await _saveAndApplyToken(token!);

      isSuccess = true;
      errorMessage = null;
      _setLoading(false);
    } catch (e) {
      _handleError(e);
    }
  }

  // ✅ حفظ التوكن وتحديث Dio
  Future<void> _saveAndApplyToken(String token) async {
    await _saveToken(token);
    NetworkServices().updateToken(token);
  }

  // ✅ حفظ التوكن فقط
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // ✅ جلب التوكن
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // ✅ تسجيل خروج
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    token = null;

    NetworkServices().updateToken(null);

    notifyListeners();
  }

  // ✅ إعادة تعيين الحالة
  void resetStatus() {
    isSuccess = false;
    notifyListeners();
  }

  // ✅ تحميل الحالة
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // ✅ التعامل مع الأخطاء
  void _handleError(dynamic e) {
    isLoading = false;

    if (e is DioException) {
      errorMessage =
          e.response?.data['message'] ?? 'An error occurred. Please try again.';
    } else {
      errorMessage = 'Unexpected error occurred. Please try again.';
    }

    notifyListeners();
  }
}

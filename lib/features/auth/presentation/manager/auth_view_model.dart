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
  bool rememberMe = false;
  bool showLoginError = false;
  bool showResetPasswordError = false;
  bool showRequestResetPasswordError = false;


  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ✅ تسجيل الدخول
  Future<void> login(String username, String password) async {
    try {
      _setLoading(true);

      final result = await authUseCase.login(username, password);
      token = result.token;

      await _saveAndApplyToken(token!);

      if (rememberMe) {
        await _saveRememberMe(true);
      }

      isSuccess = true;
      errorMessage = null;
      _setLoading(false);
    } catch (e) {
      _handleError(e);
    }
  }

  // ✅ إنشاء حساب
  Future<void> register(String username, String password, String email) async {
    try {
      _setLoading(true);

      final result = await authUseCase.register(username, password, email);
      token = result.token;

      await _saveAndApplyToken(token!);

      if (rememberMe) {
        await _saveRememberMe(true);
      }

      isSuccess = true;
      errorMessage = null;
      _setLoading(false);
    } catch (e) {
      _handleError(e);
    }
  }

  // ✅ طلب كود إعادة تعيين كلمة المرور
  Future<void> requestPasswordReset(String username) async {
    try {
      _setLoading(true);
       showRequestResetPasswordError = false;


      await authUseCase.requestPasswordReset(username);

      isSuccess = true;
      showLoginError =false;
      errorMessage = null;
      _setLoading(false);
    } catch (e) {
       showRequestResetPasswordError = true;
       notifyListeners();


       _handleError(e);
    }
  }

  // ✅ إعادة تعيين كلمة المرور
  Future<void> resetPassword({
    required String code,
    required String username,
    required String newPassword,
  }) async {
    try {
      _setLoading(true);
      showResetPasswordError = false;

      final result =
      await authUseCase.resetPassword(code, username, newPassword);
      token = result.token;

      await _saveAndApplyToken(token!);

      if (rememberMe) {
        await _saveRememberMe(true);
      }

      isSuccess = true;
      errorMessage = null;
      _setLoading(false);
    } catch (e) {
      showResetPasswordError = true;
      notifyListeners();
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

  // ✅ تفعيل / تعطيل Remember Me
  void toggleRememberMe(bool value) async {
    rememberMe = value;
    await _saveRememberMe(value);
    notifyListeners();
  }

  // ✅ حفظ rememberMe
  Future<void> _saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
  }

  // ✅ تحميل حالة rememberMe والتوكن (تُستخدم في SplashScreen مثلاً)
  Future<void> loadRememberMeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    rememberMe = prefs.getBool('rememberMe') ?? false;

    if (rememberMe) {
      token = prefs.getString('token');
      if (token != null) {
        NetworkServices().updateToken(token!);
        isSuccess = true;
      }
    }

    notifyListeners();
  }

  // ✅ تسجيل خروج
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.setBool('rememberMe', false);

    token = null;
    rememberMe = false;

    // Clear text fields
    usernameController.clear();
    passwordController.clear();

    // Hide login error message
    showLoginError = false;

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

  void _handleError(dynamic e) {
    isLoading = false;

    showLoginError = true;

    notifyListeners();
  }


}

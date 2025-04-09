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

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  // Login Method
  Future<void> login(String username, String password) async {
    try {
      _setLoading(true);

      final result = await authUseCase.login(username, password);

      token = result.token;
      await _saveToken(token!);

      isSuccess = true;
      errorMessage = null;

      _setLoading(false);
    } catch (e) {
      _handleError(e);
    }
  }

  // Register Method
  Future<void> register(String username, String password) async {
    try {
      _setLoading(true);

      final result = await authUseCase.register(username, password);

      token = result.token;
      await _saveToken(token!);

      isSuccess = true;
      errorMessage = null;

      _setLoading(false);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Get token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Clear token
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    token = null;

    NetworkServices().updateToken(null);

    notifyListeners();
  }



  // Reset status
  void resetStatus() {
    isSuccess = false;
    notifyListeners();
  }

  // Handle loading
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Handle error
  void _handleError(dynamic e) {
    isLoading = false;
    errorMessage = e.toString();
    notifyListeners();
  }
}

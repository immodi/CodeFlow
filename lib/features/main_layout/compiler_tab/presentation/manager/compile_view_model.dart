import 'package:flutter/material.dart';
import '../../data/models/compile_model.dart';
import '../../data/models/root_model.dart';
import '../../domain/use_cases/compile_use_case.dart';

class CompileViewModel extends ChangeNotifier {
  final CompileFeatureUseCase compileFeatureUseCase;
  final String token;

  bool isLoading = false;
  String? errorMessage;
  RootModel? rootModel;
  CompileModel? compileResult;

  CompileViewModel({required this.compileFeatureUseCase, required this.token});

  Future<void> fetchSupportedLanguages() async {
    try {
      isLoading = true;
      notifyListeners();

      rootModel = await compileFeatureUseCase.getSupportedLanguages();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> compileCode(String language, String code) async {
    try {
      isLoading = true;
      compileResult = null;
      notifyListeners();

      compileResult = await compileFeatureUseCase.compileCode(token, language, code);


      if (compileResult == null) {
        throw Exception('Compilation failed - no result');
      }
    } catch (e) {
      errorMessage = e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }}

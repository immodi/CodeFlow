import 'package:flutter/material.dart';
import 'package:graduation_project/features/compile/presentation/screens/code_editor.dart';
import 'package:graduation_project/features/auth/presentation/screens/login_screen.dart';
import 'package:graduation_project/features/auth/presentation/screens/register_screen.dart';

import 'app_routes_name.dart';

class AppRoutes {
  AppRoutes._();
  static Map<String, Widget Function(BuildContext)> routes={
    AppRoutesName.loginScreen: (_) => LoginScreen(),
    AppRoutesName.registerScreen: (_) => RegisterScreen(),
    AppRoutesName.compilerScreen: (_) => CodeEditorScreen(),


  };
}
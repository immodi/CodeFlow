import 'package:flutter/material.dart';
import 'package:graduation_project/features/auth/presentation/screens/login_screen.dart';
import 'package:graduation_project/features/auth/presentation/screens/register_screen.dart';
import 'package:graduation_project/features/main_layout/chat_bot_tab/presentation/screens/chat_bot_screen.dart';
import 'package:graduation_project/features/main_layout/compiler_tab/presentation/screens/compiler.dart';
import 'package:graduation_project/features/main_layout/main_layout.dart';
import '../../features/main_layout/compiler_tab/presentation/screens/code_editor.dart';
import '../../features/main_layout/profile_tab/presentation/screens/profile_screen.dart';
import 'app_routes_name.dart';

class AppRoutes {
  AppRoutes._();
  static Map<String, Widget Function(BuildContext)> routes={
    AppRoutesName.loginScreen: (_) => LoginScreen(),
    AppRoutesName.registerScreen: (_) => RegisterScreen(),
    AppRoutesName.mainLayout: (_) => MainLayout(),
    AppRoutesName.compilerScreen: (_) => CodeEditorScreen(),
    AppRoutesName.profileScreen: (_) => ProfileScreen(),
    AppRoutesName.chatBotScreen: (_) => ChatBotScreen(),
    AppRoutesName.compiler: (_) => Compiler(),


  };
}
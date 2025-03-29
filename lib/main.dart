import 'package:flutter/material.dart';
import 'package:graduation_project/core/routes/app_routes.dart';
import 'package:graduation_project/core/routes/app_routes_name.dart';
import 'package:graduation_project/core/services/network_services.dart';
import 'package:graduation_project/features/auth/data/data_source/data_source_imp.dart';
import 'package:graduation_project/features/auth/data/repo/repo_imp.dart';
import 'package:graduation_project/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';
import 'package:graduation_project/features/file_managment/data/data_source/file_remote_data_source_imp.dart';
import 'package:graduation_project/features/file_managment/data/repo/file_repository_imp.dart';
import 'package:graduation_project/features/file_managment/domain/use_cases/file_use_case.dart';
import 'package:graduation_project/features/file_managment/presentation/manager/file_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ استرجاع التوكن
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  // ✅ تجهيز NetworkServices وتحديث التوكن لو موجود
  final networkServices = NetworkServices();
  if (token != null) {
    networkServices.updateToken(token);
  }

  runApp(MyApp(
    token: token,
    networkServices: networkServices,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  final NetworkServices networkServices;

  const MyApp({super.key, this.token, required this.networkServices});

  @override
  Widget build(BuildContext context) {
    //  Auth Layer
    final authRemoteDataSource = AuthRemoteDataSourceImp();
    final authRepository = AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
    final authUseCase = AuthUseCase(authRepository);

    //  File Management Layer
    final fileRemoteDataSource = FileRemoteDataSourceImpl(networkServices: networkServices);
    final fileRepository = FileRepositoryImpl(remoteDataSource: fileRemoteDataSource);
    final fileUseCase = FileUseCase(repository: fileRepository);

    return MultiProvider(
      providers: [
        //  Auth ViewModel
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(authUseCase: authUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => FileViewModel(fileUseCase: fileUseCase, token: token?? ""),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: token != null
            ? AppRoutesName.compilerScreen
            : AppRoutesName.loginScreen,
        routes: AppRoutes.routes,
      ),
    );
  }
}

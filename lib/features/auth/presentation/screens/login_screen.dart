import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/core/routes/app_routes_name.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                TextField(
                  controller: viewModel.usernameController,
                  decoration: InputDecoration(labelText: 'اسم المستخدم'),
                ),
                TextField(
                  controller: viewModel.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'كلمة المرور'),
                ),
                SizedBox(height: 16),
                if (viewModel.isLoading) CircularProgressIndicator(),
                if (viewModel.errorMessage != null)
                  Text(viewModel.errorMessage!, style: TextStyle(color: Colors.red)),
                ElevatedButton(
                  onPressed: () async {
                    await viewModel.login(
                      viewModel.usernameController.text,
                      viewModel.passwordController.text,
                    );
                    if (viewModel.isSuccess) {
                      viewModel.resetStatus();
                      Navigator.pushReplacementNamed(context, AppRoutesName.compilerScreen);
                    }
                  },
                  child: Text('تسجيل الدخول'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()),
                    );
                  },
                  child: Text('ليس لديك حساب؟ سجل الآن'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

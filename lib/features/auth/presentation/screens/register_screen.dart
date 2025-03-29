import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل حساب جديد')),
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
                    await viewModel.register(
                      viewModel.usernameController.text,
                      viewModel.passwordController.text,
                    );
                    if (viewModel.isSuccess) {
                      viewModel.resetStatus();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('تسجيل'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

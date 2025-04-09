import 'package:flutter/material.dart';
import 'package:graduation_project/features/auth/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';

import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_feild.dart';

// class RegisterScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('تسجيل حساب جديد')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Consumer<AuthViewModel>(
//           builder: (context, viewModel, child) {
//             return Column(
//               children: [
//                 TextField(
//                   controller: viewModel.usernameController,
//                   decoration: InputDecoration(labelText: 'اسم المستخدم'),
//                 ),
//                 TextField(
//                   controller: viewModel.passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: 'كلمة المرور'),
//                 ),
//                 SizedBox(height: 16),
//                 if (viewModel.isLoading) CircularProgressIndicator(),
//                 if (viewModel.errorMessage != null)
//                   Text(viewModel.errorMessage!, style: TextStyle(color: Colors.red)),
//                 ElevatedButton(
//                   onPressed: () async {
//                     await viewModel.register(
//                       viewModel.usernameController.text,
//                       viewModel.passwordController.text,
//                     );
//                     if (viewModel.isSuccess) {
//                       viewModel.resetStatus();
//                       Navigator.pop(context);
//                     }
//                   },
//                   child: Text('تسجيل'),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.gray,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.appLogo,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          height: size.height * 0.15,
                          width: size.width * 0.47,
                        ),
                      ],
                    ),
                    Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: size.height * 0.1),
                    CustomTextField(
                      controller: viewModel.usernameController,
                      hintText: 'Enter your username',
                      icon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    CustomTextField(
                      controller: viewModel.usernameController,
                      hintText: 'Enter your email',
                      icon: Icons.mail_rounded,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be empty";
                        }
                        final emailRegex = RegExp(
                          r'^[^@]+@[^@]+\.[^@]+',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    CustomTextField(
                      controller: viewModel.passwordController,
                      hintText: 'Enter your password',
                      icon: Icons.lock,
                      isObscure: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomButton(
                      text: 'Sign Up',
                      onTap: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          await viewModel.login(
                            viewModel.usernameController.text,
                            viewModel.passwordController.text,
                          );
                          if (viewModel.isSuccess) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutesName.compilerScreen,
                            );
                          }
                        }
                      },
                      isLoading: viewModel.isLoading,
                    ),
                    SizedBox(height: size.height * 0.029),
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.white)),
                        Text(
                          ' OR ',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 13,
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.white)),
                      ],
                    ),
                    SizedBox(height: size.height * 0.029),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 13,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: AppColors.lightGreen,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



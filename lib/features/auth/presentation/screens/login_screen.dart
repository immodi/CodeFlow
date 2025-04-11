import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/core/app_assets/app_assets.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_button.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_text_feild.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/core/routes/app_routes_name.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';
import 'register_screen.dart';

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('تسجيل الدخول')),
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
//                     await viewModel.login(
//                       viewModel.usernameController.text,
//                       viewModel.passwordController.text,
//                     );
//                     if (viewModel.isSuccess) {
//                       viewModel.resetStatus();
//                       Navigator.pushReplacementNamed(context, AppRoutesName.compilerScreen);
//                     }
//                   },
//                   child: Text('تسجيل الدخول'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => RegisterScreen()),
//                     );
//                   },
//                   child: Text('ليس لديك حساب؟ سجل الآن'),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.gray,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<AuthViewModel>(
            builder: (context, viewModel, child) {
              return Form(
                key: viewModel.formKey, // إضافة GlobalKey<FormState> هنا
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.13),
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
                        'Welcome Back!',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: size.height * 0.14),
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
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: AppColors.lightGreen,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      CustomButton(
                        text: 'Sign In',
                        onTap: () async {
                          if (viewModel.formKey.currentState?.validate() ??
                              false) {
                            await viewModel.login(
                              viewModel.usernameController.text,
                              viewModel.passwordController.text,
                            );
                            if (viewModel.isSuccess) {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutesName.mainLayout,
                              );
                            }
                          }
                        },
                        isLoading: viewModel.isLoading, // تمرير حالة التحميل
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
                            'Dont have an account? ',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 13,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, AppRoutesName.registerScreen);
                            },
                            child: Text(
                              'Sign up',
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
      ),
    );
  }
}

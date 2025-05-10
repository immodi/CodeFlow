import 'package:flutter/material.dart';
import 'package:graduation_project/core/app_assets/app_assets.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_button.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_text_feild.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/core/routes/app_routes_name.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                key: viewModel.formKey,
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
                      if (viewModel.showLoginError)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Invalid username or password",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      CustomTextField(
                        controller: usernameController,
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
                        controller: passwordController,
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
                        children: [
                          CheckboxTheme(
                            data: CheckboxThemeData(
                              side: BorderSide(
                                color: Colors.white,
                              ),
                              // لون الحواف
                              shape: CircleBorder(),
                            ),
                            child: Checkbox(value: viewModel.rememberMe,
                              onChanged: (value) {
                                if (value != null) {
                                  viewModel.toggleRememberMe(value);
                                }
                              },
                              activeColor: AppColors.lightGreen,
                              shape: CircleBorder(),),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 11,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutesName.forgetPassword1,
                              );
                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                color: AppColors.lightGreen,
                                fontSize: 11,
                              ),
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
                              usernameController.text,
                              passwordController.text,
                            );
                            if (viewModel.isSuccess) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutesName.mainLayout,
                                    (route) => false, // this removes all previous routes
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
                            'Dont have an account? ',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 13,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutesName.registerScreen,
                              );
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

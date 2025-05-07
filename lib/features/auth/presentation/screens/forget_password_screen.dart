import 'package:flutter/material.dart';
import 'package:graduation_project/core/routes/app_routes_name.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_button.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_text_feild.dart';
import 'package:provider/provider.dart';
import '../manager/auth_view_model.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.gray,
      appBar: AppBar(
        backgroundColor: AppColors.gray,
        iconTheme: IconThemeData(color: AppColors.white),
        centerTitle: true,
        title: Text(
          'Forget Password',
          style: TextStyle(color: AppColors.white, fontSize: 20),
        ),
      ),
      body: Consumer<AuthViewModel>(builder: (context, viewModel, _) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                Image.asset(
                  'assets/images/amico.png',
                  width: double.infinity,
                  height: size.height * 0.4,
                ),
                SizedBox(height: size.height * 0.05),
                if (viewModel.showRequestResetPasswordError)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Center(
                      child: Text(
                        'Invalid username',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ),

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
                SizedBox(height: size.height * 0.03),

                CustomButton(
                  text: viewModel.isLoading ? 'Sending...' : 'Send Code',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await viewModel
                          .requestPasswordReset(viewModel.usernameController.text)
                          .then((_) {
                        if (viewModel.isSuccess) {
                          viewModel.resetStatus();
                          Navigator.pushNamed(
                              context, AppRoutesName.forgetPassword2);
                        } else if (viewModel.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(viewModel.errorMessage!),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

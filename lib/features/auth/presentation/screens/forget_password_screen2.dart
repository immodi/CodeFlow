import 'package:flutter/material.dart';
import 'package:graduation_project/core/routes/app_routes_name.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_button.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_text_feild.dart';
import 'package:provider/provider.dart';
import '../manager/auth_view_model.dart';

class ForgetPasswordScreen2 extends StatefulWidget {
  const ForgetPasswordScreen2({super.key});

  @override
  State<ForgetPasswordScreen2> createState() => _ForgetPasswordScreen2State();
}

class _ForgetPasswordScreen2State extends State<ForgetPasswordScreen2> {
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
                  'assets/images/OTP Vector.png',
                  width: double.infinity,
                  height: size.height * 0.4,
                ),
                Text('Code Sent',style: TextStyle(color: AppColors.white,),textAlign:TextAlign.center ,),
                Text('Check Your Email',style: TextStyle(color: AppColors.white,),textAlign:TextAlign.center),
                SizedBox(height: size.height * 0.05),

                CustomTextField(
                  controller: viewModel.otpController,
                  hintText: 'Enter Sent Code',
                  icon: Icons.mail_rounded,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter sent code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.03),

                CustomButton(
                  text: 'Enter Code',
                    onTap: () {
                    Navigator.pushNamed(context, AppRoutesName.resetPassword);
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

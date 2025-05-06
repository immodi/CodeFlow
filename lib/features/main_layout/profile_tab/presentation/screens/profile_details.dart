import 'package:flutter/material.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_text_feild.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authVM, child) =>
          Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.gray,
              iconTheme: IconThemeData(color:AppColors.white ),

            ),
            backgroundColor: AppColors.gray,
            body: Column(
              children: [
                Container(

                  child: TextFormField(
                    controller: authVM.usernameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintStyle: const TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  ),
                )
              ],
            ),
          )
      ,
    );
  }
}

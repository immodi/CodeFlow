import 'package:flutter/material.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_button.dart';
import 'package:graduation_project/features/main_layout/profile_tab/presentation/widgets/custom_profile_containers.dart';
import 'package:provider/provider.dart';
import '../../../../../core/routes/app_routes_name.dart';

class ProfileScreen extends StatelessWidget {
  final void Function({int subTabIndex})? navigateToHomeTab;

   const ProfileScreen({super.key,  this.navigateToHomeTab});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gray,
        title: Text(
          'Account',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.gray,
      body: Consumer<AuthViewModel>(
        builder:
            (context, authVm, child) => Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.1),
                  Text(
                    'Hi,${authVm.usernameController.text}',
                    style: TextStyle(color: AppColors.white, fontSize: 20),
                  ),
                  CustomProfileContainers(
                      text: 'Profile',
                      onTap:() {
                        Navigator.pushNamed(context, AppRoutesName.profileDetails);

                      },
                    icon:Icon(Icons.person, color: AppColors.white,size: 19,) ,
                  ),
                  SizedBox(height: 17,),
                  CustomProfileContainers(
                    text: 'My Projects',
                    onTap:() {
                      navigateToHomeTab!(subTabIndex: 1);
                    },
                    icon:Icon(Icons.file_copy, color: AppColors.white,size: 19,) ,
                  ),
                  SizedBox(height: 17,),
                  CustomProfileContainers(
                    text: 'Import Link',
                    onTap:() {
                      navigateToHomeTab!(subTabIndex: 3);
                    },
                    icon:Icon(Icons.link_rounded, color: AppColors.white,size: 19,) ,
                  ),
                  SizedBox(height: 17,),
                  CustomProfileContainers(
                    text: 'About Us',
                    onTap:() {},
                    icon:Icon(Icons.help, color: AppColors.white,size: 19,) ,
                  ),
                  Spacer(),
                  CustomButton(
                    text: 'Logout',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: AppColors.gray,
                          title: Text(
                            'Confirm Logout',
                            style: TextStyle(color: AppColors.white),
                          ),
                          content: Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(color: AppColors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context); // Close the dialog first
                                await authVm.logout();
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutesName.loginScreen,
                                );
                              },
                              child: Text('Logout', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },

                    icon: Icon(Icons.logout_rounded, color: AppColors.white),
                  ),
                ],
              ),
            ),
      ),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:graduation_project/core/app_assets/app_assets.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:graduation_project/features/main_layout/chat_bot_tab/presentation/screens/chat_bot_screen.dart';
import 'package:graduation_project/features/main_layout/compiler_tab/presentation/screens/code_editor.dart';
import 'package:graduation_project/features/main_layout/profile_tab/presentation/screens/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
List<Widget> screens =
[
  CodeEditorScreen(),
  ChatBotScreen(),
  ProfileScreen(),
];
int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.gray,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.gray,
        fixedColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: AppColors.white),
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: size.height*0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: currentIndex == 0 ? AppColors.white : Colors.transparent,
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(1),
              width: size.height*0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: currentIndex == 1 ? AppColors.white : Colors.transparent,
                  width: 1,
                ),
              ),
              child:Image.asset(AppAssets.chatBot,height: size.height*0.03,width: size.width*0.03,),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: size.height*0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: currentIndex == 2 ? AppColors.white : Colors.transparent,
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            label: '',
          ),
        ],
      ),
     body: screens[currentIndex],
    );
  }
}

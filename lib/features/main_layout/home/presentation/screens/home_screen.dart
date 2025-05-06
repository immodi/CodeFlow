import 'package:flutter/material.dart';
import 'package:graduation_project/features/main_layout/compiler_tab/presentation/screens/code_editor.dart';
import 'package:graduation_project/features/main_layout/profile_tab/presentation/screens/import_link_screen.dart';
import 'package:provider/provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../compiler_tab/presentation/screens/compiler.dart';
import '../../../profile_tab/presentation/screens/my_projects_screen.dart';
import '../../manager/home_tab_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeTabController>(
      builder: (context, homeTabController, child) {
        debugPrint('Current tab: ${homeTabController.currentTab}'); // للتتبع

        Widget selectedScreen;
        switch (homeTabController.currentTab) {
          case 0:
            selectedScreen = CodeEditorScreen();
            break;
          case 1:
            selectedScreen = MyProjectsScreen();
            break;
          case 2:
            selectedScreen = CompilerScreen(); // هيتم بناؤه من جديد كل مرة
            break;
          case 3:
            selectedScreen = ImportLinkScreen();
            break;
          default:
            selectedScreen = Container();
        }

        return Scaffold(
          backgroundColor: AppColors.gray,
          body: selectedScreen,
        );
      },
    );
  }
}

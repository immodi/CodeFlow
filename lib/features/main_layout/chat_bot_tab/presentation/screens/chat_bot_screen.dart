import 'package:flutter/material.dart';
import 'package:graduation_project/core/app_assets/app_assets.dart';
import 'package:graduation_project/core/theme/app_colors.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.gray,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.appLogo,
                    width: size.width * 0.3,
                    height: size.height * 0.1,
                  ),
                ],
              ),
              Text(
                'Code Flow ChatBot',
                style: TextStyle(color: AppColors.white, fontSize: 12),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

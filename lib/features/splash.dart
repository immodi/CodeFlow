import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/app_assets/app_assets.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/routes/app_routes_name.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _checkFlow();
  }

  void _checkFlow() async {
    await Future.delayed(Duration(seconds: 2)); // علشان الانيميشن يشتغل

    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool('onboarding_seen') ?? false;
    final token = prefs.getString('token');

    if (!mounted) return;

    if (!seenOnboarding) {
      Navigator.pushReplacementNamed(context, AppRoutesName.onboarding);
    } else {
      if (token != null) {
        Navigator.pushReplacementNamed(context, AppRoutesName.mainLayout);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutesName.loginScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.gray,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: BounceIn(
              duration: Duration(seconds: 1),
              child: Column(
                children: [
                  Image.asset(AppAssets.appLogo, width: size.width * 0.8),
                  SizedBox(height: 10),
                  Text(
                    'CodeFlow',
                    style: TextStyle(
                      color: AppColors.lightGreen,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:graduation_project/core/routes/app_routes_name.dart';
import 'package:graduation_project/features/auth/presentation/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/theme/app_colors.dart';
import '../category/category.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'InitialPages';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  String buttonText = "Next";

  void _onPageChanged(int index) {
    setState(() {
      if (index == Category.categoryData.length - 1) {
        buttonText = "Get Started";
      } else {
        buttonText = "Next";
      }
    });
  }

  void _onNextPressed() async {
    if (buttonText == "Get Started") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_seen', true);

      Navigator.pushNamed(context, AppRoutesName.loginScreen);
    } else {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.gray,
        body: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('onboarding_seen', true);

                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutesName.loginScreen,
                    );
                  },

                  child: Text(
                    'Skip',
                    style: TextStyle(color: AppColors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.2),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: PageView.builder(
                controller: _controller,
                itemCount: Category.categoryData.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final category = Category.categoryData[index];
                  return Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(category.image),
                          SizedBox(height: size.height * 0.07),
                          Text(
                            category.title,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                category.desc,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Spacer(),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: Category.categoryData.length,
                    effect: SwapEffect(
                      activeDotColor: AppColors.lightGreen,
                      dotHeight: 7,
                      dotWidth: 7,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            CustomButton(text: buttonText, onTap: _onNextPressed),
          ],
        ),
      ),
    );
  }
}

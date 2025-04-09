import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Widget? icon;
  final bool isLoading;

  const CustomButton({
    required this.text,
    required this.onTap,
    this.icon,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.lightBlue, AppColors.lightGreen],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              CircularProgressIndicator(
                color: AppColors.white,
              ),
            if (!isLoading)
              ...[
                if (icon != null) icon!,
                Text(
                  ' $text',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
          ],
        ),
      ),
    );
  }
}

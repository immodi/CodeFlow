import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class CustomProfileContainers extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Widget? icon;
  const CustomProfileContainers({super.key,required this.text,required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        InkWell(
          onTap: onTap ,
          child: Container(
            padding: EdgeInsets.all(15),
            height: size.height * 0.07,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.lightGray,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (icon != null) icon!,
                SizedBox(width: 10),
                Text(
                  text,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: AppColors.white,size: 17)
              ],
            ),
          ),
        )
      ],
    );
  }
}

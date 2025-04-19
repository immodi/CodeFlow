import 'package:flutter/material.dart';
import 'package:graduation_project/core/theme/app_colors.dart';

class ImportLinkScreen extends StatelessWidget {
  const ImportLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.gray,
      appBar: AppBar(
        backgroundColor: AppColors.gray,
        iconTheme: IconThemeData(color: AppColors.white, size: 27),
        centerTitle: true,
        title: Text(
          'Import Link',
          style: TextStyle(color: AppColors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              height: size.height*0.07 ,
              width: double.infinity,
              padding:  EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.lightGray,
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'import your link',
                  hintStyle: TextStyle(color: AppColors.moreLightGray, fontSize: 13),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: () {

              } ,
              child: Container(
                padding: EdgeInsets.all(15),
                height: size.height * 0.06,
                width: size.width*0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [AppColors.lightBlue, AppColors.lightGreen],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get Code',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 13,
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

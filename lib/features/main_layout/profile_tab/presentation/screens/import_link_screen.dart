import 'package:flutter/material.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../file_managment/presentation/manager/file_view_model.dart';
import '../../../compiler_tab/presentation/screens/compiler.dart';
import '../../../home/manager/home_tab_controller.dart';

class ImportLinkScreen extends StatelessWidget {
   ImportLinkScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final fileViewModel = Provider.of<FileViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.gray,
      appBar: AppBar(
        backgroundColor: AppColors.gray,
        title: Row(
          children: [
            IconButton(onPressed: () {
              final homeTabController = Provider.of<HomeTabController>(context, listen: false);
              homeTabController.changeTab(0);

            }, icon: Icon(Icons.arrow_back,color: AppColors.white,)),
            Spacer(),
            Text(
              'Import Link',
              style: TextStyle(color: AppColors.white, fontSize: 20),
            ),
            SizedBox(width: size.width*0.3,)

          ],
        ),
        centerTitle: true,

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
                controller: fileViewModel.sharedCodeController,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Enter Shared code',
                  hintStyle: TextStyle(color: AppColors.moreLightGray, fontSize: 13),
                  border: InputBorder.none,
                ),
              )
              ,
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: () async {
                final homeTabController = Provider.of<HomeTabController>(context, listen: false);
                final fileViewModel = Provider.of<FileViewModel>(context, listen: false);

                final code = fileViewModel.sharedCodeController.text.trim();

                if (code.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a code")),
                  );
                  return;
                }

                // 🧼 امسح الملف السابق لو موجود
                fileViewModel.selectedFile = null;

                // Show loading dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );

                // Call the API
                await fileViewModel.readSharedFile(code);

                // Close the loading dialog
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }

                // ✅ شرط التحقق بعد التحديث
                if (fileViewModel.selectedFile != null) {
                  homeTabController.changeTab(2);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Invalid or expired code")),
                  );
                }
              }


              ,
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
                      fileViewModel.isLoading?
                      'Getting Code...':'Get Code',
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

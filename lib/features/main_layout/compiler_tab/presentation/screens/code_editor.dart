import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/app_assets/app_assets.dart';
import 'package:graduation_project/core/routes/app_routes_name.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../file_managment/presentation/manager/file_view_model.dart';

class CodeEditorScreen extends StatelessWidget {
  const CodeEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.gray,
        body: Padding(
          padding: const EdgeInsets.all(11),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.07),
                Row(
                  children: [
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'Ready to start coding?',
                      style: TextStyle(color: AppColors.white, fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () async {
                      bool fileCreated = await _createFile(context);
                      if (fileCreated && context.mounted) {
                        Navigator.pushNamed(context, AppRoutesName.compiler);
                      }
                    },

                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.gray,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.add, color: AppColors.white),
                        Text(
                          'Create New File',
                          style: TextStyle(color: AppColors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Text(
                  'Recent',
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
                SizedBox(height: 10),
                Container(
                  height: size.height * 0.23,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset(
                          AppAssets.starLeft,
                          width: size.width * 0.3,
                          height: size.height * 0.1,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          AppAssets.starRight,
                          width: size.width * 0.3,
                          height: size.height * 0.1,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No recent files',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              'Start your first project!',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  'Explorer Options',
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
                SizedBox(height: size.height * 0.02),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutesName.myProjectScreen);
                  },
                  child: Container(
                    height: size.height * 0.041,
                    width: size.width * 0.35,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Open Folder',
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: size.height * 0.041,
                  width: size.width * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.white, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      'import code',
                      style: TextStyle(color: AppColors.white, fontSize: 13),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _createFile(BuildContext context) async {
    TextEditingController _fileNameController = TextEditingController();
    final fileViewModel = Provider.of<FileViewModel>(context, listen: false);
    String fileName = '';

    bool fileCreated = false;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create new file"),
        content: TextField(
          onChanged: (value) {
            fileName = value;
          },
          controller: _fileNameController,
          decoration: InputDecoration(hintText: "File name"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              String fileName = _fileNameController.text.trim();
              if (fileName.isNotEmpty) {
                await fileViewModel.createFile(
                  fileName,
                  "// Start coding here",
                );
                fileCreated = true;
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter file name")),
                  );
                }
              }
            },
            child: Text("Create"),
          ),
        ],
      ),
    );

    return fileCreated;
  }
}

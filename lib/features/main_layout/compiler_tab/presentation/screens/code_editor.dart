// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/core/theme/app_colors.dart';
// import 'package:provider/provider.dart';
// import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';
// import 'package:graduation_project/core/routes/app_routes_name.dart';
//
// import '../../../../file_managment/presentation/manager/file_view_model.dart';
// import '../manager/compile_view_model.dart';
//
// class CodeEditorScreen extends StatefulWidget {
//   @override
//   _CodeEditorScreenState createState() => _CodeEditorScreenState();
// }
//
// class _CodeEditorScreenState extends State<CodeEditorScreen> {
//   late TextEditingController _codeController;
//   String? selectedLanguage;
//
//   @override
//   void initState() {
//     super.initState();
//     _codeController = TextEditingController();
//
//     // تحميل الملفات من FileViewModel
//     Future.microtask(() {
//       Provider.of<FileViewModel>(context, listen: false).fetchAllFiles();
//     });
//
//     // إرسال طلب لتحميل اللغات المدعومة من CompileViewModel
//     Future.microtask(() {
//       Provider.of<CompileViewModel>(context, listen: false).fetchSupportedLanguages();
//     });
//   }
//
//   @override
//   void dispose() {
//     _codeController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
//     final fileViewModel = Provider.of<FileViewModel>(context);
//     final compileViewModel = Provider.of<CompileViewModel>(context);
//
//     return Scaffold(
//       backgroundColor: AppColors.gray,
//       appBar: AppBar(
//         backgroundColor: AppColors.gray,
//         title: Text(fileViewModel.selectedFile?.fileName ?? "Code Editor"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () async {
//               if (fileViewModel.selectedFile == null) return;
//
//               int? fileId = fileViewModel.selectedFile?.fileId;
//               if (fileId == null) return;
//
//               String newContent = _codeController.text;
//               await fileViewModel.updateFile(fileId, newFileContent: newContent);
//
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("تم حفظ الملف بنجاح")),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.delete, color: Colors.red),
//             onPressed: () => _confirmDelete(context, fileViewModel),
//           ),
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await authViewModel.logout();
//               if (mounted) {
//                 Navigator.pushReplacementNamed(context, AppRoutesName.loginScreen);
//               }
//             },
//           ),
//         ],
//       ),
//       drawer: buildFileExplorer(context),
//       body: Consumer<FileViewModel>(builder: (context, fileVM, _) {
//         if (fileVM.selectedFile != null &&
//             _codeController.text != fileVM.selectedFile!.fileContent) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (mounted) {
//               _codeController.text = fileVM.selectedFile!.fileContent;
//             }
//           });
//         }
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               // إضافة DropdownButton لاختيار اللغة
//               if (fileVM.selectedFile != null)
//                 if (compileViewModel.rootModel?.supportedLanguages != null)
//                   DropdownButton<String>(
//                     value: selectedLanguage,
//                     onChanged: (newLang) {
//                       setState(() {
//                         selectedLanguage = newLang;
//                       });
//                     },
//                     items: (compileViewModel.rootModel?.supportedLanguages ?? [])
//                         .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
//                         .toList(),
//                   ),
//
//               // إخفاء الـ TextField إذا لم يتم فتح ملف
//               if (fileVM.selectedFile != null)
//                 Expanded(
//                   child: TextField(
//                     controller: _codeController,
//                     maxLines: null,
//                     expands: true,
//                     decoration: InputDecoration(border: OutlineInputBorder()),
//                   ),
//                 ),
//
//               // زر "تشغيل" (Run)
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: compileViewModel.isLoading
//                     ? null
//                     : () async {
//                   if (selectedLanguage == null || _codeController.text.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("يرجى اختيار اللغة وكتابة الكود")),
//                     );
//                     return;
//                   }
//
//                   await compileViewModel.compileCode(
//                     selectedLanguage!,
//                     _codeController.text,
//                   );
//
//                   if (compileViewModel.compileResult != null) {
//                     // إظهار الـ output في نافذة منبثقة
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text("Output"),
//                         content: Text(compileViewModel.compileResult?.output ?? 'No output'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               // حفظ الكود في الملف بعد تشغيله
//                               fileVM.updateFile(
//                                 fileVM.selectedFile!.fileId,
//                                 newFileContent: _codeController.text,
//                               );
//                               Navigator.pop(context);
//                             },
//                             child: Text("حفظ الكود"),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text("إغلاق"),
//                           ),
//                         ],
//                       ),
//                     );
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("تم تشغيل الكود بنجاح")),
//                     );
//                   } else if (compileViewModel.errorMessage != null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("حدث خطأ: ${compileViewModel.errorMessage}")),
//                     );
//                   }
//                 },
//                 child: compileViewModel.isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text("تشغيل"),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget buildFileExplorer(BuildContext context) {
//     return Drawer(
//       child: Consumer<FileViewModel>(builder: (context, fileViewModel, _) {
//         return Column(
//           children: [
//             AppBar(title: Text("ملفاتي"), automaticallyImplyLeading: false),
//             Expanded(
//               child: fileViewModel.isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : fileViewModel.files.isEmpty
//                   ? Center(child: Text("لا يوجد ملفات"))
//                   : ListView.builder(
//                 itemCount: fileViewModel.files.length,
//                 itemBuilder: (context, index) {
//                   final file = fileViewModel.files[index];
//                   return ListTile(
//                     title: Text(file.fileName),
//                     onTap: () async {
//                       await fileViewModel.readSingleFile(file.fileId);
//                       if (context.mounted) {
//                         Navigator.pop(context);
//                       }
//                     },
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton.icon(
//                 icon: Icon(Icons.add),
//                 label: Text("إنشاء ملف جديد"),
//                 onPressed: () => createFile(context),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
//
//   void createFile(BuildContext context) {
//     TextEditingController _fileNameController = TextEditingController();
//     final fileViewModel = Provider.of<FileViewModel>(context, listen: false);
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("إنشاء ملف جديد"),
//         content: TextField(
//           controller: _fileNameController,
//           decoration: InputDecoration(hintText: "اسم الملف"),
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: Text("إلغاء")),
//           TextButton(
//             onPressed: () async {
//               String fileName = _fileNameController.text.trim();
//               if (fileName.isNotEmpty) {
//                 await fileViewModel.createFile(
//                   fileName,
//                   jsonEncode({"content": "// Start coding here"}),
//                 );
//                 if (mounted) {
//                   Navigator.pop(context);
//                 }
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("يرجى إدخال اسم الملف")),
//                 );
//               }
//             },
//             child: Text("إنشاء"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _confirmDelete(BuildContext context, FileViewModel fileViewModel) {
//     if (fileViewModel.selectedFile == null) return;
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("حذف الملف"),
//         content: Text("هل أنت متأكد أنك تريد حذف هذا الملف؟ لا يمكن التراجع عن هذا الإجراء."),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: Text("إلغاء")),
//           TextButton(
//             onPressed: () async {
//               int fileId = fileViewModel.selectedFile!.fileId;
//               await fileViewModel.deleteFile(fileId);
//
//               if (mounted) {
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("تم حذف الملف بنجاح")),
//                 );
//               }
//             },
//             child: Text("حذف", style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
                width: size.width * 0.46,
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
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutesName.compiler);
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
                        'Creat New File',
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
              SizedBox(height: 10,),
              Container(
                height: size.height * 0.23,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.2),
                  //     blurRadius: 8,
                  //     spreadRadius: 2,
                  //     offset: Offset(0, 2),
                  //   ),
                  // ],
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
              Container(
                height: size.height*0.041 ,
                width:size.width* 0.35,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('Open Folder',style: TextStyle(color: Colors.black54,fontSize: 13),),
                ),
                
              ),
              SizedBox(height: 10,),
              Container(
                height: size.height*0.041 ,
                width:size.width* 0.35,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.white,
                    width: 1
                  )
                ),
                child: Center(
                  child: Text('Open Folder',style: TextStyle(color: AppColors.white,fontSize: 13),),
                ),

              ),
              Spacer()

            ],
          ),
        ),
      ),
    );
  }
}
void createFile(BuildContext context) {
  TextEditingController _fileNameController = TextEditingController();
  final fileViewModel = Provider.of<FileViewModel>(context, listen: false);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("إنشاء ملف جديد"),
      content: TextField(
        controller: _fileNameController,
        decoration: InputDecoration(hintText: "اسم الملف"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("إلغاء"),
        ),
        TextButton(
          onPressed: () async {
            String fileName = _fileNameController.text.trim();
            if (fileName.isNotEmpty) {
              await fileViewModel.createFile(
                fileName,
                  "// Start coding here",
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Enter File Name")),
              );
            }
          },
          child: Text("Create File"),
        ),
      ],
    ),
  );
}


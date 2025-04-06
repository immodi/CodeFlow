import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';
import 'package:graduation_project/core/routes/app_routes_name.dart';
import '../../../file_managment/presentation/manager/file_view_model.dart';
import '../../../compile/presentation/manager/compile_view_model.dart';

class CodeEditorScreen extends StatefulWidget {
  @override
  _CodeEditorScreenState createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  late TextEditingController _codeController;
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();

    // تحميل الملفات من FileViewModel
    Future.microtask(() {
      Provider.of<FileViewModel>(context, listen: false).fetchAllFiles();
    });

    // إرسال طلب لتحميل اللغات المدعومة من CompileViewModel
    Future.microtask(() {
      Provider.of<CompileViewModel>(context, listen: false).fetchSupportedLanguages();
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final fileViewModel = Provider.of<FileViewModel>(context);
    final compileViewModel = Provider.of<CompileViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(fileViewModel.selectedFile?.fileName ?? "Code Editor"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if (fileViewModel.selectedFile == null) return;

              int? fileId = fileViewModel.selectedFile?.fileId;
              if (fileId == null) return;

              String newContent = _codeController.text;
              await fileViewModel.updateFile(fileId, newFileContent: newContent);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("تم حفظ الملف بنجاح")),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmDelete(context, fileViewModel),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authViewModel.logout();
              if (mounted) {
                Navigator.pushReplacementNamed(context, AppRoutesName.loginScreen);
              }
            },
          ),
        ],
      ),
      drawer: buildFileExplorer(context),
      body: Consumer<FileViewModel>(builder: (context, fileVM, _) {
        if (fileVM.selectedFile != null &&
            _codeController.text != fileVM.selectedFile!.fileContent) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _codeController.text = fileVM.selectedFile!.fileContent;
            }
          });
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // إضافة DropdownButton لاختيار اللغة
              if (fileVM.selectedFile != null)
                if (compileViewModel.rootModel?.supportedLanguages != null)
                  DropdownButton<String>(
                    value: selectedLanguage,
                    onChanged: (newLang) {
                      setState(() {
                        selectedLanguage = newLang;
                      });
                    },
                    items: (compileViewModel.rootModel?.supportedLanguages ?? [])
                        .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                        .toList(),
                  ),

              // إخفاء الـ TextField إذا لم يتم فتح ملف
              if (fileVM.selectedFile != null)
                Expanded(
                  child: TextField(
                    controller: _codeController,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),

              // زر "تشغيل" (Run)
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: compileViewModel.isLoading
                    ? null
                    : () async {
                  if (selectedLanguage == null || _codeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("يرجى اختيار اللغة وكتابة الكود")),
                    );
                    return;
                  }

                  await compileViewModel.compileCode(
                    selectedLanguage!,
                    _codeController.text,
                  );

                  if (compileViewModel.compileResult != null) {
                    // إظهار الـ output في نافذة منبثقة
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Output"),
                        content: Text(compileViewModel.compileResult?.output ?? 'No output'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // حفظ الكود في الملف بعد تشغيله
                              fileVM.updateFile(
                                fileVM.selectedFile!.fileId,
                                newFileContent: _codeController.text,
                              );
                              Navigator.pop(context);
                            },
                            child: Text("حفظ الكود"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("إغلاق"),
                          ),
                        ],
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("تم تشغيل الكود بنجاح")),
                    );
                  } else if (compileViewModel.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("حدث خطأ: ${compileViewModel.errorMessage}")),
                    );
                  }
                },
                child: compileViewModel.isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("تشغيل"),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildFileExplorer(BuildContext context) {
    return Drawer(
      child: Consumer<FileViewModel>(builder: (context, fileViewModel, _) {
        return Column(
          children: [
            AppBar(title: Text("ملفاتي"), automaticallyImplyLeading: false),
            Expanded(
              child: fileViewModel.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : fileViewModel.files.isEmpty
                  ? Center(child: Text("لا يوجد ملفات"))
                  : ListView.builder(
                itemCount: fileViewModel.files.length,
                itemBuilder: (context, index) {
                  final file = fileViewModel.files[index];
                  return ListTile(
                    title: Text(file.fileName),
                    onTap: () async {
                      await fileViewModel.readSingleFile(file.fileId);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text("إنشاء ملف جديد"),
                onPressed: () => createFile(context),
              ),
            ),
          ],
        );
      }),
    );
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
          TextButton(onPressed: () => Navigator.pop(context), child: Text("إلغاء")),
          TextButton(
            onPressed: () async {
              String fileName = _fileNameController.text.trim();
              if (fileName.isNotEmpty) {
                await fileViewModel.createFile(
                  fileName,
                  jsonEncode({"content": "// Start coding here"}),
                );
                if (mounted) {
                  Navigator.pop(context);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("يرجى إدخال اسم الملف")),
                );
              }
            },
            child: Text("إنشاء"),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, FileViewModel fileViewModel) {
    if (fileViewModel.selectedFile == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("حذف الملف"),
        content: Text("هل أنت متأكد أنك تريد حذف هذا الملف؟ لا يمكن التراجع عن هذا الإجراء."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("إلغاء")),
          TextButton(
            onPressed: () async {
              int fileId = fileViewModel.selectedFile!.fileId;
              await fileViewModel.deleteFile(fileId);

              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تم حذف الملف بنجاح")),
                );
              }
            },
            child: Text("حذف", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';
import 'package:graduation_project/core/routes/app_routes_name.dart';
import '../manager/file_view_model.dart';

class CodeEditorScreen extends StatefulWidget {
  @override
  _CodeEditorScreenState createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  late TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();

    // استدعاء جلب الملفات بعد بناء الـ context
    Future.microtask(() {
      final fileViewModel = Provider.of<FileViewModel>(context, listen: false);
      fileViewModel.fetchAllFiles();
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

    return Scaffold(
      appBar: AppBar(
        title: Text(fileViewModel.selectedFile?.fileName ?? "Code Editor"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if (fileViewModel.selectedFile != null) {
                await fileViewModel.updateFile(
                  fileViewModel.selectedFile!.fileId,
                  newFileContent: _codeController.text,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تم حفظ الملف بنجاح")),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authViewModel.logout();
              Navigator.pushReplacementNamed(context, AppRoutesName.loginScreen);
            },
          ),
        ],
      ),
      drawer: buildFileExplorer(context),
      body: Consumer<FileViewModel>(
        builder: (context, fileVM, _) {
          if (fileVM.selectedFile != null &&
              _codeController.text != fileVM.selectedFile!.fileContent) {
            _codeController.text = fileVM.selectedFile!.fileContent;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _codeController,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          );
        },
      ),
    );
  }

  Widget buildFileExplorer(BuildContext context) {
    return Drawer(
      child: Consumer<FileViewModel>(
        builder: (context, fileViewModel, _) {
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
                        Navigator.pop(context);
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
        },
      ),
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
                await fileViewModel.createFile(fileName, "// Start coding here");
                Navigator.pop(context);
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

}

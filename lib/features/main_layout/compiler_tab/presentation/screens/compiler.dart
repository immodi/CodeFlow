import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:graduation_project/features/main_layout/compiler_tab/presentation/widgets/bottom_buttons.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/cs.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:graduation_project/features/file_managment/presentation/manager/file_view_model.dart';
import 'package:graduation_project/features/main_layout/compiler_tab/presentation/manager/compile_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../../core/routes/app_routes_name.dart';
import '../../../../file_managment/data/models/file_detail_model.dart';

class CompilerScreen extends StatefulWidget {
  const CompilerScreen({super.key});

  @override
  State<CompilerScreen> createState() => _CompilerScreenState();
}

class _CompilerScreenState extends State<CompilerScreen> {
  late CodeController _codeController;
  String? selectedLanguage;
  final Map<String, dynamic> languageMap = {
    "python": python,
    "javascript": javascript,
    "csharp": cs,
    "java": java,
  };

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(text: '', language: python);

    Future.microtask(() {
      Provider.of<CompileViewModel>(
        context,
        listen: false,
      ).fetchSupportedLanguages();
      _loadFileContent();
    });
  }

  void _loadFileContent() {
    final fileViewModel = Provider.of<FileViewModel>(context, listen: false);
    if (fileViewModel.selectedFile != null) {
      _updateCodeController(fileViewModel.selectedFile!);
    }
  }

  void _updateCodeController(FileDetailModel file) {
    setState(() {
      _codeController = CodeController(
        text: file.fileContent ?? '',
        language: languageMap[selectedLanguage] ?? python,
      );
    });
  }

  Future<void> _executeCode(BuildContext context) async {
    final navigatorKey = Navigator.of(context);
    FocusManager.instance.primaryFocus?.unfocus();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final compiler = Provider.of<CompileViewModel>(context, listen: false);
      await compiler.compileCode(selectedLanguage!, _codeController.text);

      navigatorKey.pop();

      if (compiler.compileResult != null) {
        print('Compile Result: ${compiler.compileResult?.output}');
        await navigatorKey.pushNamed(
          AppRoutesName.output,
          arguments: compiler.compileResult,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compilation returned no output')),
        );
      }
    } catch (e) {
      navigatorKey.pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CompileViewModel, FileViewModel>(
      builder: (context, compiler, fileViewModel, child) {
        final languages = compiler.rootModel?.supportedLanguages ?? [];

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.gray,
            iconTheme: const IconThemeData(color: AppColors.white),
            title: Row(
              children: [
                Text(
                  fileViewModel.selectedFile?.fileName ??
                      'No file selected', // إذا كان fileName فارغًا، يعرض "No file selected"
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  hint: const Text(
                    '+ Select Language',
                    style: TextStyle(color: AppColors.white),
                  ),
                  value: selectedLanguage,
                  dropdownColor: AppColors.gray,
                  style: const TextStyle(color: AppColors.white),
                  items:
                      languages.map((lang) {
                        return DropdownMenuItem<String>(
                          value: lang,
                          child: Text(lang),
                        );
                      }).toList(),
                  onChanged: (newLang) {
                    setState(() {
                      selectedLanguage = newLang;
                      _codeController.language = languageMap[newLang] ?? python;
                    });
                  },
                ),
                const Spacer(),
                InkWell(
                  onTap:
                      compiler.isLoading ? null : () => _executeCode(context),
                  child: const Icon(
                    Icons.play_arrow_outlined,
                    color: AppColors.white,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.gray,
          body: Column(
            children: [
              Expanded(
                child: CodeTheme(
                  data: CodeThemeData(styles: monokaiSublimeTheme),
                  child: CodeField(
                    controller: _codeController,
                    expands: true,
                    wrap: true,
                    background: AppColors.gray,
                    textStyle: const TextStyle(fontSize: 14),
                    gutterStyle: GutterStyle(
                      textStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.07,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                color: AppColors.lightGray,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.save, color: AppColors.white),
                      onPressed: () async {
                        if (fileViewModel.selectedFile == null) return;

                        int? fileId = fileViewModel.selectedFile?.fileId;
                        if (fileId == null) return;

                        String newContent = _codeController.text;
                        await fileViewModel.updateFile(
                          fileId,
                          newFileContent: newContent,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("تم حفظ الملف بنجاح")),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: AppColors.white,
                      ),
                      onPressed: () async {

                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: AppColors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

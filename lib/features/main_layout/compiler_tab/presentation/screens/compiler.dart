import 'package:flutter/material.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:graduation_project/features/file_managment/presentation/manager/file_view_model.dart';
import 'package:graduation_project/features/main_layout/compiler_tab/presentation/manager/compile_view_model.dart';
import 'package:provider/provider.dart';

class Compiler extends StatefulWidget {
  const Compiler({super.key});

  @override
  State<Compiler> createState() => _CompilerState();
}

class _CompilerState extends State<Compiler> {
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    final compileVM = Provider.of<CompileViewModel>(context, listen: false);
    compileVM.fetchSupportedLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CompileViewModel, FileViewModel>(
      builder: (context, compiler, file, child) {
        final languages = compiler.rootModel?.supportedLanguages ?? [];

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.gray,
            iconTheme: IconThemeData(color: AppColors.white),
            title: DropdownButton<String>(
              hint: Text('+ Select Language', style: TextStyle(color: AppColors.white)),
              value: selectedLanguage,
              dropdownColor: AppColors.gray,
              style: TextStyle(color: AppColors.white),
              items: languages.map((lang) {
                return DropdownMenuItem<String>(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value;
                });
              },
            ),
          ),
          backgroundColor: AppColors.gray,
        );
      },
    );
  }
}



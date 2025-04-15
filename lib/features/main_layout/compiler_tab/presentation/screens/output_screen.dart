import 'package:flutter/material.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import '../../data/models/compile_model.dart';

class OutputScreen extends StatelessWidget {
  const OutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)?.settings.arguments as CompileModel?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Output:',
              style: TextStyle(color: AppColors.white, fontSize: 20,fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Text(
                result?.output ?? 'No output available',
                style: const TextStyle(color: AppColors.white,fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import '../../data/models/compile_model.dart';

class OutputScreen extends StatelessWidget {
  const OutputScreen({super.key});

  String _formatOutput(String? output) {
    if (output == null) return 'No output available';

    // Trim whitespace and normalize line endings
    String trimmed = output.trim().replaceAll('\r\n', '\n');

    // Remove excessive empty lines (more than 2 consecutive)
    trimmed = trimmed.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    return trimmed;
  }

  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)?.settings.arguments as CompileModel?;
    final formattedOutput = _formatOutput(result?.output);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
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
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      formattedOutput,
                      style: TextStyle(
                        color: result?.isSuccess == true
                            ? Colors.green[200]
                            : Colors.red[400],
                        fontSize: 16,
                        fontFamily: 'Monospace',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
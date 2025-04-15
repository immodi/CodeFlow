import 'package:flutter/material.dart';
import '../../data/models/file_model.dart';
import '../../data/models/file_shared_model.dart';
import '../../data/models/read_file_shared_model.dart';
import '../../data/models/file_detail_model.dart';
import '../../domain/use_cases/file_use_case.dart';

class FileViewModel extends ChangeNotifier {
  final FileUseCase fileUseCase;
  final String token;

  bool isLoading = false;
  String? errorMessage;
  List<FileModel> files = [];
  FileDetailModel? selectedFile;
  bool isDeleted = false;
  String? shareUrl;

  FileViewModel({required this.fileUseCase, required this.token});

  Future<T?> _execute<T>(Future<T> Function() operation) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      return await operation();
    } catch (e) {
      errorMessage = e.toString();
      print("❌ Error: $e");
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllFiles() async {
    files = await _execute(() => fileUseCase.readAllFiles(token)) ?? [];
    print("📂 Fetched Files (${files.length}): $files");
  }

  Future<void> readSingleFile(int fileId) async {
    print("🔍 Fetching File with ID: $fileId");

    final file = await _execute(() => fileUseCase.readSingleFile(token, fileId));

    if (file != null) {
      selectedFile = file;
      print("📄 Selected File: ${file.fileName}, ID: ${file.fileId}");
      notifyListeners();
    } else {
      print("❌ File not found or access denied");
      throw Exception(errorMessage ?? "Failed to load file");
    }
  }


  Future<void> createFile(String fileName, String fileContent) async {
    final newFile = await _execute(() => fileUseCase.createFile(token, fileName, fileContent));

    if (newFile != null) {
      files.add(newFile);
      print("✅ File Created with ID: ${newFile.fileId}");
      notifyListeners();
    } else {
      print("❌ Failed to create file.");
    }
  }


  Future<void> updateFile(int fileId, {String? newFileName, String? newFileContent}) async {
    final updatedFile = await _execute(() => fileUseCase.updateFile(
        token, fileId, newFileName: newFileName, newFileContent: newFileContent));

    if (updatedFile != null) {
      int index = files.indexWhere((file) => file.fileId == fileId);
      if (index != -1) {
        files[index] = updatedFile;
      }

      if (selectedFile?.fileId == fileId) {
        selectedFile = selectedFile!.copyWith(
          fileName: newFileName ?? selectedFile!.fileName,
          fileContent: newFileContent ?? selectedFile!.fileContent,
        );
      }
      print("✅ File Loaded: ${selectedFile?.fileName}, ID: ${selectedFile?.fileId}");      notifyListeners();
    }
  }

  Future<void> deleteFile(int fileId) async {
    isDeleted = await _execute(() => fileUseCase.deleteFile(token, fileId)) ?? false;

    if (isDeleted) {
      files.removeWhere((file) => file.fileId == fileId);
      if (selectedFile?.fileId == fileId) {
        selectedFile = null;
      }
      print("🗑️ Deleted File (ID: $fileId)");
      notifyListeners();
    }
  }

  Future<FileShareModel?> shareFile(int fileId) async {
    final shareData = await _execute(() => fileUseCase.sharedFile(token, fileId));
    if (shareData != null) {
      shareUrl = shareData.fileShareUrl;
      print("🔗 Shared File URL: $shareUrl");
      notifyListeners();
    }
    return shareData;
  }

  Future<ReadSharedFileModel?> readSharedFile(String fileShareUrl) async {
    final sharedFile = await _execute(() => fileUseCase.readSharedFile(fileShareUrl));
    if (sharedFile != null) {
      shareUrl = fileShareUrl;
      print("📜 Read Shared File: $sharedFile");
      notifyListeners();
    }
    return sharedFile;
  }

  void clearShareUrl() {
    shareUrl = null;
    print("🚫 Share URL cleared");
    notifyListeners();
  }
}

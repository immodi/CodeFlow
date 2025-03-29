
import '../../data/models/file_detail_model.dart';
import '../../data/models/file_model.dart';
import '../../data/models/file_shared_model.dart';
import '../../data/models/read_file_shared_model.dart';
import '../repo/file_repository.dart';

class FileUseCase {
  final FileRepository repository;

  FileUseCase({required this.repository});

  Future<List<FileModel>> readAllFiles(String token) => repository.readAllFiles(token);
  Future<FileDetailModel> readSingleFile(String token, int fileId) => repository.readSingleFile(token, fileId);
  Future<FileModel> createFile(String token, String fileName, String fileContent) => repository.createFile(token, fileName, fileContent);
  Future<FileModel> updateFile(String token, int fileId, {String? newFileName, String? newFileContent}) => repository.updateFile(token, fileId, newFileName: newFileName, newFileContent: newFileContent);
  Future<bool> deleteFile(String token, int fileId) => repository.deleteFile(token, fileId);
  Future<FileShareModel> sharedFile(String token, int fileId) => repository.sharedFile(token, fileId);
  Future<ReadSharedFileModel> readSharedFile(String fileShareUrl) => repository.readSharedFile(fileShareUrl);
}

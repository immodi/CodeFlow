
import '../models/file_detail_model.dart';
import '../models/file_model.dart';
import '../models/file_shared_model.dart';
import '../models/read_file_shared_model.dart';
import '../models/update_shared_file_model.dart';

abstract class FileRemoteDataSource {
  Future<List<FileModel>>  readAllFiles(String token);
  Future<FileDetailModel> readSingleFile (String token , int fileId);
  Future<FileModel> createFile(String token, String fileName, String fileContent);
  Future<FileModel> updateFile(String token, int fileId, {String? newFileName, String? newFileContent});
  Future<bool> deleteFile(String token, int fileId);
  Future<FileShareModel> shareFile(String token, int fileId);
  Future<ReadSharedFileModel> readSharedFile(String fileShareUrl);
  Future<UpdateSharedFileModel> updateSharedFile({
    required String fileShareCode,
    String? newFileName,
    String? newFileContent,
  });



}
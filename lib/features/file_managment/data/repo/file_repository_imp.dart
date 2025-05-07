import '../../domain/repo/file_repository.dart';
import '../data_source/file_remote_data_source.dart';
import '../models/file_detail_model.dart';
import '../models/file_model.dart';
import '../models/file_shared_model.dart';
import '../models/read_file_shared_model.dart';
import '../models/update_shared_file_model.dart';

class FileRepositoryImpl implements FileRepository {
  final FileRemoteDataSource remoteDataSource;

  FileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<FileModel>> readAllFiles(String token) => remoteDataSource.readAllFiles(token);

  @override
  Future<FileDetailModel> readSingleFile(String token, int fileId) => remoteDataSource.readSingleFile(token, fileId);

  @override
  Future<FileModel> createFile(String token, String fileName, String fileContent) => remoteDataSource.createFile(token, fileName, fileContent);

  @override
  Future<FileModel> updateFile(String token, int fileId, {String? newFileName, String? newFileContent}) => remoteDataSource.updateFile(token, fileId, newFileName: newFileName, newFileContent: newFileContent);

  @override
  Future<bool> deleteFile(String token, int fileId) => remoteDataSource.deleteFile(token, fileId);
  @override
  Future<FileShareModel> sharedFile(String token, int fileId) => remoteDataSource.shareFile(token, fileId);

  @override
  Future<ReadSharedFileModel> readSharedFile(String fileShareUrl) => remoteDataSource.readSharedFile(fileShareUrl);
  @override
  Future<UpdateSharedFileModel> updateSharedFile({
    required String fileShareCode,
    String? newFileName,
    String? newFileContent,
  }) => remoteDataSource.updateSharedFile(
    fileShareCode: fileShareCode,
    newFileName: newFileName,
    newFileContent: newFileContent,
  );


}

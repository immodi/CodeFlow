import 'package:dio/dio.dart';
import '../../../../core/services/network_services.dart';
import '../models/file_detail_model.dart';
import '../models/file_model.dart';
import '../models/file_shared_model.dart';
import '../models/read_file_shared_model.dart';
import 'file_remote_data_source.dart';

class FileRemoteDataSourceImpl implements FileRemoteDataSource {
  final NetworkServices networkServices;

  FileRemoteDataSourceImpl({required this.networkServices});

  @override
  Future<List<FileModel>> readAllFiles(String token) async {

    print("Headers being sent: ${networkServices.dio.options.headers}");
    print("Final Request URL: ${networkServices.dio.options.baseUrl}file/all");


    final response = await networkServices.dio.get(
      'file/all',
      data: {},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final List filesJson = response.data['files'];
    return filesJson.map((json) => FileModel.fromJson(json)).toList();
  }



  @override
  Future<FileModel> createFile(String token, String fileName, String fileContent) async {
    final response = await networkServices.dio.post(
      'file',
      data: {"fileName": fileName, "fileContent": fileContent},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return FileModel.fromJson(response.data);
  }

  @override
  Future<FileModel> updateFile(String token, int fileId, {String? newFileName, String? newFileContent}) async {
    final response = await networkServices.dio.patch(
      'file',
      data: {
        "fileId": fileId,
        "newFileName": newFileName,
        "newFileContent": newFileContent
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return FileModel.fromJson(response.data);
  }

  @override
  Future<bool> deleteFile(String token, int fileId) async {
    final response = await networkServices.dio.delete(
      'file',
      data: {"fileId": fileId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data['isDeleted'] ?? false;
  }
  @override
  Future<FileShareModel> shareFile(String token, int fileId) async {
    final response = await networkServices.dio.post(
      'share',
      data: {"fileId": fileId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return FileShareModel.fromJson(response.data);
  }

  @override
  Future<ReadSharedFileModel> readSharedFile(String fileShareUrl) async {
    final response = await networkServices.dio.get(
      'share',
      queryParameters: {"fileShareUrl": fileShareUrl},
    );
    return ReadSharedFileModel.fromJson(response.data);
  }


  @override
  Future<FileDetailModel> readSingleFile(String token, int fileId) async {
    final response = await networkServices.dio.get(
      'file',
      queryParameters: {"fileId": fileId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return FileDetailModel.fromJson(response.data, fileId);
  }






}

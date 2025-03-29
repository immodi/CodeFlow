class FileModel {
  final int fileId;
  final String fileName;
  final int fileSizeInBytes;

  FileModel({
    required this.fileId,
    required this.fileName,
    required this.fileSizeInBytes,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      fileId: json['fileId'],
      fileName: json['fileName'],
      fileSizeInBytes: json['fileSizeInBytes'],
    );
  }
}

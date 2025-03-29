class FileDetailModel {
  final int fileId;
  final String fileName;
  final String fileContent;
  final String fileCreationDate;
  final String lastModifiedDate;
  final int fileSizeInBytes;

  FileDetailModel({
    required this.fileId,
    required this.fileName,
    required this.fileContent,
    required this.fileCreationDate,
    required this.lastModifiedDate,
    required this.fileSizeInBytes,
  });

  // ✅ إضافة fromJson
  factory FileDetailModel.fromJson(Map<String, dynamic> json, int fileId) {
    return FileDetailModel(
      fileId: fileId,
      fileName: json['fileName'] ?? '',
      fileContent: json['fileContent'] ?? '',
      fileCreationDate: json['fileCreationDate'] ?? '',
      lastModifiedDate: json['lastModifiedDate'] ?? '',
      fileSizeInBytes: json['fileSizeInBytes'] ?? 0,
    );
  }

  // ✅ إضافة copyWith
  FileDetailModel copyWith({
    int? fileId,
    String? fileName,
    String? fileContent,
    String? fileCreationDate,
    String? lastModifiedDate,
    int? fileSizeInBytes,
  }) {
    return FileDetailModel(
      fileId: fileId ?? this.fileId,
      fileName: fileName ?? this.fileName,
      fileContent: fileContent ?? this.fileContent,
      fileCreationDate: fileCreationDate ?? this.fileCreationDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      fileSizeInBytes: fileSizeInBytes ?? this.fileSizeInBytes,
    );
  }
}

class UpdateSharedFileModel {
  final String fileName;
  final String fileContent;
  final String fileCreationDate;
  final String lastModifiedDate;
  final int fileSizeInBytes;
  final String dateTime;
  final int statusCode;

  UpdateSharedFileModel({
    required this.fileName,
    required this.fileContent,
    required this.fileCreationDate,
    required this.lastModifiedDate,
    required this.fileSizeInBytes,
    required this.dateTime,
    required this.statusCode,
  });

  factory UpdateSharedFileModel.fromJson(Map<String, dynamic> json) {
    return UpdateSharedFileModel(
      fileName: json['fileName'],
      fileContent: json['fileContent'],
      fileCreationDate: json['fileCreationDate'],
      lastModifiedDate: json['lastModifiedDate'],
      fileSizeInBytes: json['fileSizeInBytes'],
      dateTime: json['dateTime'],
      statusCode: json['statusCode'],
    );
  }
}

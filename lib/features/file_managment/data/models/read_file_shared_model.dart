class ReadSharedFileModel {
  final String fileName;
  final String fileContent;
  final int fileSizeInBytes;
  final String dateTime;
  final int statusCode;

  ReadSharedFileModel({
    required this.fileName,
    required this.fileContent,
    required this.fileSizeInBytes,
    required this.dateTime,
    required this.statusCode,
  });

  factory ReadSharedFileModel.fromJson(Map<String, dynamic> json) {
    return ReadSharedFileModel(
      fileName: json['fileName'],
      fileContent: json['fileContent'],
      fileSizeInBytes: json['fileSizeInBytes'],
      dateTime: json['dateTime'],
      statusCode: json['statusCode'],
    );
  }
}

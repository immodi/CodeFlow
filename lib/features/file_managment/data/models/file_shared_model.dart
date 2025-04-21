class FileShareModel {
  final String fileShareCode;
  final String dateTime;
  final int statusCode;

  FileShareModel({
    required this.fileShareCode,
    required this.dateTime,
    required this.statusCode,
  });

  factory FileShareModel.fromJson(Map<String, dynamic> json) {
    return FileShareModel(
      fileShareCode: json['fileShareCode'], // ← تعديل المفتاح
      dateTime: json['dateTime'],
      statusCode: json['statusCode'],
    );
  }
}

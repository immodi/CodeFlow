class FileShareModel {
  final String fileShareUrl;
  final String dateTime;
  final int statusCode;

  FileShareModel({
    required this.fileShareUrl,
    required this.dateTime,
    required this.statusCode,
  });

  factory FileShareModel.fromJson(Map<String, dynamic> json) {
    return FileShareModel(
      fileShareUrl: json['fileShareUrl'],
      dateTime: json['dateTime'],
      statusCode: json['statusCode'],
    );
  }
}

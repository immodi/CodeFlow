class CompileModel {
  final String dateTime;
  final int statusCode;
  final String output;
  final bool? isSuccess;

  CompileModel({
    required this.dateTime,
    required this.statusCode,
    required this.output,
    this.isSuccess,
  });

  factory CompileModel.fromJson(Map<String, dynamic> json) {
    return CompileModel(
      dateTime: json["dateTime"],
      statusCode: json["statusCode"],
      output: json["output"] ?? "",
      isSuccess: json["isSuccess"],
    );
  }
}

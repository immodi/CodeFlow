class CompileModel {
  final String dateTime;
  final int statusCode;
  final String output;
  final String? errorMessage;

  CompileModel({
    required this.dateTime,
    required this.statusCode,
    required this.output,
    this.errorMessage,
  });

  factory CompileModel.fromJson(Map<String, dynamic> json) {
    return CompileModel(
      dateTime: json["dateTime"],
      statusCode: json["statusCode"],
      output: json["output"] ?? "",
      errorMessage: json["errorMessage"],
    );
  }
}

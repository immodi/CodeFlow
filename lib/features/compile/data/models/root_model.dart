class RootModel {
  final String dateTime;
  final int statusCode;
  final List<String> supportedLanguages;

  RootModel({
    required this.dateTime,
    required this.statusCode,
    required this.supportedLanguages,
  });

  factory RootModel.fromJson(Map<String, dynamic> json) {
    return RootModel(
      dateTime: json["dateTime"],
      statusCode: json["statusCode"],
      supportedLanguages: List<String>.from(json["supportedLanguages"]),
    );
  }
}

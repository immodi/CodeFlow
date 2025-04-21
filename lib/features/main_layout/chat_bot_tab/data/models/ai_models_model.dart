class AiModelsResponse {
  final List<String> allModels;
  final String dateTime;
  final int statusCode;
  final String? errorMessage;

  AiModelsResponse({
    required this.allModels,
    required this.dateTime,
    required this.statusCode,
    this.errorMessage,
  });

  factory AiModelsResponse.fromJson(Map<String, dynamic> json) {
    return AiModelsResponse(
      allModels: List<String>.from(json['allModels'] ?? []),
      dateTime: json['dateTime'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      errorMessage: json['errorMessage'],
    );
  }
}

class ChatBotModel {
  final String response;
  final String dateTime;
  final int statusCode;

  ChatBotModel({
    required this.response,
    required this.dateTime,
    required this.statusCode,
  });

  factory ChatBotModel.fromJson(Map<String, dynamic> json) {
    return ChatBotModel(
      response: json['response'] ?? '',
      dateTime: json['dateTime'] ?? '',
      statusCode: json['statusCode'] ?? 0,
    );
  }
}
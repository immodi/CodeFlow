class ChatBotModel {
  final String message;
  final String response;
  final String dateTime;
  final int statusCode;

  ChatBotModel({
    required this.response,
    required this.message,
    required this.dateTime,
    required this.statusCode,
  });

  factory ChatBotModel.fromJson(Map<String, dynamic> json,String message) {
    return ChatBotModel(
      message: message ,
      response: json['response'] ?? '',
      dateTime: json['dateTime'] ?? '',
      statusCode: json['statusCode'] ?? 0,
    );
  }
}
import 'package:graduation_project/features/main_layout/chat_bot_tab/data/data_source/chatBot_data_source.dart';
import '../../../../../core/services/network_services.dart';
import '../models/chat_bot_model.dart';

class ChatBotDataSourceImpl implements ChatbotDataSource {
  final NetworkServices networkServices;

  ChatBotDataSourceImpl({required this.networkServices});

  @override
  Future<ChatBotModel> sendMessage(String message) async {
    try {
      final response = await networkServices.dio.post(
        "ai",
        data: {
          "message": message,
        },
      );

      if (response.statusCode == 200) {
        return ChatBotModel.fromJson(response.data);
      } else {
        throw Exception("Failed to get response: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error sending message to AI: $e");
    }
  }


}

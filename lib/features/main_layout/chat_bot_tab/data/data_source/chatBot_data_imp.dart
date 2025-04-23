import 'package:graduation_project/features/main_layout/chat_bot_tab/data/data_source/chatBot_data_source.dart';
import 'package:graduation_project/features/main_layout/chat_bot_tab/data/models/ai_models_model.dart';
import '../../../../../core/services/network_services.dart';
import '../models/chat_bot_model.dart';

class ChatBotDataSourceImpl implements ChatBotDataSource {
  final NetworkServices networkServices;

  ChatBotDataSourceImpl({required this.networkServices});

  @override
  Future<ChatBotModel> sendMessage(String message, [String? model]) async {
    try {
      final response = await networkServices.dio.post(
        "ai",
        data: {
          if (model != null) "model": model,
          "message": message,
        },
      );

      if (response.statusCode == 200) {
        return ChatBotModel.fromJson(response.data, message);
      } else {
        throw Exception("Failed to get response: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error sending message to AI: $e");
    }
  }

  @override
  Future<AiModelsResponse> getModels() async {
    try {
      final response = await networkServices.dio.get(
        "ai/models",
        data: {},
      );

      if (response.statusCode == 200) {
        return AiModelsResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to get response: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting AI models: $e");
    }
  }

}





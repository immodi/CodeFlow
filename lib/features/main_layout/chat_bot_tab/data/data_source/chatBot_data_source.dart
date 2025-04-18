import 'package:graduation_project/features/main_layout/chat_bot_tab/data/models/chat_bot_model.dart';

abstract class ChatbotDataSource {
 Future<ChatBotModel> sendMessage(String message);
}
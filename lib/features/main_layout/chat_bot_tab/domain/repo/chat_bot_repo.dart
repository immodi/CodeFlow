
import '../../data/models/chat_bot_model.dart';

abstract class ChatBotRepository {
  Future<ChatBotModel> sendMessage(String message);
}


import '../../data/models/chat_bot_model.dart';
import '../repo/chat_bot_repo.dart';

class ChatBotUseCase {
  final ChatBotRepository chatBotRepository;

  ChatBotUseCase(this.chatBotRepository);

  Future<ChatBotModel> sendMessage(String message) {
    return chatBotRepository.sendMessage(message);
  }
}

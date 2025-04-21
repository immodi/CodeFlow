
import 'package:graduation_project/features/main_layout/chat_bot_tab/data/models/ai_models_model.dart';
import '../../data/models/chat_bot_model.dart';
import '../repo/chat_bot_repo.dart';

class ChatBotUseCase {
  final ChatBotRepository chatBotRepository;

  ChatBotUseCase(this.chatBotRepository);

  Future<ChatBotModel> sendMessage(String message,[String? model]) {
    return chatBotRepository.sendMessage(message,model);
  }
  Future<AiModelsResponse>getModels(){
    return chatBotRepository.getModels();
  }
}

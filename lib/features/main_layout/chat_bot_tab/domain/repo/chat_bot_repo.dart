
import 'package:graduation_project/features/main_layout/chat_bot_tab/data/models/ai_models_model.dart';

import '../../data/models/chat_bot_model.dart';

abstract class ChatBotRepository {
  Future<ChatBotModel> sendMessage(String message, [String? model]);
  Future<AiModelsResponse> getModels();
}

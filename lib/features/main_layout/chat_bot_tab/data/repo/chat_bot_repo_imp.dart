import 'package:graduation_project/features/main_layout/chat_bot_tab/data/data_source/chatBot_data_imp.dart';

import '../../domain/repo/chat_bot_repo.dart';
import '../models/chat_bot_model.dart';

class ChatBotRepositoryImpl implements ChatBotRepository {
  final ChatBotDataSourceImpl chatBotDataSource;

  ChatBotRepositoryImpl({required this.chatBotDataSource});

  @override
  Future<ChatBotModel> sendMessage(String message) {
    return chatBotDataSource.sendMessage(message);
  }
}

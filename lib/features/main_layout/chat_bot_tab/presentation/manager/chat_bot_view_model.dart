import 'package:flutter/material.dart';

import '../../data/models/chat_bot_model.dart';
import '../../domain/use_cases/chat_bot_use_case.dart';

class ChatBotViewModel extends ChangeNotifier {
  final ChatBotUseCase chatBotUseCase;

  bool isLoading = false;
  String? errorMessage;
  List<ChatBotModel> messages = [];

  ChatBotViewModel({required this.chatBotUseCase});

  Future<void> sendMessage(String message) async {
    isLoading = true;
    errorMessage = null;

    // أضف رسالة المرسل قبل ما تبعت للـ API
    messages.add(ChatBotModel(
      message: message,
      response: '',
      dateTime: DateTime.now().toString(),
      statusCode: 200,
    ));

    notifyListeners();

    try {
      final response = await chatBotUseCase.sendMessage(message);
      messages.add(response); // أضف رسالة الـ AI
      print("🤖 AI: ${response.response}");
    } catch (e) {
      errorMessage = e.toString();
      print("❌ ChatBot Error: $errorMessage");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  void clearMessages() {
    messages.clear();
    notifyListeners();
  }
}

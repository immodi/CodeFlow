import 'package:flutter/material.dart';
import '../../data/models/chat_bot_model.dart';
import '../../domain/use_cases/chat_bot_use_case.dart';

class ChatBotViewModel extends ChangeNotifier {
  final ChatBotUseCase chatBotUseCase;

  bool isLoading = false;
  String? errorMessage;
  List<ChatBotModel> messages = [];
  List<String> aiModels = [];

  ChatBotViewModel({required this.chatBotUseCase});

  Future<void> sendMessage(String message, {String? model}) async {
    isLoading = true;
    errorMessage = null;

    messages.add(ChatBotModel(
      message: message,
      response: '',
      dateTime: DateTime.now().toString(),
      statusCode: 200,
    ));

    notifyListeners();

    try {
      final response = await chatBotUseCase.sendMessage(message, model);
      messages.add(response);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getModels() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await chatBotUseCase.getModels();
      aiModels = result.allModels;
    } catch (e) {
      errorMessage = e.toString();
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

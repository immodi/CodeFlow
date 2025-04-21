import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:graduation_project/core/app_assets/app_assets.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../manager/chat_bot_view_model.dart';


class ChatBotScreen extends StatefulWidget {
  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  String? selectedModel;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<ChatBotViewModel>(context, listen: false);
    viewModel.getModels(); // تحميل الموديلات من الAPI
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<ChatBotViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.gray,
          appBar: AppBar(
            backgroundColor: AppColors.gray,
            title: Row(
              children: [
                Image.asset(AppAssets.appLogo, width: size.width * 0.2),
                const SizedBox(width: 10),
                const Text('Code Flow ChatBOT', style: TextStyle(color: AppColors.white, fontSize: 13)),
              ],
            ),
          ),
          body: Column(
            children: [
              /// 🧠 Dropdown لاختيار الموديل
              if (viewModel.aiModels.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: AppColors.lightGray,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.lightGray,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      labelText: 'Choose a model',
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
                    value: selectedModel,
                    items: viewModel.aiModels.map((model) {
                      return DropdownMenuItem<String>(
                        value: model,
                        child: Text(model, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedModel = value;
                      });
                    },
                  ),
                ),

              /// 📨 الرسائل
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: viewModel.messages.length,
                  itemBuilder: (context, index) {
                    final message = viewModel.messages[index];
                    final isSender = message.response == '' && message.message.isNotEmpty;
                    final textToDisplay = isSender ? message.message : message.response;

                    return Align(
                      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
                      child: ChatBubble(
                        clipper: isSender
                            ? ChatBubbleClipper1(type: BubbleType.sendBubble)
                            : ChatBubbleClipper1(type: BubbleType.receiverBubble),
                        alignment: isSender ? Alignment.topRight : Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 10),
                        backGroundColor: AppColors.lightGray!,
                        child: Text(
                          textToDisplay,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (viewModel.isLoading) const CircularProgressIndicator(),

              if (viewModel.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${viewModel.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              /// ✍️ كتابة الرسالة وزر الإرسال
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.lightGray,
                        ),
                        child: TextField(
                          controller: _messageController,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Ask Anything',
                            hintStyle: TextStyle(color: AppColors.moreLightGray, fontSize: 13),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => _sendMessage(context),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () => _sendMessage(context),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _sendMessage(BuildContext context) {
    final viewModel = Provider.of<ChatBotViewModel>(context, listen: false);
    final message = _messageController.text.trim();

    if (message.isNotEmpty) {
      viewModel.sendMessage(message, model: selectedModel);
      _messageController.clear();
    }
  }
}






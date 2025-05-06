import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:graduation_project/core/app_assets/app_assets.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../manager/chat_bot_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';




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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatBotViewModel>(context, listen: false).getModels();
    });
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
            title: Text('ChatBot',style: TextStyle(color: AppColors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            centerTitle: true,
          ),
          body: Column(
            children: [
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
                        child: _buildMessageContent(textToDisplay, isSender),


                      ),
                    );
                  },
                ),
              ),

              if (viewModel.isLoading)
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Lottie.asset('assets/animation/chatBotLoader.json'),
                ),

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
  Widget _buildMessageContent(String text, bool isSender) {
    final codeRegExp = RegExp(r"```(\w+)?\n([\s\S]*?)```", multiLine: true);
    final matches = codeRegExp.allMatches(text);

    List<Widget> parts = [];
    int currentIndex = 0;

    for (final match in matches) {
      if (match.start > currentIndex) {
        final normalText = text.substring(currentIndex, match.start);
        parts.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              normalText.trim(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }

      // كود
      final language = match.group(1) ?? 'plaintext';
      final code = match.group(2) ?? '';

      parts.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: HighlightView(
                code,
                language: language,
                theme: monokaiSublimeTheme,
                padding: const EdgeInsets.all(8),
                textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 13),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Code copied to clipboard")),
                  );
                },
                icon: const Icon(Icons.copy, size: 16,color: AppColors.white,),
                label: const Text("Copy"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.only(right: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ],
        ),
      );

      // نحدث المؤشر
      currentIndex = match.end;
    }

    // باقي النص بعد آخر كود
    if (currentIndex < text.length) {
      final remaining = text.substring(currentIndex);
      parts.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            remaining.trim(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parts,
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






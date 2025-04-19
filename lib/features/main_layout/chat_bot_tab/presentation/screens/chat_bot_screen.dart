// import 'package:flutter/material.dart';
// import 'package:graduation_project/core/app_assets/app_assets.dart';
// import 'package:graduation_project/core/theme/app_colors.dart';
// import 'package:chat_bubbles/chat_bubbles.dart';
//
//
// class ChatBotScreen extends StatelessWidget {
//   const ChatBotScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.gray,
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     AppAssets.appLogo,
//                     width: size.width * 0.3,
//                     height: size.height * 0.09,
//                   ),
//                 ],
//               ),
//               Text(
//                 'Code Flow ChatBot',
//                 style: TextStyle(color: AppColors.white, fontSize: 12),
//               ),
//               // SizedBox(height: size.height*0.26,),
//               // Text(
//               //   'What Can I Help With ',
//               //   style: TextStyle(color: AppColors.white, fontSize: 20),
//               // ),
//
//               // Container(
//               //   padding: EdgeInsets.all(8),
//               //   decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.circular(15),
//               //     color: AppColors.lightGray
//               //   ),
//               //   child: Padding(
//               //     padding:  EdgeInsets.only( left: 10),
//               //     child: TextField(
//               //       style: TextStyle(color: AppColors.white,),
//               //       cursorColor: AppColors.white,
//               //       autocorrect: true,
//               //       decoration: InputDecoration(
//               //         hintText: 'Ask Anything',
//               //         hintStyle: TextStyle(color: AppColors.moreLightGray,fontSize: 13),
//               //         border: InputBorder.none,
//               //
//               //
//               //       ),
//               //     ),
//               //   ),
//               // )
//
//
//
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:graduation_project/core/app_assets/app_assets.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../manager/chat_bot_view_model.dart';

class ChatBotScreen extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();

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
                SizedBox(width: 10,),
                Text('Code Flow ChatBOT',style: TextStyle(color: AppColors.white,fontSize: 13),)
              ],
            ),
          ),
          body: Column(
            children: [
              // قائمة الرسائل
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
                        backGroundColor: isSender ? AppColors.lightGray : AppColors.lightGray!,
                        child: Text(
                          textToDisplay,
                          style: TextStyle(color: isSender ? AppColors.white : AppColors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (viewModel.isLoading)
                CircularProgressIndicator(),

              if (viewModel.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${viewModel.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Text Field
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

                    // Send button
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
      viewModel.sendMessage(message);
      _messageController.clear();
    }
  }
}





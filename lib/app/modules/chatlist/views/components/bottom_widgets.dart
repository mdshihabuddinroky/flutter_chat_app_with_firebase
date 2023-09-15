import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/Theme/colors.dart';
import 'package:flutter_chat_app/app/modules/chatlist/controllers/chatlist_controller.dart';
import 'package:get/get.dart';

class BottomWidgets extends StatelessWidget {
  const BottomWidgets({
    super.key,
    required this.focusNode,
  });
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    final ChatlistController controller = Get.find<ChatlistController>();

    return Container(
      width: 376,
      height: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.50,
            color: const Color.fromARGB(255, 41, 12, 12)
                .withOpacity(0.03999999910593033),
          ),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextFormField(
              focusNode: focusNode,
              controller: messageController,
              decoration: const InputDecoration(
                hintText: "Type a message",
                fillColor: whiteColor,
                disabledBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: whiteColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: whiteColor),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: whiteColor),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          // const Icon(
          //   Icons.emoji_emotions_outlined,
          //   color: Color(0xff353535),
          // ).paddingOnly(left: 10, top: 10, bottom: 10, right: 10),
          const Icon(
            Icons.attach_file,
            color: Color(0xff353535),
          ).paddingOnly(top: 10, bottom: 10, right: 0),
          GestureDetector(
            onTap: () async {
              if (messageController.text.isNotEmpty) {
                await controller.addMessageToConversation(
                  conversationId: Get.arguments['documentId'],
                  messageText: messageController.text,
                  senderId: controller.user!.uid,
                  messageType: "text",
                );
                messageController.clear();
                //focusNode.unfocus();
              }
            },
            child: const Icon(
              Icons.send,
              color: primaryColor,
            ).paddingAll(10),
          ),
        ],
      ),
    );
  }
}

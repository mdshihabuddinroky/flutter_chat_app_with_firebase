import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/modules/chatlist/views/components/bottom_widgets.dart';
import 'package:flutter_chat_app/app/modules/chatlist/views/components/chat_app_bar.dart';
import 'package:flutter_chat_app/app/modules/chatlist/views/components/recived_message_tile.dart';
import 'package:flutter_chat_app/app/modules/chatlist/views/components/send_message_tile.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/message_model.dart';
import '../controllers/chatlist_controller.dart';

class ChatlistView extends StatefulWidget {
  const ChatlistView({Key? key}) : super(key: key);

  @override
  State<ChatlistView> createState() => _ChatlistViewState();
}

class _ChatlistViewState extends State<ChatlistView> {
  final ChatlistController controller = Get.put(ChatlistController());

  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () {
          controller.scrollToBottom();
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the FocusNode
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recievarName = Get.arguments['recieverName'];
    // final recieverImage=Get.arguments['recieverImage'];
    // final recieverFcm=Get.arguments['recieverFcm'];
    final documentId = Get.arguments['documentId'];

    return Scaffold(
      appBar: ChatAppBar(title: recievarName),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: controller.query(documentId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final messageDocuments = snapshot.data!.docs;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.scrollToBottom();
              });
              debugPrint(messageDocuments.length.toString());
              // Process and display message documents
              return Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: messageDocuments.length,
                  itemBuilder: (context, index) {
                    List<MessageModel> data = messageDocuments.map((document) {
                      final documentId = document.id;
                      return MessageModel.fromMap(
                        document.data() as Map<String, dynamic>,
                        documentId,
                      );
                    }).toList();
                    final messageData = data[index];
                    final formattedTime =
                        DateFormat('h:mm a').format(messageData.createdAt);

                    if (controller.user!.uid == messageData.senderId) {
                      return SendMessage(
                        message: messageData.messageText,
                        time: formattedTime,
                      );
                    } else {
                      return RecivedMessage(
                        message: messageData.messageText,
                        time: formattedTime,
                      );
                    }
                  },
                ),
              );
            },
          ),
          BottomWidgets(
            focusNode: focusNode,
          )
        ],
      ).paddingOnly(left: 20, right: 20, bottom: 20, top: 20),
    );
  }
}

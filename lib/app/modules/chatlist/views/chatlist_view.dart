import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Theme/colors.dart';
import '../controllers/chatlist_controller.dart';

class ChatlistView extends GetView<ChatlistController> {
  const ChatlistView({Key? key}) : super(key: key);
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
              debugPrint(messageDocuments.length.toString());
              // Process and display message documents
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: messageDocuments.length,
                  itemBuilder: (context, index) {
                    final message =
                        messageDocuments[index].data() as Map<String, dynamic>;
                    final createdAt = message['created_at'] as Timestamp;
                    // Convert Timestamp to DateTime
                    final createdAtDateTime = createdAt.toDate();

// Format the DateTime in 12-hour time format
                    final formattedTime =
                        DateFormat('h:mm a').format(createdAtDateTime);
                    final messageText = message['message'] as String;
                    // final messageType = message['message_type'] as String;
                    final senderId = message['sender_id'] as String;
                    if (controller.user!.uid == senderId) {
                      return SendMessage(
                        message: messageText,
                        time: formattedTime,
                      );
                    } else {
                      return RecivedMessage(
                        message: messageText,
                        time: formattedTime,
                      );
                    }
                  },
                ),
              );
            },
          ),
          const BottomWidgets()
        ],
      ).paddingOnly(left: 20, right: 20, bottom: 20),
    );
  }
}

class SendMessage extends StatelessWidget {
  const SendMessage({
    super.key,
    required this.message,
    required this.time,
  });
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              width: 267,
              decoration: ShapeDecoration(
                color: secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 12,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: whiteColor,
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.30,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              time,
              style: const TextStyle(
                color: Color(0xFF777A79),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.30,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class RecivedMessage extends StatelessWidget {
  const RecivedMessage({
    super.key,
    required this.message,
    required this.time,
  });
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              width: 267,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 12,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Color(0xFF353535),
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.30,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              time,
              style: const TextStyle(
                color: Color(0xFF777A79),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.30,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class BottomWidgets extends StatelessWidget {
  const BottomWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
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
          const Icon(
            Icons.emoji_emotions_outlined,
            color: Color(0xff353535),
          ).paddingOnly(left: 10, top: 10, bottom: 10, right: 10),
          const Icon(
            Icons.attach_file,
            color: Color(0xff353535),
          ).paddingOnly(top: 10, bottom: 10, right: 0),
          const Icon(
            Icons.send,
            color: primaryColor,
          ).paddingAll(10),
        ],
      ),
    );
  }
}

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            // TODO:add image
            // decoration: const ShapeDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/person.jpeg'),
            //     fit: BoxFit.cover,
            //   ),
            //   shape: OvalBorder(),
            // ),
          ),
          const SizedBox(
            width: 23,
          ),
          Text(title),
        ],
      ),
      centerTitle: true,
      actions: [const Icon(Icons.more_vert_rounded).paddingOnly(right: 20)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

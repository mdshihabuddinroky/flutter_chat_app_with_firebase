import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/modules/chatuser/controllers/chatuser_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Theme/colors.dart';
import '../../../models/conversation_model.dart';
import '../../../routes/app_pages.dart';

class ChatuserView extends GetView<ChatuserController> {
  const ChatuserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
            length: 3,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //  TODO:Search Widget
                  // const SearchWidget(),
                  //TODO:ADD TAB
                  // const SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: CustomTabButtonGroup())
                  //     .paddingOnly(top: 24, bottom: 24),
                  StreamBuilder<QuerySnapshot>(
                    stream: controller.query
                        .snapshots(), // Listen to changes in the query
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Display a loading indicator while data is loading
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      final documents = snapshot.data!.docs;

                      List<ConversationModel> data = documents.map((document) {
                        final documentId = document.id;
                        return ConversationModel.fromMap(documentId,
                            document.data() as Map<String, dynamic>);
                      }).toList();
                      // Now you can use the documents to display your data
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final participants = data[index];
                          final currentUserIndex = participants.participants
                              .indexOf(controller.user!.uid);
                          String recieverName;
                          String recieverImage;
                          String recieverFcm;
                          if (currentUserIndex == 0) {
                            recieverName = participants.participant1Name;
                            recieverImage = participants.participant1Image;
                            recieverFcm = participants.fcm1;
                          } else {
                            recieverName = participants.participant2Name;
                            recieverImage = participants.participant2Image;
                            recieverFcm = participants.fcm2;
                          }
                          return ChatTile(
                            name: participants.participant1Name,
                            message: participants.lastMessage,
                            image: participants.participant1Image,
                            time: DateFormat('h:mm a')
                                .format(participants.lastMessageTime.toDate()),
                            unread: index,
                            onPress: () {
                              Get.toNamed(Routes.CHATLIST, arguments: {
                                'recieverName': recieverName,
                                'recieverImage': recieverImage,
                                'recieverFcm': recieverFcm,
                                'documentId': participants.documentId,
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ).paddingOnly(top: 20, left: 26, right: 26, bottom: 10)),
      ),
    );
    // );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.onPress,
    required this.image,
  });
  final String name;
  final String message;
  final String time;
  final int unread;
  final String image;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          width: double.infinity,
          height: 67,
          padding: const EdgeInsets.only(
            left: 8,
            right: 11,
          ),
          decoration: ShapeDecoration(
            color: whiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                        color: placeHolderColor,
                        shape: const OvalBorder(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF008A00),
                          shape: OvalBorder(),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.30,
                              ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(message,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor.withOpacity(0.5))),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      time,
                    ),
                    Visibility(
                      visible: true,
                      child: Container(
                        alignment: Alignment.center,
                        width: 18,
                        height: 18,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE8FAF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(29),
                          ),
                        ),
                        child: Text(
                          unread.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: secondaryColor, fontSize: 12),
                        ),
                      ),
                    )
                  ],
                )
              ])),
    );
  }
}

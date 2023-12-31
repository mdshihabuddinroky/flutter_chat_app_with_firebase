import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/Theme/colors.dart';
import 'package:flutter_chat_app/app/modules/chatlist/views/components/video_player.dart';
import 'package:get/get.dart';

import '../../../../service/get_thumbnali.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({
    super.key,
    required this.message,
    required this.time,
    required this.messageType,
  });
  final String message;
  final String time;
  final String messageType;

  @override
  Widget build(BuildContext context) {
    var thumbnali = Uint8List(0).obs;

    getImage() async {
      thumbnali(await getVideoThumbnali(message));
    }

    if (messageType == 'video') {
      getImage();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                padding: (messageType == "text")
                    ? const EdgeInsets.symmetric(horizontal: 16, vertical: 18)
                    : const EdgeInsets.all(1),
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
                child: (messageType == 'text')
                    ? Text(
                        message,
                        style: const TextStyle(
                          color: whiteColor,
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.30,
                        ),
                      )
                    : messageType == 'image'
                        ? CachedNetworkImage(
                            imageUrl: message,
                            placeholder: (context, url) => const SizedBox(
                                height: 150,
                                child:
                                    Center(child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : messageType == 'video'
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Obx(
                                    () => (thumbnali.value.isNotEmpty)
                                        ? Image.memory(
                                            thumbnali.value,
                                            fit: BoxFit
                                                .cover, // You can adjust the BoxFit as needed
                                          )
                                        : Container(
                                            height: 150,
                                          ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.to(() => VideoScreen(
                                            videoUrl: message,
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.play_circle_fill,
                                      color: whiteColor,
                                      size: 40,
                                    ),
                                  )
                                ],
                              )
                            : Container()),
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

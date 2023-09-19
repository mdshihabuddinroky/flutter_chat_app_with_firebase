import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/modules/chatlist/views/components/send_message_tile.dart';

class VideoMessageWidget extends StatefulWidget {
  final String videoUrl;

  const VideoMessageWidget(this.videoUrl, {super.key});

  @override
  VideoMessageWidgetState createState() => VideoMessageWidgetState();
}

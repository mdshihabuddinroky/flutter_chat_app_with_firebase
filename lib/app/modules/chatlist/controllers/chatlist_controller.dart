import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/data/remote/firestore_helper.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import '../../../data/remote/firebase_storage_helper.dart';
import '../../../models/message_model.dart';

class ChatlistController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  ScrollController scrollController = ScrollController();

  Query<Map<String, dynamic>> query(String conversationId) {
    CollectionReference<Map<String, dynamic>> messagesRef = FirebaseFirestore
        .instance
        .collection('Conversation/$conversationId/message');

    // Define your query
    return messagesRef.orderBy('created_at');
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> pickUploadFile(
    roomId,
    senderId,
  ) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        String fileName = path.basename(file.name);
        String fileExtension = path.extension(fileName).toLowerCase();

        if (fileExtension == '.jpg' ||
            fileExtension == '.jpeg' ||
            fileExtension == '.png') {
          debugPrint('Selected image file: $fileName');
          // Handle image file
          File file = File(result.files.single.path!);
          final fileUrl = await FirebaseStorageHelper()
              .storeFileToFirebase('files/${file.path.split('/').last}', file);
          debugPrint("fileUrl $fileUrl");
          MessageModel message = MessageModel(
            messageId: roomId,
            messageText: fileUrl,
            senderId: senderId,
            messageType: 'image',
          );
          addMessage(message);
        } else if (fileExtension == '.mp4' || fileExtension == '.mov') {
          debugPrint('Selected video file: $fileName');
          File file = File(result.files.single.path!);

          final fileUrl = await FirebaseStorageHelper()
              .storeFileToFirebase('files/${file.path.split('/').last}', file);
          debugPrint("fileUrl $fileUrl");
          MessageModel message = MessageModel(
            messageId: roomId,
            messageText: fileUrl,
            senderId: senderId,
            messageType: 'video',
          );
          addMessage(message);
        } else {
          debugPrint('Invalid file type: $fileName');
          // Handle invalid file type
        }
      }
    } catch (e) {
      debugPrint('Error picking files: $e');
    }
  }

  void addMessage(MessageModel message) {
    FireStoreHelper().addMessageToDatabase(
      conversationId: message.messageId,
      messageText: message.messageText,
      senderId: message.senderId,
      messageType: message.messageType,
    );
  }
}

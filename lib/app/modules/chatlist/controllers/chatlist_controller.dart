import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  Future<void> addMessageToConversation({
    required String conversationId,
    required String messageText,
    required String senderId,
    required String messageType,
  }) async {
    try {
      // Create a reference to the Firestore collection for messages in the conversation
      CollectionReference<Map<String, dynamic>> messagesRef = FirebaseFirestore
          .instance
          .collection('Conversation/$conversationId/message');

      // Create a new message document
      final newMessage = {
        'created_at': Timestamp.now(),
        'message': messageText,
        'message_type': messageType,
        'sender_id': senderId,
        // Add other fields if needed
      };

      // Add the message document to the collection
      await messagesRef.add(newMessage);
      updateLastMessage(conversationId, messageText);
      // Message added successfully
    } catch (error) {
      // Handle any errors that occur during the process
      debugPrint('Error adding message: $error');
    }
  }

  void updateLastMessage(conversationId, messageText) {
    CollectionReference<Map<String, dynamic>> messagesRef =
        FirebaseFirestore.instance.collection('Conversation');
    messagesRef.doc(conversationId).update({
      'last_message': messageText,
      'last_message_time': Timestamp.now(),
    });
  }
}

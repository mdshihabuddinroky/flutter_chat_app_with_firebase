import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String messageText;
  final String senderId;
  DateTime? createdAt;
  final String messageType; // Added field for message type

  MessageModel({
    required this.messageId,
    required this.messageText,
    required this.senderId,
    this.createdAt,
    required this.messageType,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map, String messageId) {
    return MessageModel(
      messageId: messageId,
      messageText: map['message'] as String,
      senderId: map['sender_id'] as String,
      createdAt: (map['created_at'] as Timestamp).toDate(),
      messageType: map['message_type'] as String, // Initialize messageType
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': messageText,
      'sender_id': senderId,
      'created_at': Timestamp.now(),
      'message_type': messageType, // Include messageType
    };
  }
}

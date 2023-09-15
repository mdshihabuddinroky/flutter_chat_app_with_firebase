import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  final String fcm1;
  final String fcm2;
  final String documentId;
  final String participant2;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final String participant1Image;
  final String participant1Name;
  final String participant2Image;
  final String participant2Name;
  final List<String> participants;

  ConversationModel({
    required this.documentId,
    required this.participant2,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.participant1Image,
    required this.participant1Name,
    required this.participant2Image,
    required this.participant2Name,
    required this.participants,
    required this.fcm1,
    required this.fcm2,
  });

  factory ConversationModel.fromMap(
      String documentId, Map<String, dynamic> map) {
    return ConversationModel(
      fcm1: map['fcm1'] ?? '',
      fcm2: map['fcm2'] ?? '',
      documentId: documentId,
      participant2: map['participant 2'] ?? '',
      lastMessage: map['last_message'] ?? '',
      lastMessageTime: map['last_message_time'] ?? Timestamp(0, 0),
      participant1Image: map['participan1_image'] ?? '',
      participant1Name: map['participan1_name'] ?? '',
      participant2Image: map['participan2_image'] ?? '',
      participant2Name: map['participan2_name'] ?? '',
      participants: List<String>.from(map['participant'] ?? []),
    );
  }
}

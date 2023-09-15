import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatuserController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  Query<Map<String, dynamic>> get query {
    // Create a reference to the "Conversations" collection
    CollectionReference<Map<String, dynamic>> conversationsRef =
        FirebaseFirestore.instance.collection('Conversation');

    // Define your query
    return conversationsRef.where(
      'participant',
      arrayContains: user!.uid,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  Future<void> createUserDocument() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Define the data to be stored in the document
      Map<String, dynamic> userData = {
        'name': user.displayName,
        'email': user.email,
        'profile_pic': user.photoURL,
        'fcm': "fcmId"
        // Add more user-related data here
      };

      // Create a document with the user's UID in the "users" collection
      await firestore.collection('Users').doc(user.uid).set(userData);
    }
  }
}

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/routes/app_pages.dart';

import 'package:get/get.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];
    try {
      return SignInScreen(
        providers: providers,
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) async {
            await controller.createUserDocument();
            Get.offAllNamed(Routes.CHATUSER);
          }),
        ],
      );
    } catch (e) {
      Get.snackbar("Failed", e.toString());
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

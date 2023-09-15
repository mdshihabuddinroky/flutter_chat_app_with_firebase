import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];
    return ProfileScreen(
      providers: providers,
      actions: [
        SignedOutAction((context) {
          Get.offAllNamed(Routes.SIGNUP);
        }),
      ],
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/Theme/theme.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  WidgetsFlutterBinding.ensureInitialized();

  // This is the last thing you need to add.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      title: "Application",
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? Routes.SIGNUP
          : Routes.CHATUSER,
      getPages: AppPages.routes,
    );
  }
}

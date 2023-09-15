import 'package:get/get.dart';

import '../modules/chatlist/bindings/chatlist_binding.dart';
import '../modules/chatlist/views/chatlist_view.dart';
import '../modules/chatuser/bindings/chatuser_binding.dart';
import '../modules/chatuser/views/chatuser_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const intialRoute = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CHATLIST,
      page: () => const ChatlistView(),
      binding: ChatlistBinding(),
    ),
    GetPage(
      name: _Paths.CHATUSER,
      page: () => const ChatuserView(),
      binding: ChatuserBinding(),
    ),
  ];
}

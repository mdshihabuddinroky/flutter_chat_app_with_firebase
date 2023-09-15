import 'package:get/get.dart';

import '../controllers/chatuser_controller.dart';

class ChatuserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatuserController>(
      () => ChatuserController(),
    );
  }
}

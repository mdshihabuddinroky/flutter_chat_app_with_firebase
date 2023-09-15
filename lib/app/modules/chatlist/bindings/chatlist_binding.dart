import 'package:get/get.dart';

import '../controllers/chatlist_controller.dart';

class ChatlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatlistController>(
      () => ChatlistController(),
    );
  }
}

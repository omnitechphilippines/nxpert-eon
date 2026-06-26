import 'package:get/get.dart';

import '../controllers/handy_controller.dart';

class HandyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HandyController>(
      () => HandyController(),
    );
  }
}

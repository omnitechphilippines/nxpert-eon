import 'package:get/get.dart';

import '../controllers/locator_tagging_controller.dart';

class LocatorTaggingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocatorTaggingController>(
      () => LocatorTaggingController(),
    );
  }
}

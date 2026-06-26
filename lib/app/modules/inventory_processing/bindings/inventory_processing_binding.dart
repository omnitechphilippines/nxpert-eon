import 'package:get/get.dart';

import '../controllers/inventory_processing_controller.dart';

class InventoryProcessingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryProcessingController>(
      () => InventoryProcessingController(),
    );
  }
}

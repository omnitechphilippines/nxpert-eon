import 'package:get/get.dart';

import '../controllers/inventory_generation_controller.dart';

class InventoryGenerationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryGenerationController>(
      () => InventoryGenerationController(),
    );
  }
}

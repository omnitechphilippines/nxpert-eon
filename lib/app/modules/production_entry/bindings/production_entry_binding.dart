import 'package:get/get.dart';

import '../controllers/production_entry_controller.dart';

class ProductionEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductionEntryController>(
      () => ProductionEntryController(),
    );
  }
}

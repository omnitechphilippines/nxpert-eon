import 'package:get/get.dart';

import '../controllers/product_defect_entry_controller.dart';

class ProductDefectEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDefectEntryController>(
      () => ProductDefectEntryController(),
    );
  }
}

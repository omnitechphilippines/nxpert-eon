import 'package:get/get.dart';

import '../controllers/material_entry_controller.dart';

class MaterialEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaterialEntryController>(
      () => MaterialEntryController(),
    );
  }
}

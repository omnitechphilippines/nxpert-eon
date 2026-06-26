import 'package:get/get.dart';

import '../controllers/material_defect_entry_controller.dart';

class MaterialDefectEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaterialDefectEntryController>(
      () => MaterialDefectEntryController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/material_issuance_controller.dart';

class MaterialIssuanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaterialIssuanceController>(
      () => MaterialIssuanceController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/barcode_management_controller.dart';

class BarcodeManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeManagementController>(
      () => BarcodeManagementController(),
    );
  }
}

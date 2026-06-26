import 'package:get/get.dart';

import '../controllers/barcode_test_controller.dart';

class BarcodeTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeTestController>(
      () => BarcodeTestController(),
    );
  }
}

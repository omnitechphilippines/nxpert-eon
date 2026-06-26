import 'package:get/get.dart';

import '../controllers/defect_controller.dart';

class DefectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DefectController>(
      () => DefectController(),
    );
  }
}

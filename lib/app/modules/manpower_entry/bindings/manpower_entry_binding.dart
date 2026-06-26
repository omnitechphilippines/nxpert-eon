import 'package:get/get.dart';

import '../controllers/manpower_entry_controller.dart';

class ManpowerEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManpowerEntryController>(
      () => ManpowerEntryController(),
    );
  }
}

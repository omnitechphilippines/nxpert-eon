import 'package:get/get.dart';

import '../controllers/machine_entry_controller.dart';

class MachineEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MachineEntryController>(
      () => MachineEntryController(),
    );
  }
}

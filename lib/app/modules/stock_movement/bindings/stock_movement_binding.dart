import 'package:get/get.dart';

import '../controllers/stock_movement_controller.dart';

class StockMovementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockMovementController>(
      () => StockMovementController(),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class LayoutController extends GetxController {
  final RxBool isCondensed = false.obs;
  final RxString currentRoute = kIsWeb ? Get.currentRoute.obs : Routes.DASHBOARD.obs;
  final RxString hoveredRoute = ''.obs;

  void get toggleLeftBar => isCondensed.toggle();

  void changePage(String route) {
    if (currentRoute.value == route) {
      return;
    }

    currentRoute.value = route;
    if (kIsWeb) {
      Get.toNamed(route);
    } else {
      Get.toNamed(route, id: 1);
    }
  }

  void logout() {
    Get.delete<LayoutController>(force: true);
    Get.find<AuthService>().logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}

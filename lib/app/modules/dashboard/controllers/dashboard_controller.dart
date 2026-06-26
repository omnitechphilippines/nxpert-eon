import 'package:get/get.dart';

class DashboardController extends GetxController {
  void logout() {
    Get.offAllNamed('/login');
  }
}

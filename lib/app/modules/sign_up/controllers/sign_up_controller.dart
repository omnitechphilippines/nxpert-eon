import 'package:get/get.dart';

class SignUpController extends GetxController {
  final RxBool termsAndConditions = false.obs;

  void get termsAndConditionsToggle => termsAndConditions.value = !termsAndConditions.value;
}

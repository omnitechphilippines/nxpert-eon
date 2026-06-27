import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../data/models/user_model.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/services/auth_service.dart';

class LoginController extends GetxController {
  final AuthProvider _authProvider = AuthProvider();
  final AuthService _authService = Get.find<AuthService>();

  final RxBool rememberMe = false.obs;

  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode userNameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  RxBool isLoading = false.obs;
  final Rx<PackageInfo?> packageInfo = Rx<PackageInfo?>(null);

  void get rememberToggle => rememberMe.toggle();

  Future<void> get _fetchPackageInfo async => packageInfo.value = await PackageInfo.fromPlatform();

  @override
  void onInit() {
    super.onInit();
    _fetchPackageInfo;
  }

  @override
  void onReady() {
    super.onReady();
    userNameFocus.requestFocus();
  }

  Future<void> login() async {
    if (!(formKeyLogin.currentState?.validate() ?? false)) {
      return;
    }

    try {
      isLoading.value = true;

      // 1. Verify DB data + Client BCrypt validation
      final UserModel user = await _authProvider.verifyAndLogin(userNameController.text.trim(), passwordController.text.trim());

      // 2. Commit authenticated session to State & SharedPreferences
      await _authService.loginUser(user);
    } catch (e) {
      Get.snackbar('Login Failed', e.toString().replaceAll('Exception: ', ''), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    userNameController.dispose();
    passwordController.dispose();
    userNameFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}

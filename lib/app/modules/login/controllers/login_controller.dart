import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/services/auth_service.dart';

class LoginController extends GetxController {
  final AuthProvider _authProvider = AuthProvider();
  final AuthService _authService = Get.find<AuthService>();

  final RxBool rememberMe = false.obs;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  void get rememberToggle => rememberMe.toggle();

  Future<void> login() async {
    final String userName = userNameController.text.trim();
    final String password = passwordController.text.trim();

    if (userName.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      isLoading.value = true;

      // 1. Verify DB data + Client BCrypt validation
      final UserModel user = await _authProvider.verifyAndLogin(userName, password);

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
    super.onClose();
  }
}

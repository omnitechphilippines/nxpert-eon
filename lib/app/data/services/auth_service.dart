import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';
import '../models/user_model.dart';

class AuthService extends GetxService {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();

  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLocalUser();
  }

  void _loadLocalUser() {
    final String? userRaw = _prefs.getString('cached_user');
    if (userRaw != null) {
      currentUser.value = UserModel.fromJson(jsonDecode(userRaw));
      isLoggedIn.value = true;
    }
  }

  // Explicitly called by LoginController upon successful validation
  Future<void> loginUser(UserModel user) async {
    currentUser.value = user;
    isLoggedIn.value = true;
    await _prefs.setString('cached_user', jsonEncode(user.toJson()));

    if (kIsWeb) {
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      Get.offAllNamed(Routes.LAYOUT);
    }
  }

  // Clear session properties and redirect to login
  Future<void> logout() async {
    currentUser.value = null;
    isLoggedIn.value = false;
    await _prefs.remove('cached_user');

    Get.offAllNamed('/login');
  }
}

import 'package:bcrypt/bcrypt.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

class AuthProvider extends GetConnect {
  final SupabaseClient _supabase = Supabase.instance.client;

  // @override
  // void onInit() {
  //   httpClient.baseUrl = 'YOUR-API-URL';
  // }

  Future<UserModel> verifyAndLogin(String userName, String password) async {
    try {
      final List<Map<String, dynamic>> response = await _supabase.from('users_master').select().eq('user_name', userName);

      if (response.isEmpty) {
        throw Exception('User not found.');
      }

      final Map<String, dynamic> userMap = response.first;
      final UserModel user = UserModel.fromMap(userMap);
      final bool isPasswordCorrect = BCrypt.checkpw(password, user.password);

      if (!isPasswordCorrect) {
        throw Exception('Incorrect password.');
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }
}

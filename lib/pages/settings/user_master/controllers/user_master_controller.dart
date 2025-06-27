// lib/controllers/user_master_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../../../utils/global_api_config.dart';

class UserMasterController {
  Future<List<User>> getUsers() async {
    final url = Uri.parse('${ApiConfig.baseUrl}userMasterGetUsers'); // Adjust to your endpoint

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}

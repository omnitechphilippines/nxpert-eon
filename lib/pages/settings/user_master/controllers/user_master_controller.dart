import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../utils/global_api_config.dart';
import '../models/paginated_user_response.dart';
import '../../user_master/models/user_model.dart';

// This controller handles user-related operations such as fetching and searching users.
class UserMasterController {
  Future<PaginatedUserResponse> getUsers({
    required int page,
    required int limit,
  }) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}userMasterGetUsers?page=$page&limit=$limit',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PaginatedUserResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load users');
    }
  }

  //controller for searching users
  Future<PaginatedUserResponse> searchUser({
    required int page,
    required int limit,
    String? userCode,
    String? firstName,
    String? lastName,
    String? email,
    String? position,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (userCode != null) 'userCode': userCode,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (email != null) 'email': email,
      if (position != null) 'position': position,
    };

    final uri = Uri.parse(
      '${ApiConfig.baseUrl}userMasterSearchUsers',
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return PaginatedUserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search users');
    }
  }

  Future<bool> insertUser(User user) async {
    final url = Uri.parse('${ApiConfig.baseUrl}userMasterAddUser');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Umt_Usercode': user.userCode,
          'Umt_userfname': user.userFirstName,
          'Umt_userlname': user.userLastName,
          'Umt_Position': user.userPosition,
          'Umt_Email': user.userEmail,
          'Umt_status': user.userStatus,
          'Umt_password': user.userPassword,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
          'Failed to insert user. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Insert User Error: $e');
      return false;
    }
  }

  Future<bool> updateUser({
    required String userCode,
    String? firstName,
    String? lastName,
    String? email,
    String? position,
    String? status,
    String? password,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}userMasterUpdateUser');

    // Construct only non-null fields
    final Map<String, dynamic> updateData = {
      'Umt_Usercode': userCode,
      if (firstName != null) 'Umt_userfname': firstName,
      if (lastName != null) 'Umt_userlname': lastName,
      if (email != null) 'Umt_Email': email,
      if (position != null) 'Umt_Position': position,
      if (status != null) 'Umt_status': status,
      if (password != null) 'Umt_password': password,
    };

    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
          'Failed to update user. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Update User Error: $e');
      return false;
    }
  }
}

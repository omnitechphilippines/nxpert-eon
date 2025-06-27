import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../utils/global_api_config.dart';
import '../models/paginated_user_response.dart';

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
}

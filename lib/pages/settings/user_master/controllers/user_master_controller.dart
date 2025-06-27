import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../utils/global_api_config.dart';
import '../models/paginated_user_response.dart';

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
}

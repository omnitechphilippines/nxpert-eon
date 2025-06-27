// models/paginated_user_response.dart

import 'user_model.dart';

class PaginatedUserResponse {
  final List<User> users;
  final int total;

  PaginatedUserResponse({
    required this.users,
    required this.total,
  });

  factory PaginatedUserResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedUserResponse(
      users: (json['data'] as List)
          .map((user) => User.fromJson(user))
          .toList(),
      total: json['total'] ?? 0,
    );
  }
}

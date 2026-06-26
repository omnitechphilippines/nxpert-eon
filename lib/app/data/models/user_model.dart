class UserModel {
  final String? id;
  final String userName;
  final String password;
  final String? firstName;
  final String? lastName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({required this.id, required this.userName, required this.password, this.firstName, this.lastName, this.createdAt, this.updatedAt});

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    id: map['id'],
    userName: map['user_name'] ?? '',
    password: map['password'] ?? '',
    firstName: map['first_name'],
    lastName: map['last_name'],
    createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'user_name': userName, 'password': password, 'first_name': firstName, 'last_name': lastName, 'created_at': createdAt?.toUtc().toIso8601String(), 'updated_at': updatedAt?.toUtc().toIso8601String()};

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String?,
    userName: json['user_name'] as String,
    password: json['password'] as String,
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
    updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
  );
}

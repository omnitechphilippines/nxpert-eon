class User {
  final String userCode;
  final String userFirstName;
  final String userLastName;
  final String userPosition;
  final String userEmail;
  final String userStatus;
  final String userPassword;

  User({
    required this.userCode,
    required this.userFirstName,
    required this.userLastName,
    required this.userPosition,
    required this.userEmail,
    required this.userStatus,
    required this.userPassword,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userCode: json['Umt_Usercode'] ?? '',
      userFirstName: json['Umt_userfname'] ?? '',
      userLastName: json['Umt_userlname'] ?? '',
      userPosition: json['Umt_Position'] ?? '',
      userEmail: json['Umt_Email'] ?? '',
      userStatus: json['Umt_status'] ?? '',
      userPassword: '', 
    );
  }
}

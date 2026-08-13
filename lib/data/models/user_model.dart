class UserModel {
  final String id;
  final String email;
  final String username;
  final String? token;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'token': token,
    };
  }

  UserModel copyWith({String? token}) {
    return UserModel(
      id: id,
      email: email,
      username: username,
      token: token ?? this.token,
    );
  }
}

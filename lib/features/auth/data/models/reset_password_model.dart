class ResetPasswordReq {
  final String password;

  ResetPasswordReq({required this.password});

  Map<String, dynamic> toMap() {
    return {
      'password': password,
    };
  }
}

class ResetPasswordResponse {
  final String message;
  final User user;

  ResetPasswordResponse({required this.message, required this.user});

  factory ResetPasswordResponse.fromMap(Map<String, dynamic> map) {
    return ResetPasswordResponse(
      message: map['message'] ?? '',
      user: User.fromJson(map['user'] ?? {}),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String? image;
  final int? user_points;

  User(
      {required this.id,
      required this.name,
      required this.email,
      this.image,
      required this.user_points});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        image: json['image'],
        user_points: json['user_points'] ?? 0);
  }
}

class AddImageResponse {
  final String message;
  final User user;

  AddImageResponse({
    required this.message,
    required this.user,
  });

  factory AddImageResponse.fromJson(Map<String, dynamic> json) {
    return AddImageResponse(
      message: json['message'] as String? ?? 'Image upload successful',
      user: User.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String? image;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String? ?? 'Unknown',
      name: json['name'] as String? ?? 'Unknown',
      email: json['email'] as String? ?? 'Unknown',
      image: json['image'] as String?,
    );
  }
}
/*
  factory AddImageResponse.fromJson(Map<String, dynamic> json) {
    return AddImageResponse(
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String image;

  User(
      {required this.image,
      required this.id,
      required this.name,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
    );
  }
}
*/

class ForgetPasswordReq {
  final String email;

  ForgetPasswordReq({required this.email});

  Map<String, dynamic> toMap() {
    return {'email': email};
  }
}

class ForgetPasswordResponse {
  final String msg;
  final String token;

  ForgetPasswordResponse({required this.msg, required this.token});

  factory ForgetPasswordResponse.fromMap(Map<String, dynamic> json) {
    return ForgetPasswordResponse(msg: json['msg'], token: json['token']);
  }
}

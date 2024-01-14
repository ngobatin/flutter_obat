//DIGUNAKAN UNTUK FORM LOGIN
class LoginInput {
  final String username;
  final String password;
  LoginInput({
    required this.username,
    required this.password,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}

//DIGUNAKAN UNTUK RESPONSE
class LoginResponse {
  final int status;
  final String message;

  LoginResponse({
    required this.status,
    required this.message,
  });
  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
      );
}

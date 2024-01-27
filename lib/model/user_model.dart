//DIGUNAKAN UNTUK GET ALL DATA
class UserModel {
  final String id;
  final String username;
  final String password;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "password": password,
      };
}

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

//DIGUNAKAN UNTUK FORM Register
class RegisterInput {
  final String username;
  final String password;
  final String confirmPassword;

  RegisterInput({
    required this.username,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "confirm_password": confirmPassword,
      };
}

//DIGUNAKAN UNTUK RESPONSE
class RegisterResponse {
  final int status;
  final String message;

  RegisterResponse({
    required this.status,
    required this.message,
  });
  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        status: json["status"],
        message: json["message"],
      );
}

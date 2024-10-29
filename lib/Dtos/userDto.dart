class UserDto {
  String userName;
  String password;
  String email;
  String ocupacao;

  UserDto({
    required this.userName,
    required this.password,
    required this.email,
    required this.ocupacao,
  });
  
  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        userName: json["UserName"],
        password: json["Password"],
        email: json["Email"],
        ocupacao: json["Ocupacao"],
      );

  Map<String, dynamic> toJson() => {
        "UserName": userName,
        "Password": password,
        "Email": email,
        "Ocupacao": ocupacao,
      };
}

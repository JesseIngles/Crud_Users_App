import 'package:userapp/Dtos/userDto.dart';

class UpdateUserDto {
    int userId;
    UserDto userDto;

    UpdateUserDto({
        required this.userId,
        required this.userDto,
    });

    factory UpdateUserDto.fromJson(Map<String, dynamic> json) => UpdateUserDto(
        userId: json["userId"],
        userDto: UserDto.fromJson(json["userDto"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "userDto": userDto.toJson(),
    };
}
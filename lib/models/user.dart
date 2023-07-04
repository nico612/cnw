
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart'; //必须指定生成的.g.dart

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User extends Equatable {

  const User(
      {required this.id,
      required this.isBindPhone,
      this.logoUrl,
      this.username,
      this.isTeacher
      });

  static const empty = User(id: 0, isBindPhone: false, logoUrl: '', username: '');

  final int id;

  @JsonKey(name: "is_bind_phone") /// 指定json中的字段，当json中的字段跟定义不一样时需要制定
  final bool isBindPhone;

  @JsonKey(name: "logoUrl")
  final String? logoUrl;
  final String? username;

  @JsonKey(name: "is_teacher")
  final bool? isTeacher;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, isBindPhone, logoUrl ?? "", username ?? ""];
  
}

@JsonSerializable()
class LoginInfo {
  final User user;
  final String token;

  LoginInfo(this.user, this.token);

  factory LoginInfo.fromJson(Map<String, dynamic> json) => _$LoginInfoFromJson(json);
    Map<String, dynamic> toJson() => _$LoginInfoToJson(this);

}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart'; //必须指定生成的.g.dart

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User extends Equatable {

  const User(
      {required this.id,
        this.username,
        this.avatar,
        this.teacher,
        this.admin
      });

  static const empty = User(id: 0, username: '', teacher: false, admin: false);

  final int id;

  // @JsonKey(name: "is_bind_phone") /// 指定json中的字段，当json中的字段跟定义不一样时需要制定
  // final bool isBindPhone;

  final String? avatar;
  final String? username;
  final bool? teacher;
  final bool? admin;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, username ?? "", avatar ?? "", teacher, admin];
  
}

@JsonSerializable()
class TokenInfo {
  final String tokenName;
  final String tokenValue;
  final String loginType;
  final int tokenTimeout;
  final int tokenActivityTimeout;
  final String loginDevice;

  TokenInfo(this.tokenName, this.tokenValue, this.loginType, this.tokenTimeout, this.tokenActivityTimeout, this.loginDevice);

  factory TokenInfo.fromJson(Map<String, dynamic> json) => _$TokenInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TokenInfoToJson(this);

}

@JsonSerializable()
class LoginInfo {
  final User user;
  final TokenInfo tokenInfo;

  LoginInfo(this.user, this.tokenInfo);

  factory LoginInfo.fromJson(Map<String, dynamic> json) => _$LoginInfoFromJson(json);
    Map<String, dynamic> toJson() => _$LoginInfoToJson(this);

}
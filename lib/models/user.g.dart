// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      teacher: json['teacher'] as bool?,
      admin: json['admin'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'username': instance.username,
      'teacher': instance.teacher,
      'admin': instance.admin,
    };

TokenInfo _$TokenInfoFromJson(Map<String, dynamic> json) => TokenInfo(
      json['tokenName'] as String,
      json['tokenValue'] as String,
      json['loginType'] as String,
      json['tokenTimeout'] as int,
      json['tokenActivityTimeout'] as int,
      json['loginDevice'] as String,
    );

Map<String, dynamic> _$TokenInfoToJson(TokenInfo instance) => <String, dynamic>{
      'tokenName': instance.tokenName,
      'tokenValue': instance.tokenValue,
      'loginType': instance.loginType,
      'tokenTimeout': instance.tokenTimeout,
      'tokenActivityTimeout': instance.tokenActivityTimeout,
      'loginDevice': instance.loginDevice,
    };

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      User.fromJson(json['user'] as Map<String, dynamic>),
      TokenInfo.fromJson(json['tokenInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'user': instance.user,
      'tokenInfo': instance.tokenInfo,
    };

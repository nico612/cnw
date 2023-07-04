
import 'dart:convert';

import 'package:cniao/common/constant.dart';
import 'package:cniao/global.dart';
import 'package:cniao/models/user.dart';
import 'package:cniao/utils/storage.dart';

/// uninitialized - 身份验证未初始化；  authenticated - 认证成功；  unauthenticated 认证失败
enum AuthenticationStatus { uninitialized, authenticated, unauthenticated }

class AuthenticationRepository {
  
  User? _user;

  User? getUser() {
    if (_user == null) {
      String? json = StorageUtil().getString(STORAGE_LOGIN_USER_KEY, encrypt: true);
      if (json != null) {
        Map map = jsonDecode(json);
        _user = User.fromJson(map as Map<String, dynamic>);
      }
    }
    return _user;
  }

  String? getToken() {
    return StorageUtil().getString(STORAGE_LOGIN_TOKEN_KEY, encrypt: true);
  }

  /// 缓存登登录信息（token 和 user）
  void saveAuthenticationInfo(User user, String token) {
    String json = jsonEncode(user.toJson());
    StorageUtil().setString(STORAGE_LOGIN_USER_KEY, json);
    StorageUtil().setString(STORAGE_LOGIN_TOKEN_KEY, token, encrypt: true);
    Gloabl.loginToken = token;
  }

  void clearAuthenticationInfo() {
    StorageUtil().remove(STORAGE_LOGIN_USER_KEY);
    StorageUtil().remove(STORAGE_LOGIN_TOKEN_KEY);
  }

}
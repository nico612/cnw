
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../common/constant.dart';
import '../libs/encrypt_util.dart';

/// local storage util
class StorageUtil {

  /// private constractor method
  StorageUtil._internal();

  /// singleton model
  /// create static final instance use private constractor `StorageUtil._internal`
  static final StorageUtil _instance = StorageUtil._internal();
  
  /// return the _instance when create storage use StorageUtil() 
  factory StorageUtil() {
    return _instance;
  }

  /// use 3rd package sharedPreferences
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool>? setString(String key, String value, { bool encrypt = false}) {
    if (encrypt) {
       value = EncryptUtils.aesEncrypt(value, SECRET_KEY);
    }
    return _prefs?.setString(key, value);
  }

  String? getString(String key, {bool encrypt = false}) {
    String? str = _prefs?.getString(key);
    if (encrypt && str != null) {
      str = EncryptUtils.aesDecrypt(str, SECRET_KEY);
    }
    return str;
  }

  Future<bool>? setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs?.setString(key, jsonString); 
  }

  dynamic getJSON(String key) {
    String? jsonString = _prefs?.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool>? setBool(String key, bool value) {
    return _prefs?.setBool(key, value);
  }

  bool getBool(String key) {
    bool? value =  _prefs?.getBool(key);
    return value ?? false;
  }


  Future<bool>? remove(String key) {
    return _prefs?.remove(key);
  }


}
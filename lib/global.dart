
import 'dart:io';

import 'package:cniao/common/application.dart';
import 'package:cniao/common/authentication/authentication_repository/authentication_repository.dart';
import 'package:cniao/common/constant.dart';
import 'package:cniao/router/routers.dart';
import 'package:cniao/utils/storage.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

/// 全局配置
class Gloabl {  

  /// 是否是ios
  static bool isIOS = Platform.isIOS;

  /// android 设备信息
  static AndroidDeviceInfo? androidDeviceInfo;
  
  /// ios 设备信息
  static IosDeviceInfo? iosDeviceInfo; 

  /// package info
  static PackageInfo? packageInfo;

  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 是否是离线登陆
  static bool isOfflineLogin = false;

  /// 用户登录后的token
  static String? loginToken;

  
  // static AppState appState = AppState();

  /// get environment value
  /// set env default value:
  /// const int maxRetryAttempts = const int.fromEnvironment('MAX_RETRY_ATTEMPTS', defaultValue: 3);
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  static AuthenticationRepository authenticationRepository = AuthenticationRepository();

  static Future init() async {
    // runtime, 它负责将Flutter框架与平台(iOS/Android)进行连接，以及管理应用程序的生命周期和事件处理。
    WidgetsFlutterBinding.ensureInitialized();

    //local data storage util
    await StorageUtil().init();
    
    /// read device only first open
    isFirstOpen = StorageUtil().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (!isFirstOpen) {
      StorageUtil().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }

    /// 读取离线用户信息
    var token = authenticationRepository.getToken();
    if (token != "") {
      loginToken = token;
      isOfflineLogin = true;
    }

    /// 包信息
    packageInfo = await PackageInfo.fromPlatform();

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (isIOS) {
      iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    } else {
      androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    }

    /// 初始化 路由
    Routers.configRouters(Application.router);
    

  }

}
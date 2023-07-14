
import 'dart:io';

import 'package:cniao/common/application.dart';
import 'package:cniao/common/authentication/authentication_repository/authentication_repository.dart';
import 'package:cniao/common/constant.dart';
import 'package:cniao/network/http/net_manager.dart';
import 'package:cniao/route/routes.dart';
import 'package:cniao/utils/storage.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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


    // device info
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (isIOS) {
      iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    } else {
      androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    }

    /// 初始化 路由
    Routes.configRouters(Application.router);

    // init http request
    HttpNetManager.init(isIOS);

    // Android 沉浸式状态栏
    if (Platform.isAndroid) {
      SystemUiOverlayStyle style = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          ///这是设置状态栏的图标和字体的颜色
          ///Brightness.light  一般都是显示为白色
          ///Brightness.dark 一般都是显示为黑色
          statusBarIconBrightness: Brightness.light);
      SystemChrome.setSystemUIOverlayStyle(style);
    }
  }

  //   // 持久化 用户信息
  // static Future<bool> saveProfile(UserLoginResponseEntity userResponse) {
  //   profile.dart = userResponse;
  //   return StorageUtil()
  //       .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  // }

  static void initBuglyAndroid() {
    // 初始化 Bugly
    // Bugly.initAndroidCrashReport(appId: "xxxxx", isDebug: false);
    // Bugly.setAndroidAppPackage(appPackage: packageInfo?.packageName);
    // Bugly.setAppVersion(appVersion: packageInfo?.version);
    // // Bugly.setAndroidAppChannel(appChannel: "test");

    // //bugly自定义日志,可在"跟踪日志"页面查看
    // BuglyLog.d(tag: "bugly", content: "debugvalue");
    // BuglyLog.i(tag: "bugly", content: "infovalue");
    // BuglyLog.v(tag: "bugly", content: "verbosevalue");
    // BuglyLog.w(tag: "bugly", content: "warnvalue");
    // BuglyLog.e(tag: "bugly", content: "errorvalue");
  }

  static void initBuglyiOS() {
    // 初始化 Bugly
    // Bugly.initAndroidCrashReport(appId: "xxxxx", isDebug: false);

    // Bugly.setAppVersion(appVersion: packageInfo?.version);
    // Bugly.setUserId(userId: "iosuser");
    // BuglyLog.d(tag: "bugly", content: "debugvalue");
    // BuglyLog.i(tag: "bugly", content: "infovalue");
    // BuglyLog.w(tag: "bugly", content: "warnvalue");
    // BuglyLog.v(tag: "bugly", content: "verbosevalue");
    // BuglyLog.e(tag: "bugly", content: "errorvalue");
  }


}


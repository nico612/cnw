
abstract class EnvName {
  /// 环境key
  static const String envKey = "DART_DEFINE_APP_ENV";

  /// 环境value
  static const String dev = "dev";
  static const String release = "release";
  static const String test = "test";
}


class ApiConfig {
  final int connectTimeout = 50000;
  final int receiveTimeout = 50000;
  final String version = "1.0";

  late String appID;
  late String appKey;
  late String domian;
  late String platform;

  late Map<String, dynamic> header;

  ApiConfig(this.appID, this.appKey, this.domian, this.platform) {
    ///|appid |应用ID |通过后台获取 |是|
// |verion | Api的版本号|1.0 |是|
// |platform |平台 |iOS，Android |是|
// |system| 操作系统版本| android 10, iOS9||
// |brand |手机品牌 | 苹果，华为，小米... ||
// |model |手机型号 | 华为P30,小米10，iPhone x ||
// |uuid| 设备唯一码 | ||
// |network| 网络| wifi ,4G ,5G||
// |sign | 签名| 参考下面的签名机制|是|
// |timestamp | 时间搓 | |是|
// |token | 用户token | 需要登录才能访问的接口需带上此参数 |可选|

    header = {
      // "system": Global.isIOS
      //     ? Global.iosDeviceInfo.systemName
      //     : Global.androidDeviceInfo.board,
      "appid": appID,
      "verison": version,
      "platform": platform
    };
    // if (Global.loginToken != null) {
    //   header["token"] = Global.loginToken;
    // }
  }
}

/// 环境配置
class EnvConfig {
  final bool debug;
  final ApiConfig androidApiConfig;
  final ApiConfig iOSApiConfig;

  EnvConfig(
      {required this.androidApiConfig,
      required this.iOSApiConfig,
      required this.debug});
}

/// 环境配置类
class Env {
  /// 获取到当前环境
  static const appEnv = String.fromEnvironment(EnvName.envKey);

  static ApiConfig androidApiConfigDev = ApiConfig(
      "Xzcv0jsbr0",
      "EaGEaGm4nt6yv1VJaBLdabTNJieNuFZ6",
      "https://api.cniao5.com",
      "H5"
      );

  // API配置
  static ApiConfig iOSApiConfigDev = ApiConfig(
    "Xzcv0jsbr0", 
    "7wcjezwnykp7yKRfZA1Nkrc3nhUmbQfD",
    "https://api.cniao5.com",
     "H5"
     );

  static ApiConfig androidApiConfigRelease =
      ApiConfig("Xzcv0jsbr0", "EaGEaGm4nt6yv1VJaBLdabTNJieNuFZ6", "https://api.cniao5.com", "H5");

  static ApiConfig iOSApiConfigRelease =
      ApiConfig("Xzcv0jsbr0", "7wcjezwnykp7yKRfZA1Nkrc3nhUmbQfD", "https://api.cniao5.com", "H5");

  /// 开发环境
  static final EnvConfig _devConfig = EnvConfig(
      androidApiConfig: androidApiConfigDev,
      iOSApiConfig: iOSApiConfigDev,
      debug: true);

  /// 发布环境
  static final EnvConfig _releaseConfig = EnvConfig(
      androidApiConfig: androidApiConfigRelease,
      iOSApiConfig: iOSApiConfigRelease,
      debug: false);

  /// 测试环境
  static final EnvConfig _testConfig = EnvConfig(
      androidApiConfig: androidApiConfigDev,
      iOSApiConfig: iOSApiConfigDev,
      debug: true);

  static EnvConfig get envConfig => _getEnvConfig();

  ///根据不同环境返回对应的环境配置
  static EnvConfig _getEnvConfig() {
    switch (appEnv) {
      case EnvName.dev:
        return _devConfig;
      case EnvName.release:
        return _releaseConfig;
      case EnvName.test:
        return _testConfig;
      default:
        return _releaseConfig;
    }
  }
}



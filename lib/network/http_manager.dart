

import 'package:cniao/config.dart';

class HTTPManager {

  static void init (bool isIOS) {
    ApiConfig config = isIOS ? Env.envConfig.iOSApiConfig : Env.envConfig.androidApiConfig;
    
    
  }


}
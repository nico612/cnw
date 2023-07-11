
import 'package:cniao/network/http/net_manager.dart';

const String net_account_password_login = '/passport/account/login';

class LoginNetManager {

  static Future passwordLogin({required String mobi, required String password}) async {
    Map<String, dynamic>  queryParameters = {"mobi": mobi, "password": password};

    // 注意post请求传入的为data参数
    return HttpNetManager.post(net_account_password_login, data: queryParameters);
  }
}
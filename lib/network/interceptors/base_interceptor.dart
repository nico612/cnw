import 'dart:convert';

import 'package:cniao/config.dart';
import 'package:cniao/global.dart';
import 'package:cniao/libs/encrypt_util.dart';
import 'package:cniao/network/base_response.dart';
import 'package:cniao/network/utils/api_util.dart';
import 'package:dio/dio.dart';

class BaseResponseInterceptor extends Interceptor {
  // ignore: constant_identifier_names
  static const int SUCCESS = 1;

  ApiConfig apiConfig = Gloabl.isIOS
      ? Env.envConfig.iOSApiConfig
      : Env.envConfig.androidApiConfig;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    Map<String, dynamic>? requestData = options.data;
    Map<String, dynamic> requestParams = options.queryParameters;

    Map<String, dynamic> allParams = {};

    Map<String, dynamic> headerParams = apiConfig.header;

    if (requestData != null) allParams.addAll(requestData);

    // ignore: unnecessary_null_comparison
    if (requestParams != null) allParams.addAll(requestParams);

    int timestamp =  DateTime.now().millisecondsSinceEpoch;
    headerParams["timestamp"] = timestamp;

    // 添加token
    if (Gloabl.loginToken != null) {
      headerParams["token"] = Gloabl.loginToken;
    }

    allParams.addAll(headerParams);

    String path = options.path;
    String sign = ApiUtil().getSign(allParams, apiConfig.appKey, path);

    headerParams["sign"] = sign;

    options.headers = headerParams;

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map data = response.data;
    int code = data["code"];
    if (code != SUCCESS) {
      handler.reject(DioException(requestOptions: response.requestOptions, response: response));
    } else {
      String? dataStr = data["data"];
      if (dataStr != null || dataStr != "") {
        // 解密数据
        dataStr = EncryptUtils.aesDecrypt(dataStr, apiConfig.appKey);
      }
      response.data = BaseResponse(code: data["code"], message: data["message"], data: jsonDecode(dataStr!));
      handler.next(response);
    }
    super.onResponse(response, handler);
  }

  // 在 http.dart 中处理错误逻辑
  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   print("调用 拦截器 onError");
  //   // error统一处理
  //   ApiException apiException = ApiException.create(err);
  //   EasyLoading.showError(apiException.message);
  //   err.error = apiException;
  //   handler.next(err);
  // }
}

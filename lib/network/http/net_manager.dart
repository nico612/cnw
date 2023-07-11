

import 'package:cniao/config.dart';
import 'package:cniao/network/http/cache.dart';
import 'package:dio/dio.dart';
import 'http_client.dart';

class HttpNetManager {

  static final httpClient = HttpClient();

  static void init (bool isIOS) {

    ApiConfig config = isIOS ? Env.envConfig.iOSApiConfig : Env.envConfig.androidApiConfig;

    httpClient.init(
        baseUrl: config.domian,
        connectTimeout: Duration(milliseconds: config.connectTimeout),
        receiveTimeout: Duration(milliseconds: config.receiveTimeout)
    );
  }

  static void setHeaders(Map<String, dynamic> headers) {
    httpClient.setHeaders(headers);
  }

  static void cancelRequests(CancelToken? cancelToken) {
    httpClient.cancelRequests(token: cancelToken);
  }


  static Future<T> get<T>(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = !CACHE_ENABLE,
        String? cacheKey,
        bool cacheDisk = false,
      }) {
    return httpClient.get<T>(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
      refresh: refresh,
      noCache: noCache,
      cacheKey: cacheKey,
    );
  }

  static Future<T> post<T>(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) {
    return httpClient.post(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future put(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) {
    return httpClient.put(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future patch(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) {
    return httpClient.patch(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future delete(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) {
    return httpClient.delete(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future postForm(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) {
    return httpClient.postForm(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }
}

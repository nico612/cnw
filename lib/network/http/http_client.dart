import 'package:cniao/config.dart';
import 'package:cniao/network/http/exceptions.dart';
import 'package:cniao/network/http/interceptors/base_interceptor.dart';
import 'package:cniao/network/http/interceptors/connectivity_request_retrier.dart';
import 'package:cniao/network/http/interceptors/retry_interceptor.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'base_response.dart';
import 'cache.dart';


/// 单例模式Http
class HttpClient {

   ///默认超时时间
  static const Duration CONNECT_TIMEOUT = Duration(seconds: 30);
  static const Duration RECEIVE_TIMEOUT = Duration(seconds: 30);

  Dio? dio;

  /// When [cancel] is invoked, all requests using this token will be cancelled.
  CancelToken _cancelToken = new CancelToken();


  HttpClient._internal() {
      if (dio == null) {
        /// BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
        BaseOptions options = BaseOptions(
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT
        );
        dio =  Dio(options);

        // 添加拦截器
        dio!.interceptors.add(BaseResponseInterceptor());

        // 加内存缓存
        // dio.interceptors.add(NetCacheInterceptor());

        dio!.interceptors.add(RetryOnConnectionChangeInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio!,
            connectivity: Connectivity(),
        )
        ));

        //log interceptor
        dio!.interceptors.add(LogInterceptor(
          requestBody: Env.envConfig.debug,
          responseBody: Env.envConfig.debug
        ));
      }
  }

  /// 2. 静态实例
  static final HttpClient _instance = HttpClient._internal();

  /// 默认构造器返回_instance
  factory HttpClient()  => _instance;

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init({
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    List<Interceptor>? interceptors
  }) {

    dio!.options = dio!.options.copyWith(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        contentType: 'application/json',
    );

    if (interceptors != null && interceptors.isNotEmpty) {
      dio!.interceptors.addAll(interceptors);
    }
  }

  /// 设置headers
  void setHeaders(Map<String, dynamic> map) {
    dio!.options.headers.addAll(map);
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  /// 请求
  Future<T> request<T>(
      String path, {
        HttpMethods method = HttpMethods.get,
        Map<String, dynamic>? params,
        Object? data,
        CancelToken? cancelToken,
        Options? options,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool refresh = false,
        bool noCache = !CACHE_ENABLE,
        String? cacheKey,
        bool cacheDisk = false,
      }) {

    const methodValues = {
      HttpMethods.get: 'get',
      HttpMethods.post: 'post',
      HttpMethods.put: 'put',
      HttpMethods.delete: 'delete',
      HttpMethods.patch: 'patch',
      HttpMethods.head: 'head'
    };

    options ??= Options(method: methodValues[method]);
    options = options.copyWith(extra: {
      "refresh": refresh,
      "noCache": noCache,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });

    return dio!.request(
      path, 
      data: data,
      queryParameters: params,
      cancelToken: cancelToken,
      options: options,
      onSendProgress:onSendProgress,
      onReceiveProgress: onReceiveProgress
    ).then((response) {
      //回调统一处理
      BaseResponse<T> baseResponse = response.data;
      T businessData = baseResponse.data;
      return Future.value(businessData);

    }).onError((error, stackTrace) {
      //异常统一处理, DioException 默认为unkonwn
      ApiException apiException = ApiException.create(error as DioException);
      EasyLoading.showError(apiException.message);
      return Future.error(error);
    });
  }

  /// restful get 操作
  Future<T> get<T>(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = !CACHE_ENABLE,
        String? cacheKey,
        bool cacheDisk = false,
      }) {
    return request<T>(path,
        method: HttpMethods.get,
        params: params,
        cancelToken: cancelToken,
        options: options,
        refresh: refresh,
        noCache: noCache,
        cacheKey: cacheKey,
        cacheDisk: cacheDisk);
  }

  /// restful post 操作
  Future<T> post<T>(
      String path, {
        Map<String, dynamic>? params,
        data,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) {
    return request<T>(
      path,
      method: HttpMethods.post,
      data: data,
      params: params,
      cancelToken: cancelToken,
      options: options,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  /// restful put 操作
  Future put(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) {
    return request(
      path,
      method: HttpMethods.put,
      params: params,
      cancelToken: cancelToken,
      options: options,
    );
  }

  /// restful patch 操作
  Future patch(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) {
    return request(
      path,
      method: HttpMethods.patch,
      params: params,
      cancelToken: cancelToken,
      options: options,
    );
  }

  /// restful delete 操作
  Future delete(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) {
    return request(
      path,
      method: HttpMethods.delete,
      params: params,
      cancelToken: cancelToken,
      options: options,
    );
  }

  /// restful post form 表单提交操作
  Future postForm(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) {
    return request(
      path,
      method: HttpMethods.post,
      data: FormData.fromMap(params!),
      cancelToken: cancelToken,
      options: options,
    );
  }
}

enum HttpMethods {
  get,
  post,
  put,
  delete,
  patch,
  head,
}

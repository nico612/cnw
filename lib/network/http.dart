import 'package:cniao/network/interceptors/base_interceptor.dart';
import 'package:cniao/network/interceptors/connectivity_request_retrier.dart';
import 'package:cniao/network/interceptors/retry_interceptor.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';


/// 单例模式Http
class Http {

   ///超时时间
  static const Duration CONNECT_TIMEOUT = Duration(seconds: 30);
  static const Duration RECEIVE_TIMEOUT = Duration(seconds: 30);

  Dio? dio;

  /// When [cancel] is invoked, all requests using this token will be cancelled.
  CancelToken _cancelToken = new CancelToken();


  Http._internal() {
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
      }
  }

  /// 2. 静态实例
  static Http _instance = Http._internal();

  /// 默认构造器返回_instance
  factory Http() {
    return _instance;
  }

  void init() {

  }

}
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// 自定义异常
class ApiException implements Exception {
  final String message;
  final int code;

  ApiException(
      this.code,
      this.message,
      );

  String toString() {
    return "$code:$message";
  }

  factory ApiException.create(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        {
          return BadRequestException(-1, "请求取消");
        }

      case DioExceptionType.connectionTimeout:
        {
          return BadRequestException(-1, "连接超时");
        }
      case DioExceptionType.sendTimeout:
        {
          return BadRequestException(-1, "请求超时");
        }
      case DioExceptionType.receiveTimeout:
        {
          return BadRequestException(-1, "响应超时");
        }
      case DioExceptionType.unknown:
        {
          Map data = error.response!.data;

          int errCode = data["code"];
          String errMsg = data["message"];

          // 这里做API 错误处理
          return ApiException(errCode, errMsg);
        }
      default:
        {
          return ApiException(-1, error.message ?? "请求错误");
        }
    }
  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException(int code, String message) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends ApiException {
  UnauthorisedException(int code, String message) : super(code, message);
}

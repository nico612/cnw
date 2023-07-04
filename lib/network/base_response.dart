

class BaseResponse<T> {
  final int code;
  final String message;
  final T data;

  BaseResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"message\":\"$message\"");
    sb.write(",\"errorMsg\":\"$code\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}

class ResponseCode {
  static const int SUCCESS = 0;
  static const int ERROR = 1;

  // 更多
}
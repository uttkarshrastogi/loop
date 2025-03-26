import 'package:dio/dio.dart';

class PerformanceInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['startTime'] = DateTime.now();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    DateTime startTime = response.requestOptions.extra['startTime'];
    DateTime endTime = DateTime.now();
    Duration duration = endTime.difference(startTime);
    print("API [${response.requestOptions.path}] took ${duration.inSeconds}s or ${duration.inMilliseconds}ms ");
    super.onResponse(response, handler);
  }
}

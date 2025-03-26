import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:toastification/toastification.dart';
import 'package:loop/core/config/api_config.dart';
import 'package:loop/core/config/flavor.dart';
import 'package:loop/core/services/performance_interceptor.dart';
import '../config/naviagtion_service.dart';
import '../widgets/globalLoader/bloc/bloc/loader_bloc.dart';
import 'api_exception.dart';

class ApiManager {
  final Dio _dio = Dio();
  final ApiException _apiException = ApiException();

  ApiManager() {
    // Add interceptors for logging and global error handling
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),

    ); _dio.interceptors.add(
      PerformanceInterceptor(),

    );

    // Add interceptor to handle errors globally
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) {
          // Use the ApiException to handle error messages
          String errorMessage = _apiException.getExceptionMessage(e);

          // Optional: Show a toast or log the error
          debugPrint('API Error: $errorMessage');

          // Forward the error with the modified message
          handler.next(DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            error: errorMessage,
            type: e.type,
          ));
        },
      ),
    );
  }

  Future<Response> sendRequest({
    required String url,
    required String method,
    dynamic data,
    Map<String, dynamic>? headers = const {},
    Map<String, dynamic>? queryParameters = const {},
    Function? onUploadProgress,
  }) async {
    return _dio.request(
      url,
      options: Options(method: method, headers: headers),
      queryParameters:
          queryParameters?.isNotEmpty == true ? queryParameters : null,
      data: data != null && method != 'GET' ? data : null,
      onReceiveProgress: onUploadProgress != null
          ? (count, total) => onUploadProgress(count, total)
          : null,
    );
  }
}

String _getUrlWithUrlVariables(String url, Map urlVariables) {
  String replacedUrl = url;
  urlVariables.forEach((key, value) {
    RegExp keyCheck = RegExp('\\{${key}\\}');

    replacedUrl = replacedUrl.replaceAll(keyCheck, value);
  });
  return replacedUrl;
}

Map _getRequestInfo(String host, String requestName, Map urlVariables) {
  print(FlavorConfig.config);
  ApiConfig? apiInfo = FlavorConfig.config.host?[host];

  Map info = {};
  if (apiInfo != null) {
    String tempUrl = apiInfo.url + apiInfo.apiEndpoints[requestName]!.path;
    info = {
      "url": _getUrlWithUrlVariables(tempUrl, urlVariables),
      "header": apiInfo.headerData,
      "method": apiInfo.apiEndpoints[requestName]!.method.name
    };
  }

  return info;
}
bool _isToastVisible = false; // Global flag to prevent multiple toasts

Future apiCall({
  required String host,
  required String requestName,
  Map<String, dynamic> queryParam = const {},
  dynamic param = const {},
  bool isMultipartRequest = false,
  Map<String, dynamic> customToken = const {},
  Map<String, dynamic> urlVariables = const {},
  Function? onUploadProgress,
  bool withToken = true,
  bool disableLoader = false,
  bool disableDefaultError = false,
}) async {
  // final AuthBloc authBloc = GetIt.instance<AuthBloc>();
  final LoaderBloc lBloc = GetIt.instance<LoaderBloc>();
  final apiManager = ApiManager();

  // Get API info
  Map info = _getRequestInfo(host, requestName, urlVariables);

  // Prepare headers
  Map<String, dynamic> headers = {
    "Content-Type":
        isMultipartRequest ? "multipart/form-data" : "application/json",
    ...info['header'],
  };

  // if (withToken) {
  //   String accessToken = '';
  //   final currentState = authBloc.state;
  //
  //   if (currentState is AuthVerified) {
  //     accessToken =
  //         '${currentState.response.tokenType![0].toUpperCase()}${currentState.response.tokenType!.substring(1)} ${currentState.response.accessToken ?? ""}';
  //
  //     if (customToken.isEmpty) {
  //       headers['Authorization'] = accessToken;
  //       // headers['Authorization'] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MDNhYjExNWEyZmQ1YWNjZGUzNjU5NyIsImV4cCI6MTc0MzA2NjYzNH0.5IAguKxFBfhLiE0CwhIc7FjproTvUPe7u_QjM2E-egY";
  //     }
  //   }
  //
  //   if (customToken.isNotEmpty) {
  //     headers.addAll(customToken);
  //   }
  // }

  final data = isMultipartRequest
      ? FormData.fromMap(Map<String, dynamic>.from(param))
      : param;

  // Show loader
  if (!disableLoader) {
    lBloc.add(const LoaderEvent.loadingON());
  }

  try {
    final response = await apiManager.sendRequest(
      url: info['url'],
      method: info['method'],
      data: data,
      headers: headers,
      queryParameters: queryParam,
      onUploadProgress: onUploadProgress,
    );

    // Close loader
    if (!disableLoader) {
      lBloc.add(const LoaderEvent.loadingOFF());
    }

    return response;
  } catch (err) {
    // Close loader
    if (!disableLoader) {
      lBloc.add(const LoaderEvent.loadingOFF());
    }

    if (!disableDefaultError) {
      final ApiException _apiException = ApiException();
      if (err is DioException && !_isToastVisible) {
        String errorMessage = _apiException.getExceptionMessage(err);
        _isToastVisible = true; // Set flag to prevent multiple toasts
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          title: Text(errorMessage, maxLines: 5),
          autoCloseDuration: const Duration(seconds: 5),
          icon: const Icon(Icons.error_outline),
          showProgressBar: false,
        );
        // Reset the flag after 5 seconds (or toast duration)
        Future.delayed(const Duration(seconds: 5), () {
          _isToastVisible = false;
        });
      }
    }


    // Log and rethrow the error
    debugPrint('API Call Error: $err');
    throw err;
  }
}

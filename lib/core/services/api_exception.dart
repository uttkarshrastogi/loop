import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loop/core/utils/prefrence_utils.dart';
import 'package:loop/core/utils/preference_key_constant.dart';
import 'package:loop/core/utils/prefrence_utils.dart';
import '../config/naviagtion_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ApiException {
  String getExceptionMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';

      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';

      case DioExceptionType.badResponse:
        String message = 'Something Went Wrong Please try again';
        if (exception.response != null) {
          try {
            if (exception.response?.statusCode == 500) {
              return "Internal Server error 500";
            }
            if (exception.response?.statusCode == 588) {
              SharedPrefHelper.remove(authData);
              // navigatorKey.currentState
              //     ?.pushReplacementNamed(SplashScreen.routeName);
              // NavigationService.go(Login.routeName);
            }
            Map<String, dynamic> responseData =
                jsonDecode(exception.response.toString());
            // Check for "message" key first
            if (responseData.containsKey('message')) {
              message = responseData['message'];
            }
            // Fallback to the first key's value if "message" is not available
            else if (responseData.isNotEmpty) {
              var firstKey = responseData.keys.first;
              var firstValue = responseData[firstKey];
              // Check if the value is a List (e.g., ["Invalid phone number."])
              if (firstValue is List && firstValue.isNotEmpty) {
                message = firstValue[0];
              }
              // Otherwise, use the value directly
              else if (firstValue is String) {
                message = firstValue;
              }
            }
          } catch (e) {
            // In case of JSON decoding error, keep the default server error message
            message = 'Something Went Wrong Please try again';
          }
        }
        return message;

      case DioExceptionType.cancel:
        return 'Request cancelled';

      case DioExceptionType.connectionError:
        return 'Check your internet connection';

      default:
        return 'Try again later';
    }
  }
}

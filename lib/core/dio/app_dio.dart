import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../constants/api_const.dart';
import '../constants/string_const.dart';

abstract class AppDio {
  //? singleton dio object
  static final _dio = _getDio();
  static Dio get instance => _dio;

  //? name to be display in console log
  static const _loggerName = " AppDio ";

  static Dio _getDio() {
    // auth dio object
    final _options = BaseOptions(
      baseUrl: ApiConst.baseURL,

      // 401 response is valid for ease in handle of token expiration
      validateStatus: (status) => (status == 200 || status == 401),
    );

    final _interceptor = InterceptorsWrapper(
      //? on request
      onRequest: (request, handler) async {
        log("🌎 🌎 🌎 🌎 🌎 🌎 # API # 🌎 🌎 🌎 🌎 🌎 🌎");
        log(
          '${request.uri} || ${request.headers} || ${request.data}',
          name: _loggerName,
        );
        handler.next(request);
      },

      //? on response
      onResponse: (response, handler) {
        log("💀 💀 💀 💀 💀 * RESPONSE * 💀 💀 💀 💀 💀");
        log(
          'STATUS: ${response.statusCode} | RESPONSE: ${json.encode(response.data)}',
          name: _loggerName,
        );
        switch (response.statusCode) {
          case 200:
            handler.next(response);
            break;
          case 401:
            log(StrConst.tokenExpire);
            handler.next(response);
            break;
          default:
            log(StrConst.somethingWrong);
            handler.reject(
              DioError(
                requestOptions: response.requestOptions,
                error: StrConst.somethingWrong,
              ),
            );
        }
      },

      //? on error
      onError: (error, handler) {
        log(
          'ERROR-TYPE: ${error.type}',
          error: error.error,
          name: _loggerName,
        );
        handler.next(error);
      },
    );

    //? return dio object with interceptor and base config
    return Dio(_options)..interceptors.add(_interceptor);
  }
}

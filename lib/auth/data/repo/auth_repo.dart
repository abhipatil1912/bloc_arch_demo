import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/api_const.dart';
import '../../../core/constants/string_const.dart';
import '../../../core/dio/app_dio.dart';
import '../../../core/dio/dio_exceptions.dart';
import '../models/register_model.dart';

abstract class AuthRepo {
  //? returns a raw auth data ( json string )
  static Future<Either<String, RegisterModel>> register(
    String name,
    String mobile,
  ) async {
    // //fake api response
    // await Future.delayed(const Duration(seconds: 2));
    // return right(RegisterModel());

    try {
      final data = {
        "name": name,
        "mobile": mobile,
      };
      final response =
          await AppDio.instance.post(ApiConst.register, data: data);
      //? success
      return right(registerModelFromJson(json.encode(response.data)));
    } on DioError catch (e, st) {
      final errorMsg = DioExceptions.errorString(e);
      log(
        "Error in register",
        error: errorMsg,
        stackTrace: st,
      );
      //? error msg
      return left(errorMsg);
    } catch (e, st) {
      log("Error in register", error: e, stackTrace: st);
      //? error msg
      return left(StrConst.somethingWrong);
    }
  }
}

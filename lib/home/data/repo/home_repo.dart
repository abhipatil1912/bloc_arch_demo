import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/api_const.dart';
import '../../../core/constants/string_const.dart';
import '../../../core/dio/app_dio.dart';
import '../../../core/dio/dio_exceptions.dart';
import '../model/users_model.dart';

abstract class HomeRepo {
  //? returns a List of Users
  static Future<Either<String, List<User>>> getUsers() async {
    try {
      final response = await AppDio.instance.get(ApiConst.users);
      //? success
      return right(usersFromJson(json.encode(response.data)));
    } on DioError catch (e, st) {
      final errorMsg = DioExceptions.errorString(e);
      log(
        "Error in getUsers",
        error: errorMsg,
        stackTrace: st,
      );
      //? error msg
      return left(errorMsg);
    } catch (e, st) {
      log("Error in getUsers", error: e, stackTrace: st);
      //? error msg
      return left(StrConst.somethingWrong);
    }
  }
}

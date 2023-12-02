import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/api.dart';
import '../../core/helper/dio_exception.dart';

class AuthRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future<bool> checkLogin(
      String strEmail, String strPassword, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().login,
          options: Options(headers: {
          }),
          data: {
            'username': strEmail,
            'password': strPassword
          }).timeout(Duration(seconds: Api().timeout));
      if (response?.statusCode == 200) {
        prefs.setBool('is_login', true);
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      return false;
    }
  }
}

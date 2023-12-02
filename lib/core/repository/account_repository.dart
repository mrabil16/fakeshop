import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/api.dart';
import '../../core/model/user_model.dart';
import '../../ui/widget/toast.dart';
import '../helper/dio_exception.dart';

class AccountRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future<UserModel?> getUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? ('fcm');
    try {
      response = await dio
          .get(
            '${Api().getUser}1',
            options: Options(headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token"
            }),
          )
          .timeout(Duration(seconds: Api().timeout));
      if (response?.statusCode == 200) {
        notifyListeners();
        final Map<String, dynamic> parsed = response?.data;
        final dataProfile = UserModel.fromJson(parsed);
        return dataProfile;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      if (e.response?.statusCode == 401) {
        debugPrint(response?.data);
      } else {
        Toasts.toastMessage(errorMessage);
      }
      return null;
    }
  }
}

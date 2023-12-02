import '../../locator.dart';
import '../../ui/widget/toast.dart';
import '/core/constant/viewstate.dart';
import '../../core/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_viewmodel.dart';

class AuthViewModel extends BaseViewModel {
  AuthRepository authRepository = locator<AuthRepository>();

  bool isLogin = false;
  bool hidePass = true;
  bool hidePass2 = true;
  bool hidePass3 = true;

  void changeHidePass() {
    hidePass = !hidePass;
    notifyListeners();
  }

  void changeHidePass2() {
    hidePass2 = !hidePass2;
    notifyListeners();
  }

  void changeHidePass3() {
    hidePass3 = !hidePass3;
    notifyListeners();
  }

  Future<void> checkSessionLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    isLogin = prefs.getBool('is_login') ?? false;
    notifyListeners();
  }

  Future<bool> checkLogin(
      String strEmail, String strPassword, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (strEmail == "" || strPassword == "") {
      Toasts.toastMessage("Please complete this form");
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Busy);
    var success =
        await authRepository.checkLogin(strEmail, strPassword, context);
    if (!success) {
      print('333333');
      Toasts.toastMessage(prefs.getString('message')!);
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Idle);
    return success;
  }

  void init(BuildContext context) {}
}

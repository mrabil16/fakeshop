import 'dart:io';

import '../../ui/widget/toast.dart';
import '/core/constant/viewstate.dart';
import '../../core/model/user_model.dart';
import '../../core/repository/account_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import 'base_viewmodel.dart';

class AccountViewModel extends BaseViewModel {
  AccountRepository accountRepository = locator<AccountRepository>();
  UserModel? user;

  bool isLogin = false;
  bool hidePass = true;
  bool hidePass2 = true;
  String? name;

  void init(BuildContext context) async {
    await checkSessionLogin();

    try {
      if (isLogin == true) {
        getUser(context);
        var prefs = await SharedPreferences.getInstance();
        name = prefs.getString('username');
      } else {
        name = null;
      }
    } catch (e) {}
  }

  void changeHidePass() {
    hidePass = !hidePass;
    notifyListeners();
  }

  void changeHidePass2() {
    hidePass = !hidePass;
    notifyListeners();
  }

  Future<void> checkSessionLogin() async {
    setState(ViewState.Busy);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('is_login') ?? false;
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    try {
      user = await accountRepository.getUser(context);
      if (user != null) {
        name = prefs.getString('username');
      }
      notifyListeners();
      setState(ViewState.Idle);
    } catch (e) {
      print(e);
      return false;
    }
  }
}

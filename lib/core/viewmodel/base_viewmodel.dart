import 'package:flutter/material.dart';
import '../constant/viewstate.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  bool _dispose = false;

  ViewState get state => _state;

  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_dispose) super.notifyListeners();
  }

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}

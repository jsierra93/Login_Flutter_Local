import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  String _user;
  String _pass;
  bool _isLogin;

  String get user => _user;
  String get pass => _pass;
  bool get isLogin => _isLogin;

  set user(String user) {
    _user = user;
    notifyListeners();
  }

  set pass(String pass) {
    _pass = pass;
    notifyListeners();
  }

  set isLogin(bool login) {
    _isLogin = login;
    notifyListeners();
  }
}

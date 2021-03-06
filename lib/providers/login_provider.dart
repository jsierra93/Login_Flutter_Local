import 'package:flutter/foundation.dart';
import 'package:SqliteFlutter/services/user_db.dart';

class LoginProvider with ChangeNotifier {
  String _email;
  String _user;
  String _pass;
  bool _isLogin;

  String get user => _user;
  String get email => _email;
  String get pass => _pass;
  bool get isLogin => _isLogin;

  set user(String user) {
    _user = user;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
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

  Future<bool> autenticar() async => UserDb.db.authenticator(_email, _pass).then((onValue) {
      print('autenticar: $onValue');
      isLogin = onValue;
      return onValue;
    });

}

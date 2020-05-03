import 'package:login_flutter_local/services/user_db.dart';

class User {
  String email;
  String pass;
  String profile;

  User({this.email, this.pass, this.profile});

  Map<String, dynamic> toMap() {
    return {
      UserDb.COLUMN_EMAIL: email,
      UserDb.COLUMN_PASS: pass,
      UserDb.COLUMN_PROFILE: profile
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    email = map[UserDb.COLUMN_EMAIL];
    pass = map[UserDb.COLUMN_PASS];
    profile = map[UserDb.COLUMN_PROFILE];
  }

  @override
  String toString() {
    return 'User{email: $email, pass: $pass, profile: $profile}';
  }
}

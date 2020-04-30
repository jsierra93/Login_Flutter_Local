class User {
  final String email;
  final String pass;
  final String profile;

  User({this.email, this.pass, this.profile});

  Map<String, dynamic> toMap() {
    return {
      'user': email,
      'pass': pass,
      'profile': profile,
    };
  }

  @override
  String toString() {
    return 'User{user: $email, pass: $pass, profile: $profile}';
  }
}

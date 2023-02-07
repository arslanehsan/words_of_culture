class LoginUserObject {
  String? email, password, uid;
  String country, phoneNumber;
  bool keepLogin;

  LoginUserObject({
    required this.email,
    required this.uid,
    required this.password,
    required this.phoneNumber,
    required this.country,
    required this.keepLogin,
  });
}

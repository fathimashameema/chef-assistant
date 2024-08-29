class LoginStatus {
  static final LoginStatus _instance = LoginStatus._internal();

  bool isAdmin = false;
  late bool isLogged = false;
  String currentUser = '';
  String currentPassword = '';
  late bool hasSeenIntro = false;
  int? currentUserId ;

  factory LoginStatus() {
    return _instance;
  }

  LoginStatus._internal();
}

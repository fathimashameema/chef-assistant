import 'package:chef_assistant/db_functions/login_status.dart';
import 'package:chef_assistant/db_functions/login_status_functions.dart';
import 'package:chef_assistant/models/user_values.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Login {
  Box<UserValues>? _uservaluesbox;

  Future<void> openBox() async {
    if (_uservaluesbox == null || !_uservaluesbox!.isOpen) {
      _uservaluesbox = await Hive.openBox<UserValues>('uservalues');
      print({_uservaluesbox!.name, _uservaluesbox!.path});
    }
  }

  Future<void> closeBox() async {
    if (_uservaluesbox != null && _uservaluesbox!.isOpen) {
      await _uservaluesbox!.close();
    }
  }

  Future<void> setAdminStatus(bool isAdmin) async {
    await openBox();
    var user = _uservaluesbox!.get(LoginStatus().currentUserId);
    if (user != null) {
      user.isAdmin = isAdmin;
      await user.save(); // Save the updated object to persist changes
      print('Admin status updated: $isAdmin');
    }
  }

  Future<void> setLoginStatus(bool isLogged) async {
    await openBox();
    var user = _uservaluesbox!.get(LoginStatus().currentUserId);
    if (user != null) {
      user.isLogged = isLogged;
      await user.save(); // Save the updated object to persist changes
      print('Login status updated: $isLogged');
    }
  }

  Future<void> setHasSeenIntro(bool hasSeenIntro) async {
    await openBox();
    var user = _uservaluesbox!.get(LoginStatus().currentUserId);
    if (user != null) {
      user.hasSeenIntro = hasSeenIntro;
      await user.save(); // Save the updated object to persist changes
      print('Intro seen status updated: $hasSeenIntro');
    }
  }

  Future<bool> getAdminStatus() async {
    await openBox();
    var user = _uservaluesbox!.get(LoginStatus().currentUserId);
    print('Fetched admin status: ${user?.isAdmin ?? false}');
    return user?.isAdmin ?? false;
  }

  Future<bool> getLoginStatus() async {
    await openBox();
    var user = _uservaluesbox!.get(LoginStatus().currentUserId);
    print('Fetched login status: ${user?.isLogged ?? false}');
    return user?.isLogged ?? false;
  }

  Future<bool> getHasSeenIntro() async {
    await openBox();
    var user = _uservaluesbox!.get(LoginStatus().currentUserId);
    print('Fetched intro seen status: ${user?.hasSeenIntro ?? false}');
    return user?.hasSeenIntro ?? false;
  }

  Future<String> getUsername() async {
    await openBox();

    for (final user in _uservaluesbox!.values) {
      // Store the user's ID (key)
      LoginStatus().currentUserId = _uservaluesbox!.keys
          .cast<int>()
          .firstWhere((key) => _uservaluesbox!.get(key) == user);

      LoginStatus().currentUser = user.username.trim();
      print('Fetched username: ${user.username}');
      LoginStatus().currentPassword = user.password.trim();
    }
    return LoginStatus().currentUser;
  }

  Future<bool> getUser({
    required String usernameoremail,
    required String password,
  }) async {
    await openBox();

    for (final user in _uservaluesbox!.values) {
      if ((user.username.trim() == usernameoremail.trim() ||
              user.email?.trim() == usernameoremail.trim()) &&
          user.password.trim() == password.trim()) {
        // Store the user's ID (key)
        LoginStatus().currentUserId = _uservaluesbox!.keys
            .cast<int>()
            .firstWhere((key) => _uservaluesbox!.get(key) == user);

        LoginStatus().currentUser = user.username.trim();
        LoginStatus().currentPassword = user.password.trim();

        // Set user as logged in and save the status
        await setLoginStatus(true);
        return true;
      }
    }

    return false;
  }

  void userLogin() {
    LoginStatus().isAdmin = false;
    LoginStatus().isLogged = true;
    setLoginStatus(true);
    setIsUserLogged(true);
    setIsAdminLogged(false);
  }

  void adminLogin() async {
    LoginStatus().isAdmin = true;
    // LoginStatus().isLogged = true;
    setAdminStatus(true);
  }

  void adminLogout() {
    LoginStatus().isAdmin = false;
    LoginStatus().isLogged = false;
    setAdminStatus(false);
  }

  Future<void> hasSeenIntro() async {
    await openBox();
    // for (var value in _uservaluesbox!.values) {
    //   Hive.box('uservalues').put(hasSeenIntro, true);
    //   LoginStatus().hasSeenIntro = value.hasSeenIntro;
    // }
    LoginStatus().hasSeenIntro = true;
    setHasSeenIntro(true);
  }

  Future<void> logOutUser() async {
    await openBox();

    var currentUser = _uservaluesbox!.get(LoginStatus().currentUserId);
    if (currentUser != null) {
      currentUser.isLogged = false;
      await currentUser.save();
      print('Logout done');
    }

    LoginStatus().isLogged = false;
    LoginStatus().currentUser = '';
    LoginStatus().currentPassword = '';
  }

  Future<void> updateUsername(
      {required int index, required String username}) async {
    await openBox();
    var user = _uservaluesbox!.getAt(index);
    if (user != null) {
      user.username = username;
      await user.save();
    }
  }

  Future<void> updatePassword(
      {required int index, required String password}) async {
    await openBox();
    var user = _uservaluesbox!.getAt(index);
    if (user != null) {
      user.password = password;
      await user.save();
    }
  }
}

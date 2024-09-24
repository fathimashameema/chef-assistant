import 'package:chef_assistant/functions/login_status.dart';
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

  Future<bool> getUser({
    required String usernameoremail,
    required String password,
  }) async {
    await openBox();

    for (final user in _uservaluesbox!.values) {
      if ((user.username.trim() == usernameoremail.trim() ||
              user.email?.trim() == usernameoremail.trim()) &&
          user.password.trim() == password.trim()) {
        // Store the user's ID (key) under the 'currentUser' key
        // await _uservaluesbox!.put('currentUser', user.key);

        LoginStatus().currentUserId = _uservaluesbox!.keys
            .cast<int>()
            .firstWhere((key) => _uservaluesbox!.get(key) == user);

        LoginStatus().currentUser = user.username.trim();
        LoginStatus().currentPassword = user.password.trim();
        user.isLogged = true;
        LoginStatus().isLogged = user.isLogged;

        return true;
      }
    }

    return false;
  }

  void userLogin() {
    LoginStatus().isAdmin = false;
    LoginStatus().isLogged = true;
  }

  void adminLogin() {
    LoginStatus().isAdmin = true;
    // LoginStatus().isLogged = true;
  }

  void adminLogout() {
    LoginStatus().isAdmin = false;
    LoginStatus().isLogged = false;
  }

  Future<void> hasSeenIntro() async {
    await openBox();
    for (var value in _uservaluesbox!.values) {
      Hive.box('uservalues').put(hasSeenIntro, true);
      LoginStatus().hasSeenIntro = value.hasSeenIntro;
    }
  }

  Future<void> logOutUser() async {
    if (_uservaluesbox == null || !_uservaluesbox!.isOpen) {
      await openBox();
    }

    // Find the current user
    var currentUser = _uservaluesbox!.values.firstWhere(
      (user) => user.username == LoginStatus().currentUser,
      orElse: () => UserValues(username: '', password: ''),
    );

    if (currentUser.username.isNotEmpty) {
      currentUser.isLogged = false;
      await currentUser.save();
      print('logout done');
    }

    LoginStatus().isLogged = false;
    LoginStatus().currentUser = '';
    LoginStatus().currentPassword = '';
  }

  Future<void> updateUsername(
      {required int index, required String username}) async {
    if (_uservaluesbox == null || !_uservaluesbox!.isOpen) {
      await openBox();
    }
    UserValues? user = _uservaluesbox!.getAt(index);
    if (user != null) {
      user.username = username;
    }

    await user!.save();
  }

  Future<void> updatePassword(
      {required int index, required String password}) async {
    if (_uservaluesbox == null || !_uservaluesbox!.isOpen) {
      await openBox();
    }
    UserValues? user = _uservaluesbox!.getAt(index);
    if (user != null) {
      user.password = password;
    }

    await user!.save();
  }
}

import 'package:chef_assistant/functions/login_status.dart';
import 'package:chef_assistant/models/user_values.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Signup {
  Box<UserValues>? _userValuesBox;

  Future<void> openBox() async {
    _userValuesBox = await Hive.openBox<UserValues>('uservalues');
  }

  Future<void> closeBox() async {
    await _userValuesBox!.close();
  }

  Future<void> addUserValues(UserValues uservalues) async {
    if (_userValuesBox == null || _userValuesBox!.isEmpty) {
      await openBox();
    }
    uservalues.id = _userValuesBox!.length;
    await _userValuesBox!.add(uservalues);
    LoginStatus().currentPassword = uservalues.password;
    LoginStatus().currentUser = uservalues.username;
    for (var user in _userValuesBox!.values) {
      LoginStatus().currentUserId = _userValuesBox!.keys
          .cast<int>()
          .firstWhere((key) => _userValuesBox!.get(key) == user);
    }
  }

  Future<List<UserValues>> getUserValues() async {
    if (_userValuesBox == null || _userValuesBox!.isEmpty) {
      await openBox();
    }

    return _userValuesBox!.values.toList();
  }

  bool isUsernameExist(String username) {
    if (_userValuesBox == null || _userValuesBox!.isEmpty) {
      openBox();
    }
    return _userValuesBox!.values.any((user) => user.username == username);
  }

  bool isEmailExist(String email) {
    if (_userValuesBox == null || _userValuesBox!.isEmpty) {
      openBox();
    }
    return _userValuesBox!.values.any((user) => user.email == email);
  }
}

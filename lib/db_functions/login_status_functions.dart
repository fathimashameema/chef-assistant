import 'package:hive_flutter/hive_flutter.dart';

Box? _loginStatusBox;

Future<void> openLoginStatus() async {
  _loginStatusBox = await Hive.openBox('loginStatusBox');
}

Future<void> setHasSeenIntro(bool value) async {
  await openLoginStatus();
  _loginStatusBox!.put('hasSeenIntro', value);
  print('introduction screen have seen $value');
}

Future<bool?> getHasSeenIntro() async {
  await openLoginStatus();
  return _loginStatusBox!.get('hasSeenIntro');
}

Future<void> setIsAdminLogged(bool value) async {
  await openLoginStatus();
  _loginStatusBox!.put('isAdmin', value);
  print('admin logged set to $value');
}

Future<bool?> getIsAdminLogged() async {
  await openLoginStatus();
    print('admin is getting');
  return _loginStatusBox!.get('isAdmin');
}

Future<void> setIsUserLogged(bool value) async {
  await openLoginStatus();
  _loginStatusBox!.put('isLogged', value);
  print(' user logged set to $value');
}

Future<bool?> getIsUserLogged() async {
  await openLoginStatus();
  return _loginStatusBox!.get('isLogged');
}

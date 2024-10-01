import 'package:hive_flutter/hive_flutter.dart';

part 'login_status_model.g.dart';

@HiveType(typeId: 7)
class LoginStatusModel {
  @HiveField(0)
  bool isAdmin;

  @HiveField(1)
  bool isLogged ;

  @HiveField(3)
  bool hasSeenIntro ;

  LoginStatusModel({
    this.hasSeenIntro = false,
    this.isAdmin = false,
    this.isLogged = false,
  });
}

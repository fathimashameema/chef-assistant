import 'package:hive_flutter/hive_flutter.dart';
part 'user_values.g.dart';

@HiveType(typeId: 0)
class UserValues extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String password;

  @HiveField(2)
  late String? email;

  @HiveField(3)
  int? id;

  @HiveField(4)
  late bool isAdmin;

  @HiveField(5)
  late bool isLogged;

  @HiveField(6)
  late bool hasSeenIntro;

  UserValues({
    required this.username,
    required this.password,
    this.email,
    this.id,
    this.hasSeenIntro = false,
    this.isAdmin = false,
    this.isLogged = false,
  });
}

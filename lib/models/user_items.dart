import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
part  'user_items.g.dart';

@HiveType(typeId: 4)
class UserItems {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final String? prepTime;

  @HiveField(3)
  final List<String>? ingredients;

  @HiveField(4)
  final String? directions;

  @HiveField(5)
  Uint8List? image;

  @HiveField(6)
  bool? isVeg;

  @HiveField(7)
  List<String>? categories;

  UserItems({
    this.title,
    this.description,
    this.prepTime,
    this.ingredients,
    this.directions,
    this.categories,
    this.image,
    this.isVeg,
  });
}

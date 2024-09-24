import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
part 'recipe_items.g.dart';

@HiveType(typeId: 1)
class RecipeItems extends HiveObject {
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

  RecipeItems({
    this.isVeg,
    this.title,
    this.description,
    this.prepTime,
    this.ingredients,
    this.directions,
    this.image,
    this.categories,
  });
}

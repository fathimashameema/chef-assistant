import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'recipe_items.g.dart';

@HiveType(typeId: 1)
class RecipeItems extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late String prepTime;

  @HiveField(3)
  late String ingredients;

  @HiveField(4)
  late String directions;

  @HiveField(5)
  late Image image;

  RecipeItems({
    required String title,
    String? description,
    String? prepTime,
    required String ingredients,
    required String directions,
    Image? image,
  });
}

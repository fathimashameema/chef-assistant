import 'package:chef_assistant/models/recipe_items.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'favourites_model.g.dart';

@HiveType(typeId: 5)
class FavouritesModel {
  @HiveField(0)
  RecipeItems favouriteItem;

  FavouritesModel({required this.favouriteItem});
}

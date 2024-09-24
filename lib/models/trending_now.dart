import 'package:chef_assistant/models/recipe_items.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'trending_now.g.dart';

@HiveType(typeId: 2)
class TrendingNow extends HiveObject {
  @HiveField(0)
  RecipeItems trendingItems;

  TrendingNow({
    required this.trendingItems,
  });
}

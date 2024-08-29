import 'package:chef_assistant/models/recipe_items.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddItem {
  Box<RecipeItems>? _recipeItemsbox;

  Future<void> openRecipeBox() async {
    if (_recipeItemsbox == null || !_recipeItemsbox!.isOpen) {
      _recipeItemsbox = await Hive.openBox('recipebox');
    }
    print(_recipeItemsbox!.name);
  }

  Future<void> closeRecipeBox() async {
    if (_recipeItemsbox!.isOpen && _recipeItemsbox != null) {
      await _recipeItemsbox!.close();
    }
  }

  Future<void> addRecipe(RecipeItems recipeItem) async {
    if (_recipeItemsbox == null || _recipeItemsbox!.isEmpty) {
      await openRecipeBox();
    }
    _recipeItemsbox!.add(recipeItem);
  }
}

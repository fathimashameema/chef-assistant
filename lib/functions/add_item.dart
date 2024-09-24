import 'package:chef_assistant/models/recipe_items.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddItem {
  ValueNotifier<List<RecipeItems>> recipeItemsNotifier = ValueNotifier([]);
  Box<RecipeItems>? _recipeItemsbox;

  Future<void> openRecipeBox() async {
    if (_recipeItemsbox == null || !_recipeItemsbox!.isOpen) {
      _recipeItemsbox = await Hive.openBox<RecipeItems>('recipebox');
    }
    print(_recipeItemsbox!.name);
    recipeItemsNotifier.value = _recipeItemsbox!.values.toList();
  }

  Future<void> closeRecipeBox() async {
    if (_recipeItemsbox!.isOpen && _recipeItemsbox != null) {
      await _recipeItemsbox!.close();
    }
  }

  Future<void> addRecipe(RecipeItems recipeItem) async {
    await openRecipeBox();
    _recipeItemsbox!.add(recipeItem);
    recipeItemsNotifier.value = _recipeItemsbox!.values.toList();
    recipeItemsNotifier.notifyListeners();
    print('recipe added');
  }

  Future<void> editRecipe(
      {required int index, required RecipeItems recipeItem}) async {
    await openRecipeBox();
    _recipeItemsbox!.putAt(index, recipeItem);
    recipeItemsNotifier.value = _recipeItemsbox!.values.toList();
    recipeItemsNotifier.notifyListeners();
    getRecipes();
    print('edited recipe');
  }

  Future<void> deleteRecipe(int index) async {
    await openRecipeBox();
    _recipeItemsbox!.deleteAt(index);
    recipeItemsNotifier.value = _recipeItemsbox!.values.toList();
    recipeItemsNotifier.notifyListeners();
  }

  Future<List<RecipeItems>> getRecipes() async {
    await openRecipeBox();
    // return recipeItemsNotifier.value;
    return _recipeItemsbox!.values.toList();
  }

  Future<List<RecipeItems>> nonVegRecipe() async {
    await openRecipeBox();
    final nonVegItems =
        recipeItemsNotifier.value.where((item) => item.isVeg == false).toList();
    print('All non-veg: $nonVegItems');
    return nonVegItems;
  }

  Future<List<RecipeItems>> veganRecipe() async {
    await openRecipeBox();
    final veganItems =
        recipeItemsNotifier.value.where((item) => item.isVeg == true).toList();
    print('All vegan: $veganItems');
    return veganItems;
  }
}

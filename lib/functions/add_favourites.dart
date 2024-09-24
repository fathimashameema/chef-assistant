import 'package:chef_assistant/models/favourites_model.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddFavourites {
  Box<FavouritesModel>? _favouritesBox;
  ValueNotifier<List<FavouritesModel>> favouritesNotifier = ValueNotifier([]);
  Future<void> openFavouritesBox() async {
    if (_favouritesBox == null || !_favouritesBox!.isOpen) {
      _favouritesBox = await Hive.openBox<FavouritesModel>('favouriteBox');
    }
    favouritesNotifier.value = _favouritesBox!.values.toList();
    print(_favouritesBox!.name);
  }

  Future<void> closeFavouritesBox() async {
    if (_favouritesBox != null && _favouritesBox!.isOpen) {
      await _favouritesBox!.close();
    }
  }

  Future<void> addFavourites(FavouritesModel favRecipe) async {
    await openFavouritesBox();
    _favouritesBox!.add(favRecipe);
    favouritesNotifier.value = _favouritesBox!.values.toList();
  }

  Future<List<FavouritesModel>> getFavourites() async {
    await openFavouritesBox();
    favouritesNotifier.value = _favouritesBox!.values.toList();

    return _favouritesBox!.values.toList();
  }

  Future<void> deleteFavourite(int index) async {
    await openFavouritesBox();
    _favouritesBox!.deleteAt(index);
    favouritesNotifier.value = _favouritesBox!.values.toList();
  }

  Future<void> isFavouriteExist(
      RecipeItems recipe, FavouritesModel favRecipe, int index) async {
    await openFavouritesBox();
    final isFavExist = _favouritesBox!.values
        .any((value) => value.favouriteItem.title == recipe.title);

    if (isFavExist == true) {
      await deleteFavourite(index);
    } else {
      await addFavourites(favRecipe);
    }
    favouritesNotifier.value = _favouritesBox!.values.toList();
  }

  Future<bool> containfavItem(RecipeItems recipe) async {
    await openFavouritesBox();
    return _favouritesBox!.values
        .any((value) => value.favouriteItem.title == recipe.title);
  }

  Future<void> deleteFavIfExist(RecipeItems recipe) async {
    await openFavouritesBox();
    final boxKeys = _favouritesBox!.keys;
    final boxValues = _favouritesBox!.values;

    for (int i = 0; i < boxValues.length; i++) {
      final RecipeItems currentRecipe = boxValues.elementAt(i).favouriteItem;

      if (currentRecipe.title == recipe.title) {
        await _favouritesBox!.delete(boxKeys.elementAt(i));

        favouritesNotifier.value = _favouritesBox!.values.toList();
        print('Recipe "${recipe.title}" deleted from favouritess box.');
        return;
      }
    }

    print('Recipe "${recipe.title}" not found in favourites box.');
  }
}

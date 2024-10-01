import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/models/trending_now.dart';
import 'package:chef_assistant/screens/admin/admin_homepage.dart';
import 'package:chef_assistant/screens/admin/trending_now/tending_now.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddTrendingNow {
  Box<TrendingNow>? _trendingNowBox;
  Future<void> openBox() async {
    if (_trendingNowBox == null || !_trendingNowBox!.isOpen) {
      _trendingNowBox = await Hive.openBox<TrendingNow>('trendingnowbox');
      print('trending now box opened ');
    }
  }

  Future<void> closeBox() async {
    if (_trendingNowBox != null && _trendingNowBox!.isOpen) {
      await _trendingNowBox!.close();
    }
  }

  Future<void> addTrendings({
    required TrendingNow trendingItems,
  }) async {
    await openBox();
    _trendingNowBox!.add(trendingItems);
    trendingNowNotifier.value = _trendingNowBox!.values.toList();
    print('trending item added');
    print(_trendingNowBox!.values);
    // getTrendings();
    trendingNowNotifier.notifyListeners();
  }

  Future<List<TrendingNow>> getTrendings() async {
    await openBox();
    trendingNowNotifier.value = _trendingNowBox!.values.toList();
    // trendingNowNotifier.notifyListeners();
    filteredTrendings.value = _trendingNowBox!.values.toList();
    return _trendingNowBox!.values.toList();
  }

  Future<List<TrendingNow>> nonVegTrendings() async {
    await openBox();
    final allTrendings = _trendingNowBox!.values.toList();
    final nonVegTrending = allTrendings
        .where((item) => item.trendingItems.isVeg == false)
        .toList();
    filteredTrendings.value = nonVegTrending;
    print('nonVegTrending $nonVegTrending');
    getTrendings();
    return nonVegTrending;
  }

  Future<List<TrendingNow>> veganTrendings() async {
    await openBox();
    final allTrendings = _trendingNowBox!.values.toList();
    final veganTrending =
        allTrendings.where((item) => item.trendingItems.isVeg == true).toList();
    filteredTrendings.value = veganTrending;
    print('veganTrending $veganTrending');
    getTrendings();
    return veganTrending;
  }

  Future<void> deleteTrendingItem({required int index}) async {
    await openBox();
    // _trendingNowList!.remove(recipe);
    await _trendingNowBox!.deleteAt(index);
    trendingNowNotifier.value = _trendingNowBox!.values.toList();
    print('Item deleted');
    print(_trendingNowBox!.values);

    // getTrendings();
    trendingNowNotifier.notifyListeners();
  }

  Future<bool> isItemExist(RecipeItems recipe) async {
    await openBox();
    return _trendingNowBox!.values
        .any((element) => element.trendingItems.title == recipe.title);
  }

  Future<void> deleteItemIfExist(RecipeItems recipe) async {
    await openBox();

    final boxKeys = _trendingNowBox!.keys;
    final boxValues = _trendingNowBox!.values;

    for (int i = 0; i < boxValues.length; i++) {
      final RecipeItems currentRecipe = boxValues.elementAt(i).trendingItems;

      if (currentRecipe.title == recipe.title) {
        await _trendingNowBox!.delete(boxKeys.elementAt(i));

        trendingNowNotifier.value = _trendingNowBox!.values.toList();
        print('Recipe "${recipe.title}" deleted from Trending Now box.');
        return;
      }
    }

    print('Recipe "${recipe.title}" not found in Trending Now box.');
  }
}

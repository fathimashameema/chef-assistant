import 'package:chef_assistant/models/categories_model.dart';
import 'package:chef_assistant/screens/admin/categories_add.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddCategories {
  Box<CategoriesModel>? _categoriesBox;

  Future<void> openCategoriesBox() async {
    if (_categoriesBox == null || !_categoriesBox!.isOpen) {
      _categoriesBox = await Hive.openBox<CategoriesModel>('categories box');
    }
    print(_categoriesBox!.name);
  }

  Future<void> closeCategoriesBox() async {
    if (_categoriesBox != null && _categoriesBox!.isOpen) {
      await _categoriesBox!.close();
    }
  }

  Future<void> addCategories({required CategoriesModel category}) async {
    if (_categoriesBox == null || _categoriesBox!.isEmpty) {
      await openCategoriesBox();
    }
    await _categoriesBox!.add(category);
    categoryNotifier.value = _categoriesBox!.values.toList();
    categoryNotifier.notifyListeners();
    print('category added');
  }

  Future<List<CategoriesModel>> getCategories() async {
    await openCategoriesBox();
    categoryNotifier.value = _categoriesBox!.values.toList();
    // categoryNotifier.notifyListeners();
    return _categoriesBox!.values.toList();
  }

  Future<void> deleteCategory(int index) async {
    await openCategoriesBox();
    _categoriesBox!.deleteAt(index);
    categoryNotifier.value = _categoriesBox!.values.toList();
    categoryNotifier.notifyListeners();

    print('category deleted');
  }

  Future<List<String>> getCategoryNames() async {
    await openCategoriesBox();
    List<String> categoryNames = [];
    for (var value in _categoriesBox!.values) {
      categoryNames.add(value.name);
    }
    print('category names $categoryNames');
    return categoryNames;
  }

  Future<String> getCategory(int index) async {
    await openCategoriesBox();
    List<String> categoryNames = [];
    for (var value in _categoriesBox!.values) {
      categoryNames.add(value.name);
    }
    print('category ${categoryNames[index]}');
    return categoryNames[index];
  }

  Future<void> editCtegory(
      {required int index, required CategoriesModel category}) async {
    await openCategoriesBox();
    _categoriesBox!.putAt(index, category);
    categoryNotifier.value = _categoriesBox!.values.toList();
    categoryNotifier.notifyListeners();
    print('edited');
  }

  Future<bool> isItemExist(CategoriesModel category) async {
    await openCategoriesBox();
    return _categoriesBox!.values
        .any((element) => element.name == category.name);
  }
}

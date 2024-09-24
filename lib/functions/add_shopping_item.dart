import 'package:chef_assistant/models/shopping_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddShoppingItem {
  Box<ShoppingCartModel>? _shoppingCartBox;
  ValueNotifier<List<ShoppingCartModel>> shoppingCartNotifier =
      ValueNotifier([]);

  Future<void> openShoppingCartBox() async {
    if (_shoppingCartBox == null || !_shoppingCartBox!.isOpen) {
      _shoppingCartBox =
          await Hive.openBox<ShoppingCartModel>('shoppingCartBox');
      shoppingCartNotifier.value = _shoppingCartBox!.values.toList();
    }
  }

  Future<void> closeShoppingCartBox() async {
    if (_shoppingCartBox != null && _shoppingCartBox!.isOpen) {
      await _shoppingCartBox!.close();
    }
  }

  Future<void> addItemTocart(ShoppingCartModel cartItem) async {
    await openShoppingCartBox();
    _shoppingCartBox!.add(cartItem);
    shoppingCartNotifier.value = _shoppingCartBox!.values.toList();
    print(cartItem.item);
  }

  Future<List<ShoppingCartModel>> getCartItems() async {
    await openShoppingCartBox();
    return _shoppingCartBox!.values.toList();
  }

  // Future<void> removeItemFromCart(int index) async {
  //   await openShoppingCartBox();
  //   _shoppingCartBox!.deleteAt(index);
  //   shoppingCartNotifier.value = _shoppingCartBox!.values.toList();
  // }

  Future<void> removeItemFromCart(String item) async {
    await openShoppingCartBox();

    final Map<dynamic, dynamic> cartItemsMap = _shoppingCartBox!.toMap();
    dynamic keyToDelete;

    cartItemsMap.forEach((key, value) {
      if (value.item == item) {
        keyToDelete = key;
      }
    });

    if (keyToDelete != null) {
      await _shoppingCartBox!.delete(keyToDelete);
      shoppingCartNotifier.value = _shoppingCartBox!.values.toList();
    } else {
      print('Item not found in the shopping cart');
    }
  }
}

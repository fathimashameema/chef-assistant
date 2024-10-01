import 'package:chef_assistant/models/user_items.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserAddItems {
  ValueNotifier<List<UserItems>> userItemNotifier = ValueNotifier([]);
  Box<UserItems>? _userItemsBox;

  Future<void> openUserItemBox() async {
    if (_userItemsBox == null || !_userItemsBox!.isOpen) {
      _userItemsBox = await Hive.openBox<UserItems>('userItems');
    }
    print(_userItemsBox!.name);
    userItemNotifier.value = _userItemsBox!.values.toList();
  }

  Future<void> closeUserItemBox() async {
    if (_userItemsBox != null && _userItemsBox!.isOpen) {
      _userItemsBox!.close();
    }
  }

  Future<void> addUserItem(UserItems userItem) async {
    await openUserItemBox();
    _userItemsBox!.add(userItem);
    userItemNotifier.value = _userItemsBox!.values.toList();
  }

  Future<List<UserItems>> getUserItems() async {
    await openUserItemBox();
    return _userItemsBox!.values.toList();
  }

  Future<void> deleteUserItems(int index) async {
    await openUserItemBox();
    _userItemsBox!.deleteAt(index);
    userItemNotifier.value = _userItemsBox!.values.toList();
  }
}

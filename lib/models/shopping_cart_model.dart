import 'package:hive_flutter/hive_flutter.dart';

part 'shopping_cart_model.g.dart';

@HiveType(typeId: 6)
class ShoppingCartModel {
  @HiveField(0)
  String item;

  ShoppingCartModel({required this.item});
}

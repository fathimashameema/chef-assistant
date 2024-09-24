import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
part 'categories_model.g.dart';

@HiveType(typeId: 3)
class CategoriesModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  Uint8List? image;

  CategoriesModel({
    required this.name,
    this.image,
  });
}

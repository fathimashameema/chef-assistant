import 'dart:typed_data';

class UserRecipeValues {
  String? title;
  String? description;
  String? prepTime;
  List<String>? ingredients;
  bool? isVeg;
  List<String>? categories;
  Uint8List? image;
  UserRecipeValues({
    this.image,
    this.title,
    this.description,
    this.prepTime,
    this.ingredients,
    this.isVeg,
    this.categories,
  });
  static UserRecipeValues obj = UserRecipeValues();
}

import 'dart:typed_data';

class RecipeValues {
  String? title;
  String? description;
  String? prepTime;
  List<String>? ingredients;
  bool? isVeg;
  List<String>? categories;
  Uint8List? image;
  RecipeValues({
    this.image,
    this.title,
    this.description,
    this.prepTime,
    this.ingredients,
    this.isVeg,
    this.categories,
  });
  static RecipeValues obj = RecipeValues();
}

import 'dart:typed_data';

class EditRecipeValues {
  String? title;
  String? descrption;
  String? prepTime;
  List<String>? ingredients;
  bool? isVeg;
  List<String>? categories;
  Uint8List? image;
  EditRecipeValues({
    this.image,
    this.title,
    this.descrption,
    this.prepTime,
    this.ingredients,
    this.isVeg,
    this.categories,
  });
  static EditRecipeValues obj = EditRecipeValues();
}

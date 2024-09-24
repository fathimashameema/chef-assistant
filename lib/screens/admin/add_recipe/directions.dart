import 'dart:typed_data';

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/functions/add_item.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/screens/admin/add_recipe/recipe_values.dart';
import 'package:flutter/material.dart';

class Directions extends StatefulWidget {
  const Directions({super.key});

  @override
  State<Directions> createState() => _DirectionsState();
}

class _DirectionsState extends State<Directions> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _directionsController = TextEditingController();
  bool isFocused = false;

  final AddItem _addRecipe = AddItem();
  @override
  void dispose() {
    _directionsController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        isFocused = false;
      },
      child: Scaffold(
          backgroundColor: PresetColors.black,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 40,
                  top: 70,
                  bottom: 150,
                ),
                child: Container(
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: PresetColors.customBlack,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Form(
                      key: _formkey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return " Direction field can't be empty";
                          }
                          // } else if (RecipeValues.obj.ingredients == null) {
                          //   return " Ingredients field can't be empty";
                          // } else if (RecipeValues.obj.title == null) {
                          //   return " Title field can't be empty";
                          // }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: null,
                        controller: _directionsController,
                        onTap: () {
                          setState(() {
                            isFocused = true;
                          });
                        },
                        decoration: descriptionInputDec(
                          hintStyle: TextStyle(
                              color: isFocused
                                  ? PresetColors.nudegrey
                                  : PresetColors.fadedgrey),
                          hintText:
                              'Jot down ideas, Instructions ,or any other notes for this recipe.',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: screenWidth * 0.5,
                  child: TextButton(
                    onPressed: () {
                      if (_formkey.currentState != null &&
                          _formkey.currentState!.validate()) {
                        addRecipe();
                      }
                    },
                    style: saveButtonStyle(),
                    child: Text(
                      'Save Recipe',
                      style: saveButtonText(),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> addRecipe() async {
    await AddItem().openRecipeBox();

    if (RecipeValues.obj.ingredients == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: PresetColors.yellow,
          content: const Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.warning_amber_outlined,
                size: 25,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                  style: TextStyle(fontSize: 15, color: PresetColors.black),
                  "Ingredients are not added."),
            ],
          ),
        ),
      );
    } else if (RecipeValues.obj.title == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: PresetColors.yellow,
          content: const Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.warning_amber_outlined,
                size: 25,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                  style: TextStyle(fontSize: 15, color: PresetColors.black),
                  "Title is not added."),
            ],
          ),
        ),
      );
    } else if (RecipeValues.obj.ingredients != null &&
        RecipeValues.obj.title != null) {
      List<String>? ingredients = RecipeValues.obj.ingredients;
      String? title = RecipeValues.obj.title;
      String? description = RecipeValues.obj.description;
      String? prepTime = RecipeValues.obj.prepTime;
      String? directions = _directionsController.text;
      bool? isVeg = RecipeValues.obj.isVeg;
      // List<String>? categories = ['category'];
      List<String>? categories = RecipeValues.obj.categories;
      Uint8List? image = RecipeValues.obj.image;

      RecipeItems recipeItems = RecipeItems(
        title: title,
        ingredients: ingredients,
        directions: directions,
        prepTime: prepTime,
        description: description,
        isVeg: isVeg,
        categories: categories,
        image: image,
      );
      _addRecipe.addRecipe(recipeItems);
      print(recipeItems);
      print(recipeItems.description);
      print(recipeItems.title);
      print(recipeItems.isVeg);
      print(recipeItems.categories);
      print(recipeItems.image);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          // duration: Duration(milliseconds: 700),
          content: Text('Recipe added succesfully'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      _directionsController.clear();
      RecipeValues.obj.description = null;
      RecipeValues.obj.ingredients = null;

      RecipeValues.obj.prepTime = null;

      RecipeValues.obj.title = null;

      DefaultTabController.of(context).animateTo(
        0,
        duration:const Duration(milliseconds: 700),
      );
    }
  }
}

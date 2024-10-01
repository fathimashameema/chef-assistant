import 'dart:typed_data';

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/add_item.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/screens/admin/add_recipe/recipe_values.dart';
import 'package:chef_assistant/screens/admin/edit_recipe/edit_recipe_values.dart';
import 'package:flutter/material.dart';

class EditDirections extends StatefulWidget {
  final int index;
  final RecipeItems recipe;
  const EditDirections({super.key, required this.index, required this.recipe});

  @override
  State<EditDirections> createState() => _EditDirectionsState();
}

class _EditDirectionsState extends State<EditDirections> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _directionsController;
  bool isFocused = false;
  final AddItem _addRecipe = AddItem();
  late int recipeIndex;
  late RecipeItems recipe;

  @override
  void initState() {
    recipeIndex = widget.index;
    recipe = widget.recipe;
    _directionsController = TextEditingController(text: recipe.directions);
    super.initState();
  }

  @override
  void dispose() {
    _directionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: _addRecipe.recipeItemsNotifier,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            isFocused = false;
          },
          child: Scaffold(
              backgroundColor: PresetColors.black,
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40.0,
                          right: 40,
                          top: 70,
                          bottom: 150,
                        ),
                        child: Container(
                          height: constraints.maxWidth < 600
                              ? screenHeight * 0.4
                              : screenHeight * 0.7,
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
                          width: constraints.maxWidth < 600
                              ? screenWidth * 0.5
                              : screenWidth * 0.3,
                          child: TextButton(
                            onPressed: () {
                              if (_formkey.currentState != null &&
                                  _formkey.currentState!.validate()) {
                                editRecipe();
                              }
                            },
                            style: saveButtonStyle(),
                            child: Text(
                              'Edit Recipe',
                              style: saveButtonText(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            constraints.maxWidth < 600 ? 0 : screenWidth * 0.08,
                      ),
                    ],
                  );
                },
              )),
        );
      },
    );
  }

  Future<void> editRecipe() async {
    await AddItem().openRecipeBox();

    if (EditRecipeValues.obj.ingredients == null) {
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
    } else if (EditRecipeValues.obj.title == null) {
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
    } else if (EditRecipeValues.obj.ingredients != null &&
        EditRecipeValues.obj.title != null) {
      List<String>? ingredients = EditRecipeValues.obj.ingredients;
      String? title = EditRecipeValues.obj.title;
      String? description = EditRecipeValues.obj.descrption;
      String? prepTime = EditRecipeValues.obj.prepTime;
      String? directions = _directionsController.text;
      bool? isVeg = EditRecipeValues.obj.isVeg;
      // List<String>? categories = ['category'];
      List<String>? categories = EditRecipeValues.obj.categories;
      Uint8List? image = EditRecipeValues.obj.image;

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
      _addRecipe.editRecipe(index: recipeIndex, recipeItem: recipeItems);
      print(recipeItems);
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

      Navigator.of(context).pop();
    }
  }
}

import 'dart:typed_data';

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/add_item.dart';
import 'package:chef_assistant/db_functions/user_add_items.dart';
import 'package:chef_assistant/models/user_items.dart';
import 'package:chef_assistant/screens/user/user_add_recipe/user_recipe_values.dart';
import 'package:flutter/material.dart';

class UserDirections extends StatefulWidget {
  const UserDirections({super.key});

  @override
  State<UserDirections> createState() => _UserDirectionsState();
}

class _UserDirectionsState extends State<UserDirections> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _directionsController = TextEditingController();
  bool isFocused = false;

  // final AddItem _addRecipe = AddItem();
  @override
  void dispose() {
    _directionsController.dispose();
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
                      width: constraints.maxWidth < 600
                          ? screenWidth * 0.5
                          : screenWidth * 0.3,
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
                  SizedBox(
                    height: constraints.maxWidth < 600 ? 0 : screenWidth * 0.08,
                  ),
                ],
              );
            },
          )),
    );
  }

  Future<void> addRecipe() async {
    await AddItem().openRecipeBox();

    if (UserRecipeValues.obj.ingredients == null) {
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
    } else if (UserRecipeValues.obj.title == null) {
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
    } else if (UserRecipeValues.obj.ingredients != null &&
        UserRecipeValues.obj.title != null) {
      List<String>? ingredients = UserRecipeValues.obj.ingredients;
      String? title = UserRecipeValues.obj.title;
      String? description = UserRecipeValues.obj.description;
      String? prepTime = UserRecipeValues.obj.prepTime;
      String? directions = _directionsController.text;
      bool? isVeg = UserRecipeValues.obj.isVeg;
      List<String>? categories = UserRecipeValues.obj.categories;
      Uint8List? image = UserRecipeValues.obj.image;

      UserItems userRecipeItems = UserItems(
        title: title,
        ingredients: ingredients,
        directions: directions,
        prepTime: prepTime,
        description: description,
        isVeg: isVeg,
        categories: categories,
        image: image,
      );
      UserAddItems().addUserItem(userRecipeItems);
      print(userRecipeItems);
      print(userRecipeItems.description);
      print(userRecipeItems.title);
      print(userRecipeItems.isVeg);
      print(userRecipeItems.categories);
      print(userRecipeItems.image);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          // duration: Duration(milliseconds: 700),
          content: Text('Request sent to the Admin'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      _directionsController.clear();
      UserRecipeValues.obj.description = null;
      UserRecipeValues.obj.ingredients = null;

      UserRecipeValues.obj.prepTime = null;

      UserRecipeValues.obj.title = null;

      DefaultTabController.of(context).animateTo(
        0,
        duration: const Duration(milliseconds: 700),
      );
    }
  }
}

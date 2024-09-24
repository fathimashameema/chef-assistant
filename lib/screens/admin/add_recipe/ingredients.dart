

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/functions/add_categories.dart';
import 'package:chef_assistant/screens/admin/add_recipe/recipe_values.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({super.key});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  final _formkey = GlobalKey<FormState>();

  // List of controllers for each TextFormField
  List<TextEditingController> ingredientsControllers = [
    TextEditingController()
  ];

  List<String> categories = [];
  List<String> selectedCategories = [];

  Future<void> getCategories() async {
    categories = await AddCategories().getCategoryNames();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  void dispose() {
    // Dispose of all controllers when the widget is disposed
    for (var controller in ingredientsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Add a new TextFormField
  void addIngredientField() {
    setState(() {
      ingredientsControllers.add(TextEditingController());
    });
  }

  // Remove a TextFormField
  void removeIngredientField(int index) {
    setState(() {
      ingredientsControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: PresetColors.black,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: ListView(
            children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    // Display all TextFormFields for ingredients
                    ...List.generate(ingredientsControllers.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: ingredientsControllers[index],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Ingredients field can't be empty";
                                  }
                                  return null;
                                },
                                minLines: 1,
                                maxLines: null,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.multiline,
                                decoration: customInputDecoration(
                                  hintText: 'Add Ingredient',
                                  sufixIcon:
                                      index == ingredientsControllers.length - 1
                                          ? IconButton(
                                              icon:const Icon(
                                                Icons.add_box_outlined,
                                                color: PresetColors.white,
                                              ),
                                              onPressed: addIngredientField,
                                            )
                                          : null,
                                ),
                              ),
                            ),
                            // Show remove button if there's more than one field and it's not the last field
                            if (ingredientsControllers.length > 1 &&
                                index != ingredientsControllers.length - 1)
                              IconButton(
                                icon:const Icon(
                                  Icons.remove_circle,
                                  color: PresetColors.yellow,
                                ),
                                onPressed: () {
                                  removeIngredientField(index);
                                },
                              ),
                          ],
                        ),
                      );
                    }),
                    // Category selection section
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                      child: Text(
                        'Select Categories :',
                        style: homeHeadingStyle(),
                      ),
                    ),
                    if (categories.isNotEmpty) ...[
                      Row(
                        children: [
                          Expanded(
                            child: ChipsChoice<String>.multiple(
                              value: selectedCategories,
                              onChanged: (val) {
                                setState(() {
                                  selectedCategories = val;
                                });
                              },
                              choiceItems: C2Choice.listFrom<String, String>(
                                source: categories,
                                value: (i, v) => v,
                                label: (i, v) => v,
                              ),
                              wrapped: true,
                              choiceStyle: C2ChipStyle.filled(
                                color: PresetColors.themegreen,
                                selectedStyle:const C2ChipStyle(
                                  backgroundColor: PresetColors.yellow,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                     const Padding(
                        padding:  EdgeInsets.all(50.0),
                        child: Center(
                          child: Text(
                            'No categories found',
                            style: TextStyle(color: PresetColors.offwhite),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: SizedBox(
                  width: screenWidth * 0.5,
                  child: TextButton(
                    onPressed: () async {
                      if (_formkey.currentState != null &&
                          _formkey.currentState!.validate()) {
                        // Get all ingredient values
                        RecipeValues.obj.ingredients = ingredientsControllers
                            .map((controller) => controller.text)
                            .toList();
                        RecipeValues.obj.categories = selectedCategories;

                        print('Ingredients: ${RecipeValues.obj.ingredients}');
                        print('Categories: ${RecipeValues.obj.categories}');

                        // Clear all fields
                        for (var controller in ingredientsControllers) {
                          controller.clear();
                        }
                        ingredientsControllers = [TextEditingController()];

                        DefaultTabController.of(context).animateTo(
                          2,
                          duration:const Duration(milliseconds: 700),
                        );
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
          ),
        ),
      ),
    );
  }
}

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/add_categories.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/screens/admin/edit_recipe/edit_recipe_values.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class EditIngredients extends StatefulWidget {
  final RecipeItems recipe;
  const EditIngredients({super.key, required this.recipe});

  @override
  State<EditIngredients> createState() => _EditIngredientsState();
}

class _EditIngredientsState extends State<EditIngredients> {
  final _formkey = GlobalKey<FormState>();
  List<TextEditingController> ingredientControllers = [];
  List<String> categories = [];
  List<String> selectedCategories = [];
  late RecipeItems recipe;

  Future<void> getCategories() async {
    categories = await AddCategories().getCategoryNames();
    setState(() {});
  }

  @override
  void initState() {
    recipe = widget.recipe;
    // Initialize the list of controllers for each ingredient in the recipe
    if (recipe.ingredients != null) {
      for (var ingredient in recipe.ingredients!) {
        ingredientControllers.add(TextEditingController(text: ingredient));
      }
    } else {
      ingredientControllers.add(TextEditingController());
    }
    super.initState();
    getCategories();
  }

  @override
  void dispose() {
    for (var controller in ingredientControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addIngredientField() {
    setState(() {
      ingredientControllers.add(TextEditingController());
    });
  }

  void removeIngredientField(int index) {
    setState(() {
      ingredientControllers.removeAt(index);
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView(
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        // Display list of ingredient TextFormFields
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: ingredientControllers.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Ingredient field can't be empty";
                                        }
                                        return null;
                                      },
                                      controller: ingredientControllers[index],
                                      minLines: 1,
                                      maxLines: null,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      keyboardType: TextInputType.multiline,
                                      decoration: customInputDecoration(
                                        hintText: 'Add Ingredient',
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle,
                                        color: PresetColors.yellow),
                                    onPressed: () {
                                      if (ingredientControllers.length > 1) {
                                        removeIngredientField(index);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        // Add new ingredient button
                        TextButton(
                          onPressed: addIngredientField,
                          child: const Text(
                            'Add Ingredient',
                            style: TextStyle(color: PresetColors.yellow),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, bottom: 10),
                              child: Text(
                                'Select Categories :',
                                style: homeHeadingStyle(),
                              ),
                            ),
                          ],
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
                                  choiceItems:
                                      C2Choice.listFrom<String, String>(
                                    source: categories,
                                    value: (i, v) => v,
                                    label: (i, v) => v,
                                  ),
                                  wrapped: true,
                                  choiceStyle: C2ChipStyle.filled(
                                    color: PresetColors.themegreen,
                                    selectedStyle: const C2ChipStyle(
                                      backgroundColor: PresetColors.yellow,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          const Padding(
                            padding: EdgeInsets.all(50.0),
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
                  Center(
                    child: SizedBox(
                      width: constraints.maxWidth < 600
                          ? screenWidth * 0.5
                          : screenWidth * 0.3,
                      child: TextButton(
                        onPressed: () async {
                          if (_formkey.currentState != null &&
                              _formkey.currentState!.validate()) {
                            // Collect all ingredient values
                            List<String> ingredients = ingredientControllers
                                .map((controller) => controller.text)
                                .toList();
                            EditRecipeValues.obj.ingredients = ingredients;
                            EditRecipeValues.obj.categories =
                                selectedCategories;
                            print(
                                'Categories: ${EditRecipeValues.obj.categories}');
                            print(
                                'Ingredients: ${EditRecipeValues.obj.ingredients}');

                            DefaultTabController.of(context).animateTo(
                              2,
                              duration: const Duration(milliseconds: 700),
                            );
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
                    height: constraints.maxWidth < 600
                        ? screenHeight * 0.05
                        : screenHeight * 0.1,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

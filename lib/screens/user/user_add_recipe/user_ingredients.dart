import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/add_categories.dart';
import 'package:chef_assistant/screens/user/user_add_recipe/user_recipe_values.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class UserIngredients extends StatefulWidget {
  const UserIngredients({super.key});

  @override
  State<UserIngredients> createState() => _UserIngredientsState();
}

class _UserIngredientsState extends State<UserIngredients> {
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView(
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        // Display all TextFormFields for ingredients
                        ...List.generate(ingredientsControllers.length,
                            (index) {
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
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.multiline,
                                    decoration: customInputDecoration(
                                      hintText: 'Add Ingredient',
                                      sufixIcon: index ==
                                              ingredientsControllers.length - 1
                                          ? IconButton(
                                              icon: const Icon(
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
                                    icon: const Icon(
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
                            // Get all ingredient values

                            UserRecipeValues.obj.ingredients =
                                ingredientsControllers
                                    .map((controller) => controller.text)
                                    .toList();
                            UserRecipeValues.obj.categories =
                                selectedCategories;

                            print(
                                'Ingredients: ${UserRecipeValues.obj.ingredients}');
                            print(
                                'Categories: ${UserRecipeValues.obj.categories}');

                            // Clear all fields
                            for (var controller in ingredientsControllers) {
                              controller.clear();
                            }
                            ingredientsControllers = [TextEditingController()];

                            DefaultTabController.of(context).animateTo(
                              2,
                              duration: const Duration(milliseconds: 700),
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

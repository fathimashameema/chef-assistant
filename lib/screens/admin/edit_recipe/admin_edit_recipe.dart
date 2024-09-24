import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/screens/admin/edit_recipe/edit_directions.dart';
import 'package:chef_assistant/screens/admin/edit_recipe/edit_ingredients.dart';
import 'package:chef_assistant/screens/admin/edit_recipe/edit_overview.dart';
import 'package:flutter/material.dart';

class AdminEditRecipe extends StatefulWidget {
  final int index;
  final RecipeItems recipe;
  const AdminEditRecipe({super.key, required this.recipe, required this.index});

  @override
  State<AdminEditRecipe> createState() => _AdminEditRecipeState();
}

class _AdminEditRecipeState extends State<AdminEditRecipe> {
  late int recipeIndex;
  late RecipeItems recipe;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipeIndex = widget.index;
    recipe = widget.recipe;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: PresetColors.black,
          appBar: CustomAppBar(
            leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: customArrowBack()),
            title: Text(
              'Edit Recipe',
              style: customHeadingStyle(),
            ),
            backgroundColor: PresetColors.themegreen,
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                child: customTabBar(
                  tabs: [
                    const Tab(text: 'Overview'),
                    const Tab(text: 'Ingredients'),
                    const Tab(text: 'Description'),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(children: [
                EditOverview(
                  recipe: recipe,
                  index: recipeIndex,
                ),
                EditIngredients(
                  recipe: recipe,
                  // index: recipeIndex,
                ),
                EditDirections(
                  recipe: recipe,
                  index: recipeIndex,
                ),
              ]))
            ],
          )),
    );
  }
}

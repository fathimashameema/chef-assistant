import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/screens/user/user_add_recipe/user_directions.dart';
import 'package:chef_assistant/screens/user/user_add_recipe/user_ingredients.dart';
import 'package:chef_assistant/screens/user/user_add_recipe/user_overview.dart';
import 'package:flutter/material.dart';

class UserAddRecipe extends StatefulWidget {
  const UserAddRecipe({super.key});

  @override
  State<UserAddRecipe> createState() => _UserAddRecipeState();
}

class _UserAddRecipeState extends State<UserAddRecipe> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: PresetColors.black,
          appBar: CustomAppBar(
            centerTitle: true,
            backgroundColor: PresetColors.themegreen,
            title: Text(
              'Add Recipe',
              style: customHeadingStyle(fontSize: 25),
            ),
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
              const Expanded(
                  child: TabBarView(children: [
                UserOverview(),
                UserIngredients(),
                UserDirections(),
              ]))
            ],
          )),
    );
  }
}

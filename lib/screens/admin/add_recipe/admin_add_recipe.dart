import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/screens/admin/add_recipe/directions.dart';
import 'package:chef_assistant/screens/admin/add_recipe/ingredients.dart';
import 'package:chef_assistant/screens/admin/add_recipe/overview.dart';
import 'package:flutter/material.dart';

class AdminAddRecipe extends StatefulWidget {
  const AdminAddRecipe({super.key});

  @override
  State<AdminAddRecipe> createState() => _AdminAddRecipeState();
}

class _AdminAddRecipeState extends State<AdminAddRecipe> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: PresetColors.black,
          appBar: AppBar(
            title: Text(
              'Add Recipe',
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
                    Tab(text: 'Overview'),
                    Tab(text: 'Ingredients'),
                    Tab(text: 'Description'),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(children: [
                Overview(),
                Ingredients(),
                Directions(),
              ]))
            ],
          )),
    );
  }
}

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
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
          appBar: CustomAppBar(
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
                   const Tab(text: 'Overview'),
                   const Tab(text: 'Ingredients'),
                   const Tab(text: 'Description'),
                  ],
                ),
              ),
             const Expanded(
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

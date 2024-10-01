import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/screens/user/user_recipes/favourites.dart';
import 'package:chef_assistant/screens/user/user_recipes/user_recipe.dart';
import 'package:flutter/material.dart';

class UserRecipesTab extends StatefulWidget {
  const UserRecipesTab({super.key});

  @override
  State<UserRecipesTab> createState() => _UserRecipesTabState();
}

class _UserRecipesTabState extends State<UserRecipesTab> {
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: PresetColors.black,
          appBar: CustomAppBar(
            title: Text(
              'Collections',
              style: customHeadingStyle(),
            ),
          ),
          body: Column(
            children: [
              Container(
                child: customTabBar(
                  tabs: [
                    const Tab(text: 'Favourite Recipes'),
                    const Tab(text: 'My Recipes'),
                  ],
                ),
              ),
              const Expanded(
                  child: TabBarView(children: [
                Favourites(),
                UserRecipe(),
              ]))
            ],
          )),
    );
  }
}

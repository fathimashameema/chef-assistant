import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/screens/admin/recipe_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:chef_assistant/models/user_items.dart';
import 'package:chef_assistant/functions/user_add_items.dart';

class UserRecipe extends StatefulWidget {
  const UserRecipe({super.key});

  @override
  State<UserRecipe> createState() => _UserRecipeState();
}

class _UserRecipeState extends State<UserRecipe> {
  late UserAddItems _userAddItems;

  @override
  void initState() {
    _userAddItems = UserAddItems();
    super.initState();
    _userAddItems.openUserItemBox();
  }

  @override
  void dispose() {
    _userAddItems.closeUserItemBox();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: PresetColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _userAddItems.userItemNotifier,
                builder: (context, items, child) {
                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        'No items added',
                        style: TextStyle(
                            color: PresetColors.offwhite, fontSize: 16),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        UserItems recipe = items[index];
                        RecipeItems UserRecipe = RecipeItems(
                          isVeg: recipe.isVeg,
                          title: recipe.title,
                          description: recipe.description,
                          prepTime: recipe.prepTime,
                          ingredients: recipe.ingredients,
                          directions: recipe.directions,
                          image: recipe.image,
                          categories: recipe.categories,
                        );

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return RecipeDetailPage(recipe: UserRecipe);
                              }));
                            },
                            child: Card(
                              elevation: 8,
                              shadowColor: PresetColors.offwhite,
                              color: PresetColors.nudegrey,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                    ),
                                    child: Container(
                                      height: screenHeight * 0.13,
                                      width: screenWidth * 0.4,
                                      child: recipe.image != null
                                          ? Image.memory(
                                              recipe.image!,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/default_food.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      height: screenHeight * 0.09,
                                      width: screenWidth * 0.27,
                                      child: Text(
                                        recipe.title ?? 'Untitled',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

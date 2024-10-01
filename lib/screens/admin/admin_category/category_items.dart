import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/add_favourites.dart';
import 'package:chef_assistant/db_functions/add_item.dart';
import 'package:chef_assistant/db_functions/login_status.dart';
import 'package:chef_assistant/models/favourites_model.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/screens/admin/recipe_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItems extends StatefulWidget {
  final String category;
  const CategoryItems({super.key, required this.category});

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  late AddItem _addItem;

  @override
  void initState() {
    super.initState();
    _addItem = AddItem();
    _addItem.openRecipeBox();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: PresetColors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: customArrowBack()),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.category,
                    style: homeHeadingStyle(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<RecipeItems>>(
                valueListenable: _addItem.recipeItemsNotifier,
                builder: (context, box, child) {
                  final filteredRecipes = box
                      .where((recipe) =>
                          recipe.categories != null &&
                          recipe.categories!.contains(widget.category))
                      .toList();
                  if (filteredRecipes.isEmpty) {
                    return Center(
                      child: Text(
                        'No recipes available in ${widget.category} ',
                        style: const TextStyle(color: PresetColors.offwhite),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 70.0),
                      child: ListView.builder(
                        itemCount: filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = filteredRecipes[index];

                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return RecipeDetailPage(recipe: recipe);
                                }));
                              },
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Card(
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
                                          child: SizedBox(
                                            height: constraints.maxWidth < 600
                                                ? screenHeight * 0.13
                                                : screenHeight * 0.4,
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
                                          child: SizedBox(
                                            height: screenHeight * 0.09,
                                            width: screenWidth * 0.3,
                                            child: Text(
                                              recipe.title ?? 'Untitled',
                                              style: const TextStyle(
                                                color: PresetColors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        LoginStatus().isLogged
                                            ? IconButton(
                                                onPressed: () {
                                                  final favRecipe =
                                                      FavouritesModel(
                                                          favouriteItem:
                                                              recipe);
                                                  AddFavourites()
                                                      .isFavouriteExist(recipe,
                                                          favRecipe, index);
                                                },
                                                icon: FutureBuilder(
                                                  future: AddFavourites()
                                                      .containfavItem(recipe),
                                                  builder: (context, snapshot) {
                                                    bool isFavourite =
                                                        snapshot.data ?? false;
                                                    return Icon(
                                                      CupertinoIcons.heart_fill,
                                                      size: 15,
                                                      color: isFavourite
                                                          ? PresetColors.red
                                                          : PresetColors.white,
                                                      // color: isfocused
                                                      //     ? PresetColors.red
                                                      //     : PresetColors.white,
                                                    );
                                                  },
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
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

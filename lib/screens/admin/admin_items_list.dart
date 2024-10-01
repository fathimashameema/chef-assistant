import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/add_favourites.dart';
import 'package:chef_assistant/db_functions/add_item.dart';
import 'package:chef_assistant/db_functions/add_trending_now.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/screens/admin/edit_recipe/admin_edit_recipe.dart';
import 'package:chef_assistant/screens/admin/recipe_detail_page.dart';
import 'package:flutter/material.dart';

class AdminItemsList extends StatefulWidget {
  const AdminItemsList({super.key});

  @override
  State<AdminItemsList> createState() => _AdminItemsListState();
}

class _AdminItemsListState extends State<AdminItemsList> {
  final TextEditingController _searchController = TextEditingController();
  bool isFocused = false;
  late AddItem _addItem;
  List<RecipeItems> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _addItem = AddItem();
    _addItem.openRecipeBox();
    _addItem.getRecipes();
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterRecipes);
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecipes() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      filteredRecipes = _addItem.recipeItemsNotifier.value.where((recipe) {
        return recipe.title != null &&
            recipe.title!.toLowerCase().contains(query);
      }).toList();
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
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'List of Items',
                      style: homeHeadingStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: PresetColors.nudegrey,
                        hintText: 'Find your items ...',
                        hintStyle: TextStyle(
                          color: isFocused
                              ? PresetColors.fadedgrey
                              : PresetColors.offwhite,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: PresetColors.nudegrey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: PresetColors.nudegrey,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: PresetColors.white,
                          size: 20,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          isFocused = true;
                        });
                      },
                      onTapOutside: (event) {
                        setState(() {
                          isFocused = false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder<List<RecipeItems>>(
                      valueListenable: _addItem.recipeItemsNotifier,
                      builder: (context, box, child) {
                        List<RecipeItems> displayList =
                            _searchController.text.isEmpty
                                ? box
                                : filteredRecipes;

                        if (displayList.isEmpty) {
                          return const Center(
                            child: Text(
                              'No recipes available.',
                              style: TextStyle(color: PresetColors.offwhite),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 70.0),
                            child: ListView.builder(
                              itemCount: displayList.length,
                              itemBuilder: (context, index) {
                                final recipe = displayList[index];

                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) {
                                        return RecipeDetailPage(recipe: recipe);
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
                                            borderRadius:
                                                const BorderRadius.only(
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
                                              width: screenWidth * 0.27,
                                              child: Text(
                                                recipe.title ?? 'Untitled',
                                                style: const TextStyle(
                                                  color: PresetColors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                iconSize: 20,
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              AdminEditRecipe(
                                                                recipe: recipe,
                                                                index: index,
                                                              )));
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: PresetColors.white,
                                                  size: 20,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  deleteItem(index, recipe);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: PresetColors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
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
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> deleteItem(int index, RecipeItems recipe) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return customAlertDialogue(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: PresetColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                AddFavourites().deleteFavIfExist(recipe);
                AddTrendingNow().deleteItemIfExist(recipe);

                _addItem.deleteRecipe(index);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: PresetColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

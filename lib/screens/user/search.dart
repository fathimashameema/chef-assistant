import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/add_favourites.dart';
import 'package:chef_assistant/db_functions/add_item.dart';
import 'package:chef_assistant/db_functions/login_status.dart';
import 'package:chef_assistant/models/favourites_model.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/screens/admin/recipe_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  late AddItem _addItem;
  final Set<String> _selectedFilters = {};

  final List<String> filters = [
    'Non Veg',
    'Vegan',
    'Diet',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Smoothies',
    'Juices',
    '10 Minutes',
    '15 Minutes',
  ];

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
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
  }

  void _filterRecipes() {
    setState(() {}); // Trigger rebuild to apply the search filter
  }

  // Function to filter recipes based on search text and selected filters
  List<RecipeItems> _getFilteredRecipes(List<RecipeItems> recipes) {
    String query = _searchController.text.toLowerCase();

    return recipes.where((recipe) {
      // Check the search text filter
      bool matchesQuery = recipe.title?.toLowerCase().contains(query) ?? false;

      // Apply selected filters
      bool matchesFilters = _selectedFilters.every((filter) {
        if (filter == 'Non Veg') return recipe.isVeg == false;
        if (filter == 'Vegan') return recipe.isVeg == true;
        if (filter == 'Diet') return recipe.categories!.contains('Diet');
        if (filter == 'Breakfast') {
          return recipe.categories!.contains('Breakfast ');
        }
        if (filter == 'Lunch') return recipe.categories!.contains('Lunch');
        if (filter == 'Dinner') return recipe.categories!.contains('Dinner');
        if (filter == 'Smoothies') {
          return recipe.categories!.contains('Smoothies');
        }
        if (filter == 'Juices') return recipe.categories!.contains('Juices');
        if (filter == '10 Minutes') return recipe.prepTime == '10 minutes';
        if (filter == '15 Minutes') return recipe.prepTime == '15 minutes ';

        return true;
      });

      return matchesQuery && matchesFilters;
    }).toList();
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
        appBar: CustomAppBar(
          title: Text(
            'Search Recipe',
            style: customHeadingStyle(),
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: PresetColors.nudegrey,
                        hintText: 'Find your items ...',
                        hintStyle:
                            const TextStyle(color: PresetColors.offwhite),
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
                    ),
                  ),
                  // Choice Chips for filters
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Wrap(
                      spacing: 8.0,
                      children: filters.map((filter) {
                        return ChoiceChip(
                          label: Text(filter),
                          labelStyle:
                              const TextStyle(color: PresetColors.nudegrey),
                          selectedColor: PresetColors.yellow,
                          backgroundColor: PresetColors.fadedgrey,
                          selected: _selectedFilters.contains(filter),
                          onSelected: (selected) {
                            _toggleFilter(filter);
                            _filterRecipes();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder<List<RecipeItems>>(
                      valueListenable: _addItem.recipeItemsNotifier,
                      builder: (context, recipes, child) {
                        // Filter recipes based on search and filter selection
                        List<RecipeItems> filteredRecipes =
                            _getFilteredRecipes(recipes);

                        if (filteredRecipes.isEmpty) {
                          return const Center(
                            child: Text(
                              'No matching recipes found.',
                              style: TextStyle(color: PresetColors.offwhite),
                            ),
                          );
                        }

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
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => RecipeDetailPage(
                                          recipe: recipe,
                                        ),
                                      ),
                                    );
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
                                            // width: screenWidth * 0.3,
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
                                  ),
                                ),
                              );
                            },
                          ),
                        );
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
}

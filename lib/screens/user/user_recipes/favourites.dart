import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/db_functions/add_favourites.dart';
import 'package:chef_assistant/screens/admin/recipe_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  late AddFavourites _addFavourites;

  @override
  void initState() {
    _addFavourites = AddFavourites();
    super.initState();
    _addFavourites.openFavouritesBox();
  }

  @override
  void dispose() {
    _addFavourites.closeFavouritesBox();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: PresetColors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _addFavourites.favouritesNotifier,
                    builder: (context, favourites, child) {
                      if (favourites.isEmpty) {
                        return const Center(
                          child: Text(
                            'No items in favourites',
                            style: TextStyle(
                              color: PresetColors.offwhite,
                              fontSize: 16,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: favourites.length,
                          itemBuilder: (context, index) {
                            // Get the Favourites object
                            final recipe = favourites[index].favouriteItem;

                            // Extract RecipeItems from the Favourites object
                            // final  recipe = fav.favouriteItems;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
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
                                      IconButton(
                                        icon: const Icon(
                                          CupertinoIcons.heart_fill,
                                          color: PresetColors.red,
                                          size: 20,
                                        ),
                                        onPressed: () async {
                                          await _addFavourites
                                              .deleteFavourite(index);
                                        },
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
            );
          },
        ),
      ),
    );
  }
}

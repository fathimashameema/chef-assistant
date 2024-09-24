import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/functions/add_item.dart';
import 'package:chef_assistant/functions/add_trending_now.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/models/trending_now.dart';
import 'package:chef_assistant/screens/admin/trending_now/tending_now.dart';
import 'package:flutter/material.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({
    super.key,
  });

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  // ValueNotifier<List<ItemsList>> itemslistNotifier = ValueNotifier([]);
  late Future<List<RecipeItems>> _recipeBox;

  @override
  void initState() {
    super.initState();
    _recipeBox = AddItem().getRecipes();
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
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: customArrowBack()),
            ),
            Expanded(
              child: FutureBuilder<List<RecipeItems>>(
                future: _recipeBox,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: PresetColors.offwhite),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final box = snapshot.data!;

                    if (box.isEmpty) {
                      return const Center(
                        child: Text(
                          'No recipes available.',
                          style: TextStyle(color: PresetColors.offwhite),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          final recipe = box[index];

                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () async {
                                addTrendingNow(recipe);
                              },
                              child: Card(
                                elevation: 8,
                                shadowColor: PresetColors.offwhite,
                                color: PresetColors.nudegrey,
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                      ),
                                      child: SizedBox(
                                        height: screenHeight * 0.14,
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
                                        height: screenHeight * 0.1,
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
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return const Center(
                      child: Text(
                        'No data available.',
                        style: TextStyle(color: PresetColors.offwhite),
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

  Future<void> addTrendingNow(RecipeItems recipe) async {
    if (await AddTrendingNow().isItemExist(recipe)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item already exist'),
        ),
      );
      Navigator.of(context).pop();
    } else {
      final trendingRecipe = TrendingNow(trendingItems: recipe);
      await AddTrendingNow().addTrendings(
        trendingItems: trendingRecipe,
      );
      AddTrendingNow().getTrendings();
      trendingNowNotifier.notifyListeners();
     
      Navigator.of(context).pop();
      print('ok');
    }
  }
}

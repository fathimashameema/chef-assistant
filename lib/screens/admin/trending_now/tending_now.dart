import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/add_trending_now.dart';
import 'package:chef_assistant/models/trending_now.dart';
import 'package:chef_assistant/screens/admin/recipe_detail_page.dart';
import 'package:chef_assistant/screens/admin/trending_now/items_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TendingNow extends StatefulWidget {
  const TendingNow({super.key});

  @override
  State<TendingNow> createState() => _TendingNowState();
}

// late Future<List<TrendingNow>> alltrendingItems;
ValueNotifier<List<TrendingNow>> trendingNowNotifier = ValueNotifier([]);

// Future<List<TrendingNow>> trendingNowItems = AddTrendingNow().getTrendings();

class _TendingNowState extends State<TendingNow> {
  @override
  void initState() {
    AddTrendingNow().getTrendings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PresetColors.black,
      body: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      top: 20,
                      bottom: 30,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: customArrowBack(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 30,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Trending Now...',
                          style: homeHeadingStyle(),
                        ),
                        Text('Discover most accepted items',
                            style: GoogleFonts.ledger(
                              fontSize: 10,
                              color: PresetColors.white,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: trendingNowNotifier,
                      builder: (context, value, child) {
                        if (value.isEmpty) {
                          return const Center(
                            child: Text(
                              'No items found',
                              style: TextStyle(color: PresetColors.offwhite),
                            ),
                          );
                        } else {
                          // final trendingItems = value;
                          return GridView.builder(
                              itemCount: value.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    constraints.maxWidth < 600 ? 2 : 4,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio:
                                    constraints.maxWidth < 600 ? 0.9 : 0.9,
                              ),
                              padding: const EdgeInsets.all(30),
                              itemBuilder: (context, index) {
                                // final allTrendings = trendingItems[index];
                                final recipe = value[index].trendingItems;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return RecipeDetailPage(recipe: recipe);
                                    }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: PresetColors.nudegrey),
                                    child: GridTile(
                                      child: Column(
                                        children: [
                                          // ignore: sized_box_for_whitespace
                                          Container(
                                            height: constraints.maxWidth < 600
                                                ? screenHeight * 0.13
                                                : screenHeight * 0.4,
                                            width: screenWidth,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    recipe.title ?? 'No title',
                                                    style: profileTextStyle(),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    deleteItem(index);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                    color: PresetColors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: screenHeight * 0.55,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.43),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const ItemsList(
                                // itemsList: alltrendingItems,
                                ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add_circle_outline_rounded,
                        color: PresetColors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  )
                  // Container(
                  //   child: customTabBar(
                  //     tabs: [
                  //       Tab(text: 'All Recipes'),
                  //       Tab(text: 'Non-veg'),
                  //       Tab(text: 'Vegan'),
                  //     ],
                  //   ),
                  // ),
                  // Expanded(
                  //     child: TabBarView(children: [
                  //   AllRecipes(),
                  //   Vegetarian(),
                  //   Vegan(),
                  // ])),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> deleteItem(int index) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return customAlertDialogue(
            title: const Text('Delete Item'),
            content: const Text(
                'Are you sure you want to delete this item from Trending now?'),
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
                  AddTrendingNow().deleteTrendingItem(index: index);
                  AddTrendingNow().getTrendings();
                  trendingNowNotifier.notifyListeners();
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
        });
  }
}

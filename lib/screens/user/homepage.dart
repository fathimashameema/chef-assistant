import 'package:carousel_slider/carousel_slider.dart';
import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/customs/home_appbar.dart';
import 'package:chef_assistant/db_functions/add_favourites.dart';
import 'package:chef_assistant/db_functions/add_item.dart';
import 'package:chef_assistant/db_functions/add_trending_now.dart';
import 'package:chef_assistant/db_functions/login.dart';
import 'package:chef_assistant/db_functions/login_status.dart';
import 'package:chef_assistant/models/favourites_model.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/models/trending_now.dart';
import 'package:chef_assistant/screens/admin/diet_plan/diet_plan.dart';
import 'package:chef_assistant/screens/admin/kitchen_hacks.dart';
import 'package:chef_assistant/screens/admin/recipe_detail_page.dart';
import 'package:chef_assistant/screens/user/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

ValueNotifier<List<TrendingNow>> filteredTrendings = ValueNotifier([]);
List<TrendingNow> trendingItems = [];
Future<void> getItems() async {
  trendingItems = await AddTrendingNow().getTrendings();
  filteredTrendings.value = trendingItems;
}

class _HomepageState extends State<Homepage> {
  late Future<List<RecipeItems>> filteredRecipes;

  String filterItems = 'all recipe';

  bool isfocused = false;
  String? firstLetter;
  Map<int, bool> isHeartPressed = {};
  Map<int, bool> carousalheart = {};
  bool vegetarian = false;
  bool vegan = false;
  bool allrecipes = true;
  // final List<String> filterItems = ['All Recipes', ' Non-veg', 'Vegan'];
  final TextEditingController _searchController = TextEditingController();

  void updateFirstLetter() async {
    String userName = await Login().getUsername();
    print('username is $userName');
    setState(() {
      firstLetter = userName[0].toUpperCase();
    });
  }

  @override
  void initState() {
    Login().getUsername();
    if (LoginStatus().isLogged) {
      updateFirstLetter();
    }
    filteredRecipes = AddItem().getRecipes();
    getItems();
    // AddCategories().getCategoryNames();
    AddTrendingNow().getTrendings();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    AddItem().closeRecipeBox();
    AddTrendingNow().closeBox();
    super.dispose();
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
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 92),
            child: HomeAppbar(
                screenWidth: screenWidth * 0.5,
                screenHeight: screenHeight * 0.5,
                firstLetter: firstLetter)),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  color: PresetColors.themegreen,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _searchController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: PresetColors.nudegrey,
                          hintText: 'Find your items ...',
                          hintStyle: TextStyle(
                            color: isfocused
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
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: PresetColors.nudegrey,
                              )),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: PresetColors.white,
                            size: 20,
                          )),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return const Search();
                        }));
                        setState(() {
                          isfocused = true;
                        });
                      },
                      onTapOutside: (event) {
                        setState(() {
                          isfocused = false;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        filteredRecipes = AddItem().getRecipes();
                        filteredTrendings.value =
                            await AddTrendingNow().getTrendings();
                        setState(() {
                          filterItems = 'all recipe';

                          print('all recipe');
                        });
                      },
                      style: chipButtonstyle(
                        backgroundcolor: filterItems == 'all recipe'
                            ? PresetColors.fadedgrey
                            : PresetColors.nudegrey,
                      ),
                      child: Text(
                        'All recipe',
                        style: profileTextStyle(),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        filteredTrendings.value =
                            await AddTrendingNow().nonVegTrendings();
                        filteredRecipes = AddItem().nonVegRecipe();

                        setState(() {
                          filterItems = 'non veg';
                          print('all recipe');
                        });
                      },
                      style: chipButtonstyle(
                        backgroundcolor: filterItems == 'non veg'
                            ? PresetColors.fadedgrey
                            : PresetColors.nudegrey,
                      ),
                      child: Text(
                        'Non-Veg',
                        style: profileTextStyle(),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        filteredTrendings.value =
                            await AddTrendingNow().veganTrendings();
                        filteredRecipes = AddItem().veganRecipe();

                        setState(() {
                          filterItems = 'vegan';
                          print('all recipe');
                        });
                      },
                      style: chipButtonstyle(
                        backgroundcolor: filterItems == 'vegan'
                            ? PresetColors.fadedgrey
                            : PresetColors.nudegrey,
                      ),
                      child: Text(
                        'Vegan',
                        style: profileTextStyle(),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      top: 10,
                    ),
                    child: Text(
                      'Trending Now...',
                      style: GoogleFonts.ledger(
                          fontSize: 20, color: PresetColors.yellow),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                  ),
                  child: Text('Discover most accepted items',
                      style: GoogleFonts.ledger(
                        fontSize: 10,
                        color: PresetColors.white,
                      )),
                ),
                ValueListenableBuilder(
                  valueListenable: filteredTrendings,
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(90.0),
                        child: Center(
                          child: Text(
                            'No $filterItems items found',
                            style:
                                const TextStyle(color: PresetColors.offwhite),
                          ),
                        ),
                      );
                    } else {
                      return CarouselSlider(
                        items: List.generate(filteredTrendings.value.length,
                            (index) {
                          return Builder(builder: (context) {
                            final recipe =
                                filteredTrendings.value[index].trendingItems;
                            final favRecipe =
                                FavouritesModel(favouriteItem: recipe);

                            return Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return RecipeDetailPage(recipe: recipe);
                                  }));
                                },
                                child: Card(
                                  color: PresetColors.nudegrey,
                                  margin: const EdgeInsets.only(left: 25),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: constraints.maxWidth < 600
                                            ? screenHeight * 0.23
                                            : screenHeight * 0.5,
                                        width: screenWidth,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            child: SizedBox(
                                              width: screenWidth * 0.4,
                                              child: Text(
                                                recipe.title ?? 'No title',
                                                style: GoogleFonts.ledger(
                                                  fontSize: 20,
                                                  color: PresetColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          LoginStatus().isLogged
                                              ? IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      carousalheart[index] =
                                                          !(carousalheart[
                                                                  index] ??
                                                              false);
                                                    });
                                                    AddFavourites()
                                                        .isFavouriteExist(
                                                            recipe,
                                                            favRecipe,
                                                            index);
                                                  },
                                                  icon: FutureBuilder(
                                                    future: AddFavourites()
                                                        .containfavItem(recipe),
                                                    builder:
                                                        (context, snapshot) {
                                                      bool isFavourite =
                                                          snapshot.data ??
                                                              false;
                                                      return Icon(
                                                        CupertinoIcons
                                                            .heart_fill,
                                                        size: 15,
                                                        color: isFavourite
                                                            ? PresetColors.red
                                                            : PresetColors
                                                                .white,
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
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        }),
                        options: CarouselOptions(
                          // height: 300,
                          height: constraints.maxWidth < 600
                              ? screenHeight * 0.38
                              : screenHeight * 0.7,
                          autoPlay: true,
                        ),
                      );
                    }
                  },
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      top: 10,
                    ),
                    child: Text(
                      'Recently added',
                      style: GoogleFonts.ledger(
                          fontSize: 20, color: PresetColors.yellow),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    bottom: 10,
                  ),
                  child: Text('Browse newly added items',
                      style: GoogleFonts.ledger(
                        fontSize: 10,
                        color: PresetColors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    height: screenHeight * 0.38,
                    child: FutureBuilder(
                        future: filteredRecipes,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(
                                    color: PresetColors.offwhite),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            final box =
                                snapshot.data!.reversed.take(5).toList();
                            if (box.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No recipes available.',
                                  style:
                                      TextStyle(color: PresetColors.offwhite),
                                ),
                              );
                            } else {
                              print('box length ${box.length}');
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: box.length,
                                itemBuilder: (context, index) {
                                  final recipe = box[index];
                                  final favRecipe =
                                      FavouritesModel(favouriteItem: recipe);

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (ctx) {
                                          return RecipeDetailPage(
                                              recipe: recipe);
                                        }));
                                      },
                                      child: Container(
                                          width: constraints.maxWidth < 600
                                              ? screenWidth * 0.38
                                              : screenWidth * 0.2,
                                          decoration: BoxDecoration(
                                            color: PresetColors.nudegrey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadiusDirectional
                                                        .vertical(
                                                        top:
                                                            Radius.circular(8)),
                                                child: recipe.image != null
                                                    ? Image.memory(
                                                        recipe.image!,
                                                        fit: BoxFit.cover,
                                                        height:
                                                            screenHeight * 0.21,
                                                        width: double.infinity,
                                                      )
                                                    : Image.asset(
                                                        'assets/images/default_food.jpg',
                                                        fit: BoxFit.cover,
                                                        height:
                                                            screenHeight * 0.21,
                                                        width: double.infinity,
                                                      ),
                                              ),
                                              Positioned(
                                                top: screenHeight * 0.225,
                                                left: constraints.maxWidth < 600
                                                    ? screenWidth * 0.03
                                                    : screenWidth * 0.015,
                                                child: SizedBox(
                                                  width: screenWidth * 0.2,
                                                  child: Text(
                                                    recipe.title ?? 'untitled',
                                                    style: GoogleFonts.ledger(
                                                      fontSize: 15,
                                                      color: PresetColors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 5,
                                                left: constraints.maxWidth < 600
                                                    ? 10
                                                    : 20,
                                                // right: 0,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      recipe.categories != null
                                                          ? recipe.categories!
                                                              .join(',')
                                                          : 'No categories',
                                                      style: const TextStyle(
                                                        color:
                                                            PresetColors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    LoginStatus().isLogged
                                                        ? IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                isHeartPressed[
                                                                        index] =
                                                                    !(isHeartPressed[
                                                                            index] ??
                                                                        false);
                                                              });
                                                              AddFavourites()
                                                                  .isFavouriteExist(
                                                                      recipe,
                                                                      favRecipe,
                                                                      index);
                                                            },
                                                            icon: FutureBuilder(
                                                              future: AddFavourites()
                                                                  .containfavItem(
                                                                      recipe),
                                                              builder: (context,
                                                                  snapshot) {
                                                                bool
                                                                    isFavourite =
                                                                    snapshot.data ??
                                                                        false;
                                                                return Icon(
                                                                  CupertinoIcons
                                                                      .heart_fill,
                                                                  size: 15,
                                                                  color: isFavourite
                                                                      ? PresetColors
                                                                          .red
                                                                      : PresetColors
                                                                          .white,
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
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
                        }),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      top: 10,
                    ),
                    child: Text(
                      "Assistant Chef's Diet plan",
                      style: GoogleFonts.ledger(
                          fontSize: 20, color: PresetColors.yellow),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    bottom: 10,
                  ),
                  child: Text(
                      "Maintain your Health with Assistant Chef's master diet plan",
                      style: GoogleFonts.ledger(
                        fontSize: 10,
                        color: PresetColors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const DietPlan();
                      }));
                    },
                    child: Container(
                      height: constraints.maxWidth < 600 ? 250 : 450,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: PresetColors.nudegrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadiusDirectional.vertical(
                                    top: Radius.circular(8)),
                            child: Image.asset(
                              'assets/images/pexels-photo-1640777.jpeg',
                              width: double.infinity,
                              height: constraints.maxWidth < 600 ? 170 : 370,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Try our Healthy Diet plan to meet your goals....',
                              style: GoogleFonts.ledger(
                                color: PresetColors.white,
                                fontSize: 17,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      top: 10,
                    ),
                    child: Text(
                      "Kitchen Hacks",
                      style: GoogleFonts.ledger(
                          fontSize: 20, color: PresetColors.yellow),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    bottom: 10,
                  ),
                  child: Text("Hacks to make your kitchen Heaven ",
                      style: GoogleFonts.ledger(
                        fontSize: 10,
                        color: PresetColors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const KitchenHacks();
                      }));
                    },
                    child: Container(
                      height: constraints.maxWidth < 600 ? 100 : 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: PresetColors.nudegrey,
                        borderRadius: BorderRadiusDirectional.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadiusDirectional.horizontal(
                                start: Radius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/images/pexels-photo-4259140.webp',
                                width: constraints.maxWidth < 600 ? 200 : 250,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth < 600 ? 20 : 558,
                          ),
                          SizedBox(
                            width: constraints.maxWidth < 600 ? 150 : 260,
                            child: Text(
                              'Top Kitchen hacks you will wish you knew sooner',
                              style: GoogleFonts.ledger(
                                  fontSize: 15, color: PresetColors.white),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth < 600 ? 35 : 200,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

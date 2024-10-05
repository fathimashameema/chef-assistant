
import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/db_functions/add_categories.dart';
import 'package:chef_assistant/db_functions/add_favourites.dart';
import 'package:chef_assistant/db_functions/add_item.dart';
import 'package:chef_assistant/db_functions/add_shopping_item.dart';
import 'package:chef_assistant/db_functions/add_trending_now.dart';
import 'package:chef_assistant/db_functions/signup.dart';
import 'package:chef_assistant/db_functions/user_add_items.dart';
import 'package:chef_assistant/models/categories_model.dart';
import 'package:chef_assistant/models/favourites_model.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/models/shopping_cart_model.dart';
import 'package:chef_assistant/models/trending_now.dart';
import 'package:chef_assistant/models/user_items.dart';
import 'package:chef_assistant/models/user_values.dart';
import 'package:chef_assistant/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(UserValuesAdapter().typeId)) {
    Hive.registerAdapter(UserValuesAdapter());
    await Signup().openBox();
  }

  if (!Hive.isAdapterRegistered(RecipeItemsAdapter().typeId)) {
    Hive.registerAdapter(RecipeItemsAdapter());
    await AddItem().openRecipeBox();
  }

  if (!Hive.isAdapterRegistered(TrendingNowAdapter().typeId)) {
    Hive.registerAdapter(TrendingNowAdapter());
    await AddTrendingNow().openBox();
  }

  if (!Hive.isAdapterRegistered(CategoriesModelAdapter().typeId)) {
    Hive.registerAdapter(CategoriesModelAdapter());
    await AddCategories().openCategoriesBox();
  }

  if (!Hive.isAdapterRegistered(UserItemsAdapter().typeId)) {
    Hive.registerAdapter(UserItemsAdapter());
    await UserAddItems().openUserItemBox();
  }

  if (!Hive.isAdapterRegistered(FavouritesModelAdapter().typeId)) {
    Hive.registerAdapter(FavouritesModelAdapter());
    await AddFavourites().openFavouritesBox();
  }

  if (!Hive.isAdapterRegistered(ShoppingCartModelAdapter().typeId)) {
    Hive.registerAdapter(ShoppingCartModelAdapter());
    await AddShoppingItem().openShoppingCartBox();
  }

  runApp(const ChefAssistant());
}

class ChefAssistant extends StatelessWidget {
  const ChefAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Splashscreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'LeagueSpartan',
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: PresetColors.white),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PresetColors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: PresetColors.fadedgrey,
              ),
            ),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: PresetColors.white,
          )),
    );
  }
}

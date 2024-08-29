import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/functions/add_item.dart';
import 'package:chef_assistant/functions/signup.dart';
import 'package:chef_assistant/models/recipe_items.dart';
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
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(RecipeItemsAdapter().typeId)) {
    Hive.registerAdapter(RecipeItemsAdapter());
    await AddItem().openRecipeBox();
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
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: PresetColors.white),
          ),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PresetColors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: PresetColors.fadedgrey,
              ),
            ),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: PresetColors.white,
          )),
    );
  }
}

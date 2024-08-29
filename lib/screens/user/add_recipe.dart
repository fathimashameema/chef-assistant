import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: PresetColors.themegreen,
          title: Text(
            'Add Recipe',
            style: customHeadingStyle(fontSize: 25),
          ),
        ),
        body: Center(
          child: Text('add recipe'),
        ),
      ),
    );
  }
}

import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:flutter/material.dart';

class Introscreen1 extends StatelessWidget {
  const Introscreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return introScreens(
            screenHeight,
            screenWidth,
            constraints,
            'assets/images/intoduction screen (2).png',
            'Find your Dish',
            'Explore the varieties of recipes and find your comfort food. '
                'Find your favourite Dish with Chef Assistant.',
          );
        },
      ),
    );
  }
}

import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:flutter/material.dart';

class Introscreen2 extends StatelessWidget {
  const Introscreen2({super.key});

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
              'assets/images/intoduction screen (1).png',
              'Refresh your soul',
              '  Find your favourite drinks by wandering through the virtual pages . ',
            );
           
          },
        ));
  }
}

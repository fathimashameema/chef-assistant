import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Introscreen1 extends StatelessWidget {
  const Introscreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.15,
            left: screenWidth * 0.07,
            child: Container(
              height: screenHeight * 0.4,
              width: screenWidth * 0.86,
              child: Image.asset(
                'assets/images/intoduction screen (2).png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.31,
            left: screenWidth * 0.25,
            child: Text(
              'Find your Dish',
              style: GoogleFonts.lemon(
                fontSize: screenWidth * 0.065,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 210, 153, 20),
              ),
            ),
          ),
          // Description Text
          Positioned(
            bottom: screenHeight * 0.148,
            left: screenWidth * 0.04,
            child: Container(
              height: screenHeight * 0.125,
              width: screenWidth * 0.89,
              child: Text(
                'Explore the varieties of recipes and find your comfort food. '
                'Find your favourite Dish with Chef Assistant.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

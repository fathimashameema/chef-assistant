import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Introscreen2 extends StatelessWidget {
  const Introscreen2({super.key});

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
                // color: Colors.yellow,
                child: Image(
                    image:
                        AssetImage('assets/images/intoduction screen (1).png')),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.31,
              left: screenWidth * 0.2,
              child: Text(
                'Refresh your soul',
                style: GoogleFonts.lemon(
                  fontSize: screenWidth * 0.065,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 210, 153, 20),
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.148,
              left: screenWidth * 0.04,
              child: Container(
                height: screenHeight * 0.125,
                width: screenWidth * 0.89,
                child: Text(
                  textAlign: TextAlign.center,
                  '  Find your favourite drinks by wandering through the virtual pages . ',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    // wordSpacing: 2,
                    // letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

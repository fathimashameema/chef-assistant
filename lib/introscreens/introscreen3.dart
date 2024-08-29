import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/screens/user/user_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Introscreen3 extends StatelessWidget {
  const Introscreen3({super.key});

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
                    image: AssetImage('assets/images/intoduction screen.png')),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.31,
              left: screenWidth * 0.35,
              child: Text(
                'Diet plan',
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
                  ' Maintain your health by following our proper diet plan',
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
            Positioned(
                bottom: screenHeight * 0.06,
                left: screenWidth * 0.13,
                child: Container(
                  width: screenWidth * 0.75,
                  child: TextButton(
                      style: customButtonStyle(),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (cnxt) {
                          return Userlogin();
                        }));
                      },
                      child: Text(
                        'Get started',
                        style: customButtonText(),
                      )),
                ))
          ],
        ));
  }
}

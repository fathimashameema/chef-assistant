import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/login_status_functions.dart';
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
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  top: screenHeight * 0.15,
                  left: screenWidth * 0.07,
                  child: SizedBox(
                    height: screenHeight * 0.4,
                    width: screenWidth * 0.86,
                    // color: Colors.yellow,
                    child: const Image(
                        image:
                            AssetImage('assets/images/intoduction screen.png')),
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.31,
                  left: constraints.maxWidth < 600
                      ? screenWidth * 0.35
                      : screenWidth * 0.42,
                  child: Text(
                    'Diet plan',
                    style: GoogleFonts.lemon(
                      fontSize: constraints.maxWidth < 600
                          ? screenWidth * 0.065
                          : screenWidth * 0.03,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 210, 153, 20),
                    ),
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.148,
                  left: screenWidth * 0.04,
                  child: SizedBox(
                    height: screenHeight * 0.125,
                    width: screenWidth * 0.89,
                    child: Text(
                      textAlign: TextAlign.center,
                      ' Maintain your health by following our proper diet plan',
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 600
                            ? screenWidth * 0.05
                            : screenWidth * 0.02,
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
                    child: SizedBox(
                      width: screenWidth * 0.75,
                      child: TextButton(
                          style: customButtonStyle(),
                          onPressed: () {
                            setHasSeenIntro(true);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (cnxt) {
                              return const Userlogin();
                            }));
                          },
                          child: Text(
                            'Get started',
                            style: customButtonText(),
                          )),
                    ))
              ],
            );
          },
        ));
  }
}

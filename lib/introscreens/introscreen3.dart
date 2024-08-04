import 'package:chef_assistant/introscreens/userlogin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Introscreen3 extends StatelessWidget {
  const Introscreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
                top: 50,
                right: 30,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                )),
            Positioned(
              top: 120,
              left: 25,
              child: Container(
                height: 350,
                width: 350,
                // color: Colors.yellow,
                child: Image(
                    image: AssetImage('assets/images/intoduction screen.png')),
              ),
            ),
            Positioned(
              bottom: 250,
              left: 135,
              child: Text(
                'Diet plan',
                style: GoogleFonts.lemon(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 210, 153, 20),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              left: 15,
              child: Container(
                height: 100,
                width: 350,
                child: Text(
                  textAlign: TextAlign.center,
                  ' Maintain your health by following our proper diet plan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    // wordSpacing: 2,
                    // letterSpacing: 2,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 50,
                left: 50,
                child: Container(
                  width: 300,
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromARGB(255, 190, 190, 164),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (cnxt) {
                          return Userlogin();
                        }));
                      },
                      child: Text(
                        'Get started',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )),
                ))
          ],
        ));
  }
}

import 'package:chef_assistant/introscreens/introscreen3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Introscreen2 extends StatelessWidget {
  const Introscreen2({super.key});

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
                    image:
                        AssetImage('assets/images/intoduction screen (1).png')),
              ),
            ),
            Positioned(
              bottom: 250,
              left: 85,
              child: Text(
                'Refresh your soul',
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
                  '  Find your favourite drinks by wandering through the virtual pages . ',
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
              bottom: 60,
              right: 40,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (cnxt) {
                      return Introscreen3();
                    }));
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 20,
                  )),
            )
          ],
        ));
  }
}

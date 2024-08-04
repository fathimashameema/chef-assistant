import 'package:chef_assistant/introductionscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool animate = false;
  @override
  void initState() {
    // TODO: implement initState
    animatefunction();
    // gotonext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 55, 53, 53),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: 360,
            right: animate ? 137 : -100,
            child: Text(
              'Chef',
              style: GoogleFonts.leckerliOne(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.w700),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: 430,
            left: animate ? 140 : -100,
            child: Text(
              'assistant',
              style: GoogleFonts.lekton(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            top: animate ? 300 : -100,
            left: 170,
            child: Container(
              height: 100,
              width: 100,
              child: Image(
                image: AssetImage(
                    "assets/images/Untitled_design-removebg-preview.png"),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            top: animate ? 355 : -100,
            left: 170,
            child: Container(
              height: 55,
              width: 70,
              child: Image(
                image: AssetImage(
                    "assets/images/ea627c46f7751aaf7d8279e09ade3be9-removebg-preview.png"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> animatefunction() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(Duration(milliseconds: 1500));

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return Introductionscreen();
    }));
  }
}

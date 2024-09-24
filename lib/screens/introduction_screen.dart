import 'package:chef_assistant/screens/home_screen.dart';
import 'package:chef_assistant/introscreens/introscreen1.dart';
import 'package:chef_assistant/introscreens/introscreen2.dart';
import 'package:chef_assistant/introscreens/introscreen3.dart';
import 'package:flutter/material.dart';

class Introductionscreen extends StatefulWidget {
  const Introductionscreen({super.key});

  @override
  State<Introductionscreen> createState() => _IntroductionscreenState();
}

class _IntroductionscreenState extends State<Introductionscreen> {
  final PageController _controller = PageController();
  int _currentpage = 0;

  @override
  void initState() {
    // Login().hasSeenIntro();

    _controller.addListener(() {
      setState(() {
        _currentpage = _controller.page!.round();
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [
              Introscreen1(),
              Introscreen2(),
              Introscreen3(),
            ],
          ),
          Positioned(
              top: 50,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  if (_currentpage != 2) {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                        (Route<dynamic> route) => false);
                  }
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              )),
          if (_currentpage != 2)
            Positioned(
              bottom: 60,
              right: 40,
              child: IconButton(
                  onPressed: () {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 20,
                  )),
            )
        ],
      ),
    );
  }
}

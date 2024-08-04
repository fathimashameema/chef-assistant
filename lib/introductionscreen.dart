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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Introscreen1(),
              Introscreen2(),
              Introscreen3(),
            ],
          )
        ],
      ),
    );
  }
}

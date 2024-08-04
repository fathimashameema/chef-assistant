import 'package:chef_assistant/splashscreen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(ChefAssistant());
}

class ChefAssistant extends StatelessWidget {
  const ChefAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 74, 73, 73),
        useMaterial3: true,
        fontFamily: 'LeagueSpartan',
      ),
    );
  }
}

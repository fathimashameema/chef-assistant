import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:flutter/material.dart';

class Directions extends StatefulWidget {
  const Directions({super.key});

  @override
  State<Directions> createState() => _DirectionsState();
}

class _DirectionsState extends State<Directions> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        isFocused = false;
      },
      child: Scaffold(
          backgroundColor: PresetColors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  // left: 10.0,
                  top: 70,
                ),
                child: Container(
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: PresetColors.customBlack,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: TextFormField(
                      onTap: () {
                        setState(() {
                          isFocused = true;
                        });
                      },
                      decoration: descriptionInputDec(
                        hintStyle: TextStyle(
                            color: isFocused
                                ? PresetColors.nudegrey
                                : PresetColors.fadedgrey),
                        hintText:
                            'Jot down ideas, Instructions ,or any other notes for this recipe.',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 85.0),
                child: Center(
                  child: Container(
                    width: screenWidth * 0.5,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Save Recipe',
                        style: saveButtonText(),
                      ),
                      style: saveButtonStyle(),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:flutter/material.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({super.key});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: PresetColors.black,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                minLines: 1,
                maxLines: null,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.multiline,
                decoration: customInputDecoration(
                    hintText: 'Add Ingredients',
                    prefixIcon: Icon(
                      Icons.add_box_outlined,
                      color: PresetColors.white,
                      size: 28,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
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
            ],
          ),
        ),
      ),
    );
  }
}

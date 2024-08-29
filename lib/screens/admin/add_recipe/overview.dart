import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';

import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
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
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 35.0,
                top: 40,
                right: 35,
                bottom: 10,
              ),
              child: GestureDetector(
                child: Container(
                  height: screenHeight * 0.32,
                  color: PresetColors.offwhite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        size: 30,
                        color: PresetColors.fadedgrey,
                      ),
                      Text(
                        'Add Image',
                        style: TextStyle(
                          color: PresetColors.fadedgrey,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.multiline,
                    decoration: customInputDecoration(
                        hintText: 'Add Title',
                        prefixIcon: Icon(
                          Icons.add_box_outlined,
                          color: PresetColors.white,
                          size: 28,
                        )),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: customInputDecoration(
                        hintText: 'Short Description',
                        prefixIcon: Icon(
                          Icons.list_alt_outlined,
                          color: PresetColors.white,
                          size: 28,
                        )),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: customInputDecoration(
                        hintText: 'Preparation Time',
                        prefixIcon: Icon(
                          Icons.access_time_outlined,
                          color: PresetColors.white,
                          size: 28,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
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
            SizedBox(
              height: screenHeight * 0.1,
            )
          ],
        ),
      ),
    );
  }
}

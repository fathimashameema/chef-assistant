import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PresetColors.black,
      appBar: AppBar(
        title: Text(
          'Categories',
          style: customHeadingStyle(),
        ),
        centerTitle: true,
        backgroundColor: PresetColors.themegreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 40,
            mainAxisSpacing: 30,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return GridTile(
              child: Container(
                decoration: BoxDecoration(
                  color: PresetColors.offwhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Item $index',
                    style: TextStyle(color: PresetColors.black),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

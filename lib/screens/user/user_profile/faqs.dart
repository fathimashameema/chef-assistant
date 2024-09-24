

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:flutter/material.dart';

class Faqs extends StatelessWidget {
  const Faqs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PresetColors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: customArrowBack(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                "FAQ's",
                style: profileHeadingStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // FAQ items
            const ExpansionTile(
              title: Text(
                "How do I search for a recipe?",
                style: TextStyle(color: PresetColors.offwhite),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "To search for a recipe, use the search bar at the top of the home page. You can type in the name of the recipe, an ingredient, or a keyword related to the recipe.",
                    style: TextStyle(color: PresetColors.offwhite),
                  ),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text(
                "Can I submit my own recipes?",
                style: TextStyle(color: PresetColors.offwhite),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Yes, you can submit your own recipes through the 'Add Recipe' section. Fill out the required details, and your recipe will be reviewed before it is published.",
                    style: TextStyle(color: PresetColors.offwhite),
                  ),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text(
                "How do I save my favorite recipes?",
                style: TextStyle(color: PresetColors.offwhite),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "You can save your favorite recipes by tapping the heart icon on the recipe's page. To view your saved recipes, go to the 'Favorites' section in your profile.",
                    style: TextStyle(color: PresetColors.offwhite),
                  ),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text(
                "Do I need an account to use the app?",
                style: TextStyle(color: PresetColors.offwhite),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "No, you can use the app without an account. However, creating an account allows you to save your favorite recipes, submit your own recipes, and receive personalized recommendations.",
                    style: TextStyle(color: PresetColors.offwhite),
                  ),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text(
                "How do I change my profile details?",
                style: TextStyle(color: PresetColors.offwhite),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "To change your profile details, go to your profile and select 'Edit Profile.' You can update your name, email, and other details from this section.",
                    style: TextStyle(color: PresetColors.offwhite),
                  ),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text(
                "How do I contact support?",
                style: TextStyle(color: PresetColors.offwhite),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "If you need help or have any questions, you can contact our support team through the chefassistants@gmail.com email",
                    style: TextStyle(color: PresetColors.offwhite),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

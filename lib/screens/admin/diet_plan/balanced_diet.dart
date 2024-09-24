import 'package:flutter/material.dart';
import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';

class BalancedDietPage extends StatelessWidget {
  const BalancedDietPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PresetColors.black,
      appBar: CustomAppBar(
        title: Text(
          'Balanced Diet',
          style: homeHeadingStyle(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              'assets/images/vegan diet.jpeg',
              fit: BoxFit.cover,
            ),
          ),
         const SizedBox(height: 20),
          Text(
            "Introduction",
            style:
                profileHeadingStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
         const SizedBox(height: 10),
          Text(
            "A balanced diet is one that provides all the essential nutrients in the right proportions to maintain health and well-being. It includes a variety of foods from different food groups: carbohydrates, proteins, fats, vitamins, and minerals.",
            style: profileTextStyle(color: PresetColors.offwhite),
          ),
        const  SizedBox(height: 20),
          Text(
            "Diet Process",
            style:
                profileHeadingStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
         const SizedBox(height: 10),
          Text(
            "1. **Carbohydrates**: Include whole grains like brown rice, oats, and whole wheat bread.\n"
            "2. **Proteins**: Add lean meats, legumes, tofu, and dairy products.\n"
            "3. **Fats**: Opt for healthy fats like avocados, nuts, and olive oil.\n"
            "4. **Fruits & Vegetables**: Aim for a variety of colors to ensure a broad spectrum of nutrients.\n"
            "5. **Hydration**: Drink plenty of water throughout the day.\n",
            style: profileTextStyle(color: PresetColors.offwhite),
          ),
         const SizedBox(height: 20),
          Text(
            "Tips",
            style:
                profileHeadingStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        const  SizedBox(height: 10),
          Text(
            "1. Balance your plate with a variety of foods.\n"
            "2. Avoid excessive salt and sugar.\n"
            "3. Pay attention to portion sizes.\n"
            "4. Incorporate physical activity into your daily routine.\n",
            style: profileTextStyle(color: PresetColors.offwhite),
          ),
        ],
      ),
    );
  }
}

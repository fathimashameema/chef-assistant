import 'package:flutter/material.dart';
import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';

class VeganDietPage extends StatelessWidget {
  const VeganDietPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PresetColors.black,
      appBar: CustomAppBar(
        title: Text(
          'Vegan Diet',
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
              'assets/images/balanced diet.webp',
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
            "A Vegan Diet excludes all animal products, including meat, dairy, and eggs. It focuses on plant-based foods like fruits, vegetables, grains, nuts, and seeds.",
            style: profileTextStyle(color: PresetColors.offwhite),
          ),
          const SizedBox(height: 20),
          Text(
            "Diet Process",
            style:
                profileHeadingStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(
            "1. **Plant-Based Foods**: Focus on vegetables, fruits, legumes, nuts, and seeds.\n"
            "2. **Protein Sources**: Include tofu, tempeh, and legumes.\n"
            "3. **Whole Grains**: Opt for quinoa, brown rice, and oats.\n"
            "4. **Healthy Fats**: Use avocados, nuts, and seeds.\n"
            "5. **Supplements**: Consider vitamin B12 and iron supplements as needed.\n",
            style: profileTextStyle(color: PresetColors.offwhite),
          ),
          const SizedBox(height: 20),
          Text(
            "Tips",
            style:
                profileHeadingStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(
            "1. Plan your meals to ensure nutritional completeness.\n"
            "2. Experiment with new plant-based recipes.\n"
            "3. Read labels to avoid hidden animal products.\n"
            "4. Seek advice from a nutritionist if needed.\n",
            style: profileTextStyle(color: PresetColors.offwhite),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';

class KetoDietPage extends StatelessWidget {
  const KetoDietPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PresetColors.black,
      appBar: CustomAppBar(
        title: Text(
          'Keto Diet',
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
              'assets/images/keto image.jpeg',
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
            "The Keto Diet is a high-fat, moderate-protein, and very low-carb diet that helps your body enter a state of ketosis. In ketosis, your body burns fat for energy instead of carbohydrates.",
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
            "1. **High-Fat Foods**: Include sources like avocados, cheese, and fatty cuts of meat.\n"
            "2. **Moderate Protein**: Opt for eggs, fish, and poultry.\n"
            "3. **Low-Carb Vegetables**: Incorporate leafy greens and non-starchy veggies.\n"
            "4. **Limit Carbs**: Avoid grains, sugars, and high-carb fruits.\n"
            "5. **Stay Hydrated**: Drink plenty of water and consider adding electrolytes.\n",
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
            "1. Plan your meals to avoid carb-rich foods.\n"
            "2. Monitor your ketone levels.\n"
            "3. Include fiber-rich foods to maintain digestion.\n"
            "4. Consult with a healthcare provider before starting.\n",
            style: profileTextStyle(color: PresetColors.offwhite),
          ),
        ],
      ),
    );
  }
}

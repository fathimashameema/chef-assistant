import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/screens/admin/diet_plan/balanced_diet.dart';
import 'package:chef_assistant/screens/admin/diet_plan/keto_diet.dart';
import 'package:chef_assistant/screens/admin/diet_plan/vegan_diet.dart';
import 'package:flutter/material.dart';

class DietPlan extends StatefulWidget {
  const DietPlan({super.key});

  @override
  State<DietPlan> createState() => _DietPlanState();
}

class _DietPlanState extends State<DietPlan> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: PresetColors.black,
      appBar: CustomAppBar(
        leading: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: customArrowBack()),
        ),
        title: Text(
          'Diet Plan',
          style: homeHeadingStyle(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              // Header Image
              SizedBox(
                height: constraints.maxWidth < 600
                    ? screenHeight * 0.35
                    : screenHeight * 0.7,
                width: screenWidth,
                child: Image.asset(
                  'assets/images/pexels-photo-1640777.jpeg',
                  fit: BoxFit.cover,
                ),
              ),

              // Introduction Text
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 15, right: 10),
                child: Text(
                  "Try our healthy diet plan to meet your goals. Transform your life with every bite!",
                  style: profileTextStyle(color: PresetColors.yellow),
                  textAlign: TextAlign.center,
                ),
              ),

              // Section for Different Diet Plans
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Our Diet Plans",
                      style: profileHeadingStyle(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 15),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return const BalancedDietPage();
                        }));
                      },
                      child: _buildDietPlanCard(
                        context,
                        title: "Balanced Diet",
                        description:
                            "A well-rounded plan to maintain overall health with a mix of proteins, carbs, and fats.",
                        imageUrl: 'assets/images/vegan diet.jpeg',
                      ),
                    ),

                    const SizedBox(height: 10),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return const KetoDietPage();
                        }));
                      },
                      child: _buildDietPlanCard(
                        context,
                        title: "Keto Diet",
                        description:
                            "Low-carb, high-fat plan to induce ketosis and burn fat effectively.",
                        imageUrl: 'assets/images/keto image.jpeg',
                      ),
                    ),

                    const SizedBox(height: 10),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return const VeganDietPage();
                        }));
                      },
                      child: _buildDietPlanCard(
                        context,
                        title: "Vegan Diet",
                        description:
                            "Plant-based plan focusing on vegetables, fruits, nuts, and seeds.",
                        imageUrl: 'assets/images/balanced diet.webp',
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Tips Section
                    Text(
                      "Diet Tips",
                      style: profileHeadingStyle(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "1. Stay hydrated by drinking plenty of water throughout the day.\n"
                      "2. Include a variety of foods to ensure you get all necessary nutrients.\n"
                      "3. Monitor portion sizes to avoid overeating.\n"
                      "4. Limit processed and sugary foods for better health outcomes.\n"
                      "5. Consult with a nutritionist to tailor a plan specific to your needs.",
                      style: profileTextStyle(color: PresetColors.offwhite),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDietPlanCard(BuildContext context,
      {required String title,
      required String description,
      required String imageUrl}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color: PresetColors.nudegrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  imageUrl,
                  height: constraints.maxWidth < 600 ? 150 : 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: profileHeadingStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: profileTextStyle(color: PresetColors.offwhite),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

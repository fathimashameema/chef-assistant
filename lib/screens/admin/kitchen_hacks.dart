import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:flutter/material.dart';

class KitchenHacks extends StatefulWidget {
  const KitchenHacks({super.key});

  @override
  State<KitchenHacks> createState() => _KitchenHacksState();
}

class _KitchenHacksState extends State<KitchenHacks> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: PresetColors.black,
      appBar: CustomAppBar(
        leading: Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: customArrowBack()),
        ),
        title: Text(
          'Kitchen Hacks',
          style: homeHeadingStyle(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              SizedBox(
                height: constraints.maxWidth < 600
                    ? screenHeight * 0.35
                    : screenHeight * 0.8,
                width: screenWidth,
                child: Image.asset(
                  'assets/images/pexels-photo-4259140.webp',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 15,
                  right: 10,
                ),
                child: Text(
                  "Top Kitchen Hacks You'll Wish You Knew Sooner! These Simple Tricks Will Save You Time, Effort, and Money in the Kitchen!",
                  style: profileTextStyle(color: PresetColors.yellow),
                ),
              ),
              const SizedBox(height: 20),

              // Kitchen Hacks List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    kitchenHackTile(
                      title: "Peel Garlic Effortlessly",
                      description:
                          "Place a garlic bulb inside a jar, close the lid, and shake vigorously. The garlic cloves will separate from their skins effortlessly!",
                    ),
                    kitchenHackTile(
                      title: "Keep Herbs Fresh Longer",
                      description:
                          "Wrap your fresh herbs in a damp paper towel and store them in a sealed plastic bag in the fridge. This will help keep them fresh for a longer time.",
                    ),
                    kitchenHackTile(
                      title: "Prevent Boiling Over",
                      description:
                          "Place a wooden spoon across the top of a boiling pot to prevent it from boiling over. The spoon pops the bubbles and keeps the liquid contained.",
                    ),
                    kitchenHackTile(
                      title: "Soften Butter Quickly",
                      description:
                          "If you forgot to take the butter out of the fridge, simply grate it using a cheese grater. The small pieces will soften much faster.",
                    ),
                    kitchenHackTile(
                      title: "Freeze Leftover Sauce",
                      description:
                          "Pour leftover sauce into an ice cube tray and freeze. Once frozen, store the cubes in a ziplock bag for quick use in future dishes.",
                    ),
                    kitchenHackTile(
                      title: "Ripen Fruits Faster",
                      description:
                          "Place unripe fruits like avocados in a paper bag with a banana. The ethylene gas from the banana will speed up the ripening process.",
                    ),
                    kitchenHackTile(
                      title: "Keep Potatoes from Sprouting",
                      description:
                          "Store potatoes with apples to prevent sprouting. The ethylene gas released by apples helps inhibit the growth of sprouts on potatoes.",
                    ),
                    kitchenHackTile(
                      title: "Easily Remove Eggshells",
                      description:
                          "Add a teaspoon of baking soda to the water when boiling eggs. This makes the eggs easier to peel by loosening the shells.",
                    ),
                    kitchenHackTile(
                      title: "Juice Lemons More Efficiently",
                      description:
                          "Microwave lemons for 15-20 seconds before juicing. This softens the fruit, making it easier to extract more juice.",
                    ),
                    kitchenHackTile(
                      title: "Prevent Brown Sugar from Hardening",
                      description:
                          "Place a slice of bread or an apple wedge in the container with brown sugar to keep it soft and prevent clumping.",
                    ),
                    kitchenHackTile(
                      title: "Sharpen Knives with a Mug",
                      description:
                          "Turn a ceramic mug upside down and use the unglazed ring on the bottom as a makeshift knife sharpener.",
                    ),
                    kitchenHackTile(
                      title: "Clean a Blender in Seconds",
                      description:
                          "Fill the blender with warm water and a drop of dish soap, then blend for a few seconds. Rinse thoroughly for a quick clean-up.",
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

  // Kitchen Hack Tile Widget
  Widget kitchenHackTile({required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        color: PresetColors.nudegrey,
        child: ExpansionTile(
          title: Text(
            title,
            style: profileTextStyle(color: PresetColors.offwhite),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                description,
                style: profileTextStyle(color: PresetColors.offwhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

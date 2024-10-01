import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/add_shopping_item.dart';
import 'package:chef_assistant/db_functions/login_status.dart';
import 'package:chef_assistant/models/shopping_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/customs/colors.dart';

class RecipeDetailPage extends StatefulWidget {
  final RecipeItems recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  // This list will hold the state of the checkboxes for each ingredient
  List<bool>? _checkedIngredients;

  @override
  void initState() {
    super.initState();
    _initializeIngredientsState();
  }

  // Function to initialize checkbox states
  Future<void> _initializeIngredientsState() async {
    if (widget.recipe.ingredients != null) {
      _checkedIngredients =
          List<bool>.filled(widget.recipe.ingredients!.length, false);

      final cartItems = await AddShoppingItem().getCartItems();

      // Check if each ingredient is already in the cart
      for (int i = 0; i < widget.recipe.ingredients!.length; i++) {
        String ingredient = widget.recipe.ingredients![i];
        if (cartItems.any((item) => item.item == ingredient)) {
          _checkedIngredients![i] = true;
        }
      }

      // Trigger UI update
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: PresetColors.black,
      appBar: CustomAppBar(
        // automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: customArrowBack(),
          ),
        ),
        title: Text(
          widget.recipe.title ?? 'Recipe Details',
          style: homeHeadingStyle(),
        ),
        backgroundColor: PresetColors.themegreen,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              widget.recipe.image != null
                  ? Image.memory(
                      width: screenWidth,
                      height: constraints.maxWidth < 600
                          ? screenHeight * 0.3
                          : screenHeight * 0.7,
                      fit: BoxFit.cover,
                      widget.recipe.image!,
                    )
                  : Image.asset(
                      'assets/images/default_food.jpg',
                      width: screenWidth,
                      height: constraints.maxWidth < 600
                          ? screenHeight * 0.3
                          : screenHeight * 0.7,
                      fit: BoxFit.cover,
                    ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.title ?? 'No Title',
                      style: homeHeadingStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.recipe.description?.isNotEmpty == true
                          ? widget.recipe.description!
                          : 'Description Unavailable',
                      style: profileHeadingStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.recipe.categories?.isNotEmpty == true
                          ? widget.recipe.categories!.join(', ')
                          : 'Category not added',
                      style: profileHeadingStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.recipe.prepTime?.isNotEmpty == true
                          ? widget.recipe.prepTime!
                          : 'Preparation time Unavailable',
                      style: profileHeadingStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Text('Ingredients:', style: profileHeadingStyle()),
                    const SizedBox(height: 10),
                    // Displaying the list of ingredients with checkboxes
                    widget.recipe.ingredients?.isNotEmpty == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.recipe.ingredients!
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              String ingredient = entry.value;

                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      ingredient,
                                      style: profileHeadingStyle(fontSize: 18),
                                    ),
                                  ),
                                  LoginStatus().isLogged
                                      ? Checkbox(
                                          value: _checkedIngredients?[index] ??
                                              false,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _checkedIngredients![index] =
                                                  value!;
                                            });

                                            if (value == true) {
                                              // Add item to the shopping cart
                                              final cartItem =
                                                  ShoppingCartModel(
                                                      item: ingredient);
                                              AddShoppingItem()
                                                  .addItemTocart(cartItem);
                                            } else {
                                              // Remove item from the shopping cart
                                              AddShoppingItem()
                                                  .removeItemFromCart(
                                                      ingredient);
                                            }
                                          },
                                          activeColor: PresetColors.yellow,
                                          checkColor: PresetColors.black,
                                        )
                                      : const SizedBox(),
                                ],
                              );
                            }).toList(),
                          )
                        : Text(
                            'Ingredients Unavailable',
                            style: profileHeadingStyle(fontSize: 18),
                          ),
                    const SizedBox(height: 20),
                    Text('Directions:', style: profileHeadingStyle()),
                    const SizedBox(height: 10),
                    Text(
                      widget.recipe.directions?.isNotEmpty == true
                          ? widget.recipe.directions!
                          : 'Directions Unavailable',
                      style: profileHeadingStyle(fontSize: 18),
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
}

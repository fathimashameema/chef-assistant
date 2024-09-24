import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/functions/add_shopping_item.dart';
import 'package:flutter/material.dart';
import 'package:chef_assistant/models/shopping_cart_model.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final AddShoppingItem _shoppingItemFunctions = AddShoppingItem();
  List<bool> _checkedItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize the shopping cart by getting the items from Hive
    _shoppingItemFunctions.openShoppingCartBox();
  }

  @override
  void dispose() {
    // Close the Hive box when the page is disposed
    _shoppingItemFunctions.closeShoppingCartBox();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PresetColors.black,
      appBar: CustomAppBar(
        title: Text(
          'Shopping Cart',
          style: customHeadingStyle(),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _shoppingItemFunctions.shoppingCartNotifier,
        builder: (context, List<ShoppingCartModel> cartItems, child) {
          // Ensure the _checkedItems list is properly initialized based on the number of cart items
          if (_checkedItems.length != cartItems.length) {
            _checkedItems = List<bool>.filled(cartItems.length, false);
          }

          if (cartItems.isEmpty) {
            return const Center(
              child: Text(
                'Shopping Cart is empty',
                style: TextStyle(color: PresetColors.offwhite),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(
                    item.item,
                    style: profileTextStyle().copyWith(
                      decoration: _checkedItems[index]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: _checkedItems[index]
                          ? PresetColors.fadedgrey
                          : PresetColors.offwhite,
                    ),
                  ),
                  trailing: Checkbox(
                    value: _checkedItems[index],
                    onChanged: (bool? value) {
                      if (value == true) {
                        // Set the checkbox as checked and add strikethrough
                        setState(() {
                          _checkedItems[index] = true;
                        });
                      }
                    },
                    activeColor: PresetColors.yellow,
                    checkColor: PresetColors.black,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

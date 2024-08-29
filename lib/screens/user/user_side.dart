import 'package:chef_assistant/customs/custom_bottomnavbar.dart';
import 'package:chef_assistant/screens/user/add_recipe.dart';
import 'package:chef_assistant/screens/user/categories.dart';
import 'package:chef_assistant/screens/user/favourites.dart';
import 'package:chef_assistant/screens/user/homepage.dart';
import 'package:chef_assistant/screens/user/search.dart';
import 'package:chef_assistant/screens/user/shopping_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserSide extends StatefulWidget {
  const UserSide({super.key});

  @override
  State<UserSide> createState() => _UserSideState();
}

class _UserSideState extends State<UserSide> {
  List<NavItem> navItems = [
    NavItem(icon: Icons.home_filled),
    NavItem(icon: Icons.grid_view_rounded),
    NavItem(icon: Icons.add_circle_outlined),
    NavItem(icon: CupertinoIcons.heart_fill),
    NavItem(icon: Icons.shopping_cart),
    NavItem(icon: Icons.search)
  ];

  List<Widget> pages = [
    Homepage(),
    Categories(),
    AddRecipe(),
    Favourites(),
    ShoppingCart(),
    Search(),
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        pages[selectedIndex],
        Positioned(
          bottom: screenHeight * 0.015,
          left: screenWidth * 0.045,
          child: CustomBottomNavBar(
              items: navItems,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              }),
        ),
      ]),
    );
  }
}

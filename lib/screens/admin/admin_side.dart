import 'package:chef_assistant/customs/custom_bottomnavbar.dart';
import 'package:chef_assistant/screens/admin/add_recipe/admin_add_recipe.dart';
import 'package:chef_assistant/screens/admin/add_recipe/overview.dart';
import 'package:chef_assistant/screens/admin/admin_categories.dart';
import 'package:chef_assistant/screens/admin/admin_homepage.dart';
import 'package:chef_assistant/screens/admin/admin_items_list.dart';
import 'package:chef_assistant/screens/admin/admin_notifications.dart';
import 'package:chef_assistant/screens/user/add_recipe.dart';

import 'package:flutter/material.dart';

class AdminSide extends StatefulWidget {
  const AdminSide({super.key});

  @override
  State<AdminSide> createState() => _AdminSideState();
}

class _AdminSideState extends State<AdminSide> {
  List<NavItem> navItems = [
    NavItem(icon: Icons.home_filled),
    NavItem(icon: Icons.grid_view_rounded),
    NavItem(icon: Icons.add_circle_outlined),
    NavItem(icon: Icons.list),
    NavItem(icon: Icons.notifications),
  ];

  List<Widget> pages = [
    AdminHomepage(),
    AdminCategories(),
    AdminAddRecipe(),
    AdminItemsList(),
    AdminNotifications(),
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

import 'package:chef_assistant/customs/colors.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final TabController controller;
  final Color indicatorColor;
  final double indicatorWeight;

  CustomTabBar({
    required this.tabs,
    required this.controller,
    this.indicatorColor = Colors.yellow,
    this.indicatorWeight = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      indicatorColor: indicatorColor,
      indicatorWeight: indicatorWeight,
      labelColor: PresetColors.offwhite,
      unselectedLabelColor: PresetColors.white,
      labelStyle: TextStyle(fontSize: 15),
      indicator: BoxDecoration(
        color: Colors.transparent, // Transparent to avoid any background
      ),
      // Add other customization options as needed
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}

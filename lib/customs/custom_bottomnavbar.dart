import 'package:chef_assistant/customs/colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

 const CustomBottomNavBar({super.key, 
    required this.items,
    this.currentIndex = 0,
    required this.onTap,
  });

  @override
  CustomBottomNavBarState createState() => CustomBottomNavBarState();
}

class CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // width: double.infinity,
      padding:const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ), // Add padding
      decoration: BoxDecoration(
        color: PresetColors.nudegrey, // Background color of the nav bar
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: PresetColors.fadedgrey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          final isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onTap(index);
              // _navigateToPage(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration:const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Icon(
                    item.icon,
                    key: ValueKey<bool>(isSelected),
                    color:
                        isSelected ? PresetColors.yellow : PresetColors.white,
                  ),
                ),
               const SizedBox(height: 6),
                AnimatedContainer(
                  duration:const Duration(milliseconds: 300),
                  height: 2,
                  width: isSelected ? 30 : 0, // Underline moves and resizes
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        isSelected ? PresetColors.yellow : Colors.transparent,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String? label;

  NavItem({required this.icon, this.label});
}



import 'package:chef_assistant/customs/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Color backgroundColor;
  final double height;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? titleWidget;
  final bool centerTitle; // Add centerTitle property

 const CustomAppBar({super.key, 
    required this.title,
    this.backgroundColor = PresetColors.themegreen,
    this.height = 92.0,
    this.actions,
    this.leading,
    this.titleWidget,
    this.centerTitle = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Container(
        height: height,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            children: [
              leading ??
                 const SizedBox(width: 30), // Display leading widget or add padding
              Expanded(
                child: Align(
                  alignment: centerTitle
                      ? Alignment.center
                      : Alignment.centerLeft, // Center or left-align title
                  child: title,
                ),
              ),
              Row(
                mainAxisSize:
                    MainAxisSize.min, // Prevent actions from taking extra space
                children: actions ?? [],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

import 'package:chef_assistant/customs/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Color backgroundColor;
  final double height;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? titleWidget;

  CustomAppBar(
      {required this.title,
      this.backgroundColor = PresetColors.themegreen,
      this.height = 80.0,
      this.actions,
      this.leading,
      this.titleWidget});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Container(
        color: backgroundColor,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title,
            leading ??
                titleWidget ??
                Row(
                  children: actions ?? [], // Custom actions or an empty row
                ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

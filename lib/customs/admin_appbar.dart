import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/screens/admin/admin_profile/admin_profile.dart';
import 'package:flutter/material.dart';

class AdminAppbar extends StatelessWidget {
  const AdminAppbar({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AppBar(
          // centerTitle: true,
          elevation: 0,
          toolbarHeight: 90,
          backgroundColor: PresetColors.themegreen,
          title: Image(
              width: constraints.maxWidth < 600
                  ? screenHeight * 0.5
                  : screenHeight * 0.6,
              height: constraints.maxWidth < 600
                  ? screenHeight * 0.5
                  : screenHeight * 0.6,
              image: const AssetImage(
                  'assets/images/WhatsApp_Image_2024-08-08_at_00.18.03_d74232e0-removebg-preview.png')),
          actions: [
            CircleAvatar(
              radius: 15,
              backgroundColor: PresetColors.offwhite,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const AdminProfile()));
                  },
                  icon: const Icon(
                    Icons.admin_panel_settings,
                    size: 20,
                    color: PresetColors.black,
                  )),
            ),
            SizedBox(
              width: screenWidth * 0.09,
            )
          ],
        );
      },
    );
  }
}

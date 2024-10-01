import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/db_functions/login_status.dart';
import 'package:chef_assistant/screens/user/user_login.dart';
import 'package:chef_assistant/screens/user/user_profile/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.firstLetter,
  });

  final double screenWidth;
  final double screenHeight;
  final String? firstLetter;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AppBar(
          // centerTitle: true,
          elevation: 0,
          toolbarHeight: 80,
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
            if (LoginStatus().isLogged)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (cntx) {
                    return const UserProfile();
                  }));
                },
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: PresetColors.yellow,
                  child: Text(
                    firstLetter ?? '',
                    style: const TextStyle(color: PresetColors.black),
                  ),
                ),
              )
            else
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const Userlogin()));
                },
                icon: const Icon(
                  CupertinoIcons.profile_circled,
                  color: PresetColors.white,
                  size: 30,
                ),
              ),
            const SizedBox(
              width: 40,
            )
          ],
        );
      },
    );
  }
}

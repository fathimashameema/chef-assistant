import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/functions/login.dart';
import 'package:chef_assistant/screens/user/user_login.dart';

import 'package:flutter/material.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  String username = 'fathima shameema';
  String firstletter = 'F';

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: PresetColors.transparent,
          title: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: customArrowBack()),
          // iconTheme: const IconThemeData(color: PresetColors.white),
        ),
        backgroundColor: PresetColors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            userProfile(),
            logoutAndVersion(),
          ],
        ),
      ),
    );
  }

  Future logoutDialogue() async {
    return showDialog(
        context: context,
        builder: (cntxt) {
          return customAlertDialogue(
            title: const Text('Logging out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: PresetColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Login().adminLogout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => Userlogin()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: PresetColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ],
          );
        });
  }

  Widget userProfile() {
    return Column(
      children: [
        const SizedBox(
          height: 70,
        ),
        CircleAvatar(
          radius: 60,
          backgroundColor: PresetColors.yellow,
          child: Text(
            firstletter,
            // LoginStatus().currentUser[0].toUpperCase(),
            style: const TextStyle(color: PresetColors.black, fontSize: 40),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          // LoginStatus().currentUser,
          username,
          style: profileHeadingStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget logoutAndVersion() {
    return Column(
      children: [
        TextButton(
          style: ButtonStyle(
              alignment: Alignment.bottomLeft,
              overlayColor: WidgetStateProperty.resolveWith(
                  (state) => PresetColors.nudegrey)),
          onPressed: () {
            logoutDialogue();
          },
          child: const Text(
            'Log out',
            style: TextStyle(color: PresetColors.lightRed, fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Center(
          child: Text(
            'Version 1.0',
            style: TextStyle(
              color: PresetColors.offwhite,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}

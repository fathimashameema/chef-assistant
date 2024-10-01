import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/login.dart';
import 'package:chef_assistant/db_functions/login_status.dart';
import 'package:chef_assistant/db_functions/login_status_functions.dart';
import 'package:chef_assistant/screens/admin/admin_login.dart';
import 'package:chef_assistant/screens/user/user_login.dart';
import 'package:chef_assistant/screens/user/user_profile/edit_password.dart';
import 'package:chef_assistant/screens/user/user_profile/edit_username.dart';
import 'package:chef_assistant/screens/user/user_profile/faqs.dart';
import 'package:chef_assistant/screens/user/user_profile/privacy_policy.dart';
import 'package:chef_assistant/screens/user/user_profile/terms_conditions.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String username = LoginStatus().currentUser;
  String firstletter = LoginStatus().currentUser.trim()[0].toUpperCase();

  void updateUserName(String newUsername) {
    setState(() {
      username = newUsername;
      firstletter = newUsername.trim()[0].toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: CustomAppBar(
        //   title: GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: customArrowBack(),
        //   ),
        //   backgroundColor: PresetColors.transparent,
        //   // iconTheme: const IconThemeData(color: PresetColors.white),
        // ),
        backgroundColor: PresetColors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: customArrowBack(),
                ),
              ),
              Center(child: userProfile()),
              Container(
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: const BoxDecoration(
                    color: PresetColors.nudegrey,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      settingsSections('Account Settings', [
                        settingsItems(
                            'Username',
                            EditUsername(
                              onUsernameChanged: updateUserName,
                            ),
                            context),
                        settingsItems(
                            'Password', const EditPassword(), context),
                        settingsItems(
                            'Login as Admin', const Adminlogin(), context),
                      ]),
                      // settingsSections('App Settings', [
                      //   settingsItems('Display', const Display(), context),
                      // ]),
                      settingsSections('Help & Support', [
                        settingsItems("FAQ's", const Faqs(), context),
                        // settingsItems(
                        //     'Feedback', const UserFeedback(), context),
                      ]),
                      settingsSections('About', [
                        settingsItems(
                            'Privacy Policy', const PrivacyPolicy(), context),
                        settingsItems('Terms & Conditions',
                            const TermsConditions(), context),
                      ]),
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
                          style: TextStyle(
                              color: PresetColors.lightRed, fontSize: 20),
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
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logoutUser() async {
    try {
      await Login().logOutUser();
      // Login().setLoginStatus(false);
      setIsUserLogged(false);
      
      Navigator.of(context).pushAndRemoveUntil(
          (MaterialPageRoute(
            builder: (ctx) => const Userlogin(),
          )),
          (Route<dynamic> route) => false);
    } catch (e) {
      print('error occured :$e');
    }
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
                    logoutUser();
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
          height: 90,
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
}

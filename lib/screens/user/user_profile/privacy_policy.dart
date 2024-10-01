
import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PresetColors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: customArrowBack(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                "Privacy Policy",
                style: profileHeadingStyle(
                    fontSize: 28, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "17/08/2024",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Chef Assistant (\"we,\" \"us,\" or \"our\") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application (the \"Chef Assistent\"). By accessing or using the App, you agree to this Privacy Policy. If you do not agree with the terms of this policy, please do not use our App.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "1. Information We Collect",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "a. Personal Information\nWe may collect personal information, such as name, email address and username when you sign up or log in to Chef Assistant.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "b. Usage Data\nWe may automatically collect information about how you use the App, including device information, app usage statistics, IP address, and log data.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "c. Recipes and Preferences\nIf you create or save recipes within the App, we may store those recipes, ingredients, categories, and preferences to provide a personalized experience.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "2. How We Use Your Information",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We may use the information we collect in the following ways:\n- To create and manage your account.\n- To personalize your experience and improve our services.\n- To provide, operate, and maintain the App's functionalities.\n- To communicate with you, including sending updates, notifications, and support messages.\n- To monitor and analyze usage and trends to improve the App's features.\n- To ensure security and prevent fraud.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "3. How We Share Your Information",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We do not sell or rent your personal information to third parties. We may share your information with:\n- Service Providers: Trusted third-party service providers who assist us in operating the App and providing services.\n- Legal Requirements: If required by law or in response to valid legal requests, such as a court order or government investigation.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "4. Your Choices and Controls",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "- Access and Update: You can access and update your personal information through your account settings in the App.\n- Marketing Communications: If you receive promotional emails from us, you can opt out at any time by following the unsubscribe instructions included in those emails.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "5. Security of Your Information",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We use industry-standard security measures to protect your information from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission over the internet or electronic storage is completely secure, and we cannot guarantee absolute security.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            // Add more sections as needed
            const SizedBox(height: 20),
            const Text(
              "Contact Us",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "If you have any questions or concerns about this Privacy Policy, please contact us at:\n- Email: [ chefassistants@gmail.com ] ",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

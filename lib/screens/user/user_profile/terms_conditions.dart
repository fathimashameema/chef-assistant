
import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

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
                "Terms & Conditions",
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
            const SizedBox(height: 20),
            const Text(
              "1. Acceptance of Terms",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "By accessing or using the Chef Assistant app (\"App\"), you agree to be bound by these Terms and Conditions. If you do not agree with these terms, please do not use the App.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "2. Changes to Terms",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We reserve the right to modify or replace these Terms at any time. It is your responsibility to review these Terms periodically for changes. Continued use of the App following any changes signifies your acceptance of the new Terms.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "3. Use of the App",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "You may use the App for personal and non-commercial purposes. You agree not to use the App for any illegal or unauthorized purposes, including but not limited to violating intellectual property rights or introducing malicious software.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "4. User Accounts",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "To use certain features of the App, you may be required to create an account. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate and complete.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "5. Content Ownership",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "All content provided within the App, including recipes, images, text, and other materials, is the property of Chef Assistant or its content suppliers. You may not reproduce, distribute, modify, or otherwise exploit the content without the express written consent of the owner.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "6. User-Generated Content",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "By submitting content to the App, including recipes, comments, or other materials, you grant Chef Assistant a worldwide, non-exclusive, royalty-free license to use, reproduce, modify, publish, and distribute such content in connection with the App.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "7. Disclaimer of Warranties",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "The App is provided on an \"AS IS\" and \"AS AVAILABLE\" basis. We make no warranties, express or implied, regarding the App's operation, content, or availability.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "8. Limitation of Liability",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "To the fullest extent permitted by law, Chef Assistant shall not be liable for any damages arising from your use of the App, including but not limited to direct, indirect, incidental, punitive, or consequential damages.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "9. Governing Law",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "These Terms are governed by and construed in accordance with the laws of [Insert Jurisdiction]. Any disputes arising under these Terms shall be subject to the exclusive jurisdiction of the courts in that jurisdiction.",
              style: TextStyle(
                color: PresetColors.offwhite,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "10. Contact Us",
              style: TextStyle(
                color: PresetColors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "If you have any questions about these Terms, please contact us at:\n- Email: [chefassistants@gmail.com]",
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

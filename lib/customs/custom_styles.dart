import 'package:chef_assistant/customs/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration customInputDecoration(
    {required String hintText,
    Widget? sufixIcon,
    String? errortext,
    Widget? prefixIcon}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: PresetColors.fadedgrey,
      fontSize: 18,
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: PresetColors.white,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: PresetColors.fadedgrey,
      ),
    ),
    suffixIcon: sufixIcon,
    errorText: errortext,
    prefixIcon: prefixIcon,
  );
}

TextStyle customHeadingStyle(
    {Color? color = PresetColors.offwhite,
    double? fontSize = 25,
    FontWeight? fontWeight = FontWeight.w500}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

TextStyle profileHeadingStyle(
    {Color? color = PresetColors.white,
    double? fontSize = 20,
    FontWeight? fontWeight = FontWeight.w400}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

TextStyle profileTextStyle(
    {Color? color = PresetColors.white,
    double? fontSize = 15,
    FontWeight? fontWeight = FontWeight.w300}) {
  return GoogleFonts.lexend(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

Widget settingsSections(String title, List<Widget> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: profileHeadingStyle(),
      ),
      const SizedBox(
        height: 20,
      ),
      for (var item in items) item,
      const SizedBox(
        height: 20,
      )
    ],
  );
}

Widget settingsItems(String item, Widget page, BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (cntxt) {
        return page;
      }));
    },
    style: ButtonStyle(
      overlayColor:
          WidgetStateProperty.resolveWith((state) => PresetColors.nudegrey),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item,
          style: profileTextStyle(),
        ),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: PresetColors.white,
          size: 15,
        )
      ],
    ),
  );
}

Icon customArrowBack() {
  return const Icon(
    Icons.arrow_back,
    color: PresetColors.white,
    size: 20,
  );
}

InputDecoration basicInputDecoration({
  Color fillcolor = PresetColors.customBlack,
  bool filled = true,
  String? labelText,
  required String hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Color borderColor = PresetColors.nudegrey,
  Color focusedBorderColor = PresetColors.fadedgrey,
  Color labelColor = PresetColors.offwhite,
}) {
  return InputDecoration(
      fillColor: fillcolor,
      filled: filled,
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelStyle: TextStyle(color: labelColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: focusedBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: borderColor),
      ));
}

Widget customTextFormField({
  String? labelText,
  required String hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Color borderColor = PresetColors.nudegrey,
  Color focusedBorderColor = PresetColors.fadedgrey,
  Color labelColor = PresetColors.offwhite,
  TextEditingController? controller,
  TextInputType? keyboardType,
  bool obscureText = false,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    validator: validator,
    decoration: basicInputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      labelColor: labelColor,
    ),
  );
}

ButtonStyle customButtonStyle({
  Color backgroundColor = PresetColors.buttonColor,
  BorderRadiusGeometry? borderRadius,
}) {
  return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(backgroundColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      overlayColor:
          WidgetStateProperty.resolveWith((state) => PresetColors.offwhite));
}

TextStyle customButtonText({
  Color color = PresetColors.black,
  double fontSize = 20,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
  );
}

AlertDialog customAlertDialogue({
  Widget? title,
  Widget? content,
  List<Widget>? actions,
  Color backgroundColor = PresetColors.nudegrey,
  TextStyle? titleTextStyle,
  TextStyle? contentTextStyle,
}) {
  return AlertDialog(
    title: title,
    content: content,
    actions: actions,
    backgroundColor: backgroundColor,
    titleTextStyle:const TextStyle(
      color: PresetColors.white,
      fontSize: 23,
      fontWeight: FontWeight.w400,
    ),
    contentTextStyle:const TextStyle(
      color: PresetColors.white,
      fontSize: 15,
    ),
  );
}

Widget customTabBar({
  required List<Tab> tabs,
}) {
  return TabBar(
    tabs: tabs,
    dividerHeight: 0,
    indicator: UnderlineTabIndicator(
        borderRadius: BorderRadius.circular(5),
        borderSide:const BorderSide(
          color: PresetColors.yellow,
          width: 3,
        )),
    indicatorColor: PresetColors.yellow,
    indicatorWeight: 4,
    labelColor: PresetColors.offwhite,
    unselectedLabelColor: PresetColors.white,
    labelStyle:const TextStyle(fontSize: 15),
  );
}

ButtonStyle saveButtonStyle({
  Color backgroundColor = PresetColors.themegreen,
  BorderRadiusGeometry? borderRadius,
}) {
  return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(backgroundColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      overlayColor:
          WidgetStateProperty.resolveWith((state) => PresetColors.clipColor));
}

TextStyle saveButtonText({
  Color color = PresetColors.white,
  double fontSize = 20,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
  );
}

InputDecoration descriptionInputDec({
  String? hintText,
  TextStyle? hintStyle,
}) {
  return InputDecoration(
      enabledBorder:const UnderlineInputBorder(
        borderSide: BorderSide(width: 0, color: PresetColors.transparent),
      ),
      focusedBorder:const UnderlineInputBorder(
        borderSide: BorderSide(width: 0, color: PresetColors.transparent),
      ),
      hintMaxLines: 10,
      hintStyle: hintStyle ??const TextStyle(color: PresetColors.fadedgrey),
      hintText: hintText);
}

TextStyle homeHeadingStyle({
  double fontSize = 20,
  Color color = PresetColors.yellow,
}) {
  return GoogleFonts.ledger(
    fontSize: fontSize,
    color: color,
  );
}

ButtonStyle chipButtonstyle({Color? backgroundcolor = PresetColors.nudegrey}) {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all(backgroundcolor),
  );
}

TextStyle customCategoryText({
  Color color = PresetColors.white,
  double fontSize = 18,
}) {
  return GoogleFonts.ledger(
      color: color,
      fontSize: fontSize,
      shadows:
          List.filled(3,const Shadow(color: PresetColors.fadedgrey, blurRadius: 8)));
}

 Stack introScreens(
    double screenHeight,
    double screenWidth,
    BoxConstraints constraints,
    String image,
    String heading,
    String description,
  ) {
    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.15,
          left: screenWidth * 0.07,
          child: SizedBox(
            height: screenHeight * 0.4,
            width: screenWidth * 0.86,
            child: Image.asset(
              // 'assets/i/mages/intoduction screen (2).png',
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          bottom: screenHeight * 0.31,
          left: constraints.maxWidth < 600
              ? screenWidth * 0.25
              : screenWidth * 0.37,
          child: Text(
            heading,
            // 'Find your Dish',
            style: GoogleFonts.lemon(
              fontSize: constraints.maxWidth < 600
                  ? screenWidth * 0.065
                  : screenWidth * 0.03,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 210, 153, 20),
            ),
          ),
        ),
        // Description Text
        Positioned(
          bottom: screenHeight * 0.148,
          left: screenWidth * 0.04,
          child: SizedBox(
            height: screenHeight * 0.125,
            width: screenWidth * 0.89,
            child: Text(
              description,
              // 'Explore the varieties of recipes and find your comfort food. '
              // 'Find your favourite Dish with Chef Assistant.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: constraints.maxWidth < 600
                    ? screenWidth * 0.05
                    : screenWidth * 0.02,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }


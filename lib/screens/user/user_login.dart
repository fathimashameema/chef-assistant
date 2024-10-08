import 'package:chef_assistant/db_functions/login_status_functions.dart';
import 'package:chef_assistant/screens/admin/admin_login.dart';
import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/login.dart';
import 'package:chef_assistant/screens/home_screen.dart';
import 'package:chef_assistant/screens/user/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class Userlogin extends StatefulWidget {
  const Userlogin({super.key});

  @override
  State<Userlogin> createState() => _UserloginState();
}

class _UserloginState extends State<Userlogin> {
  final _formkey = GlobalKey<FormBuilderState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool visibility = false;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: PresetColors.clipColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  top: screenHeight * 0.09,
                  left: screenWidth * 0.09,
                  child: Text('Log-in',
                      style: GoogleFonts.orelegaOne(
                        color: PresetColors.white,
                        fontSize: constraints.maxWidth < 600
                            ? screenWidth * 0.12
                            : screenWidth * 0.05,
                      )),
                ),
                Positioned(
                    top: screenHeight * 0.07,
                    right: screenWidth * 0.09,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (ctxt) {
                            return const HomeScreen();
                          }),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: PresetColors.white,
                          fontSize: constraints.maxWidth < 600
                              ? screenWidth * 0.04
                              : screenWidth * 0.018,
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 180.0),
                  child: ClipPath(
                    clipper: OvalTopBorderClipper(),
                    child: Container(
                      height: screenHeight * 0.8,
                      width: double.infinity,
                      color: PresetColors.customBlack,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FormBuilder(
                            key: _formkey,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 35.0,
                                right: 35,
                                top: 60,
                              ),
                              child: ListView(
                                children: [
                                  Text(
                                    'User name/Email',
                                    style: TextStyle(
                                      color: PresetColors.white,
                                      fontSize: constraints.maxWidth < 600
                                          ? screenWidth * 0.056
                                          : screenWidth * 0.02,
                                    ),
                                  ),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Username field can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _username,
                                    decoration: customInputDecoration(
                                        hintText: 'Your Username or Email'),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'Password',
                                    style: TextStyle(
                                      color: PresetColors.white,
                                      fontSize: constraints.maxWidth < 600
                                          ? screenWidth * 0.056
                                          : screenWidth * 0.02,
                                    ),
                                  ),
                                  TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Password field can't be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: _password,
                                      obscureText: !visibility,
                                      decoration: customInputDecoration(
                                        hintText: 'Your Password',
                                        sufixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              visibility = !visibility;
                                            });
                                          },
                                          child: visibility
                                              ? Icon(
                                                  Icons.visibility_off,
                                                  color: PresetColors.white,
                                                  size:
                                                      constraints.maxWidth < 600
                                                          ? screenWidth * 0.04
                                                          : screenWidth * 0.02,
                                                )
                                              : Icon(
                                                  Icons.visibility,
                                                  color: PresetColors.white,
                                                  size:
                                                      constraints.maxWidth < 600
                                                          ? screenWidth * 0.04
                                                          : screenWidth * 0.02,
                                                ),
                                        ),
                                      )),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 40,
                                          bottom: 10,
                                        ),
                                        child: SizedBox(
                                          width: constraints.maxWidth < 600
                                              ? screenWidth * 0.67
                                              : screenWidth * 0.4,
                                          child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        PresetColors
                                                            .buttonColor),
                                                shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () async {
                                                if (_formkey.currentState !=
                                                        null &&
                                                    _formkey.currentState!
                                                        .validate()) {
                                                  final usernameOrEmail =
                                                      _username.text;
                                                  final password =
                                                      _password.text;
                                                  final haveAccount =
                                                      await Login().getUser(
                                                          usernameoremail:
                                                              usernameOrEmail,
                                                          password: password);

                                                  haveAccount
                                                      ? gotohomepage(context)
                                                      : showerror();
                                                } else {
                                                  print('null is here');
                                                }
                                              },
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                  color: PresetColors.black,
                                                  fontSize:
                                                      constraints.maxWidth < 600
                                                          ? screenWidth * 0.053
                                                          : screenWidth * 0.03,
                                                ),
                                              )),
                                        ),
                                      ),
                                      Text(
                                        "Don't have an account?",
                                        style: TextStyle(
                                          color: PresetColors.fadedgrey,
                                          fontSize: constraints.maxWidth < 600
                                              ? screenWidth * 0.04
                                              : screenWidth * 0.017,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const UserSignup()));
                                        },
                                        child: Text(
                                          'Create an Account',
                                          style: TextStyle(
                                            color: PresetColors.offwhite,
                                            fontSize: constraints.maxWidth < 600
                                                ? screenWidth * 0.047
                                                : screenWidth * 0.024,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.14,
                                  ),
                                  TextButton(
                                      style: ButtonStyle(
                                        overlayColor:
                                            WidgetStateProperty.resolveWith(
                                                (state) =>
                                                    PresetColors.customBlack),
                                      ),
                                      onPressed: () {
                                        adminlogin();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.admin_panel_settings,
                                            color: PresetColors.white,
                                            size: constraints.maxWidth < 600
                                                ? screenWidth * 0.045
                                                : screenWidth * 0.025,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            'Admin',
                                            style: TextStyle(
                                              color: PresetColors.white,
                                              fontSize:
                                                  constraints.maxWidth < 600
                                                      ? screenWidth * 0.038
                                                      : screenWidth * 0.018,
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> gotohomepage(BuildContext cntxt) async {
    Login().userLogin();
    // Login().setLoginStatus(true);
    // Login().setAdminStatus(false);
    setIsUserLogged(true);
    setIsAdminLogged(false);
    Navigator.of(cntxt).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Future adminlogin() async {
    print('tapped');
    Navigator.of(context).push(MaterialPageRoute(builder: (ctxt) {
      return const Adminlogin();
    }));
  }

  Future<void> showerror() async {
    await Future.delayed(const Duration(milliseconds: 700));
    showDialog(
      context: context,
      builder: (ctx) {
        return customAlertDialogue(
          title: const Text('Incorrect information'),
          content: const Text(
              "The Password/Username you've entered is incorrect. Please try again"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'ok',
                style: TextStyle(
                  color: PresetColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/db_functions/login.dart';
import 'package:chef_assistant/db_functions/login_status_functions.dart';
import 'package:chef_assistant/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({super.key});

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  final _formkey = GlobalKey<FormBuilderState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool visibility = false;
  String crctusername = 'fathimashameema';
  String crctpassword = 'fathym123';

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
        backgroundColor: const Color.fromARGB(255, 54, 50, 50),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  top: screenHeight * 0.09,
                  left: screenWidth * 0.09,
                  child: Text('Log-in',
                      style: GoogleFonts.orelegaOne(
                        color: Colors.white,
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
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
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
                                    'User name',
                                    style: TextStyle(
                                      color: Colors.white,
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
                                      } else if (value != crctusername) {
                                        return 'Invalid Username';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _username,
                                    decoration: InputDecoration(
                                      hintText: 'Your Username',
                                      hintStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 125, 123, 123),
                                        fontSize: constraints.maxWidth < 600
                                            ? screenWidth * 0.046
                                            : screenWidth * 0.015,
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 119, 118, 118),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'Password',
                                    style: TextStyle(
                                      color: Colors.white,
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
                                      } else if (value != crctpassword) {
                                        return 'Invalid Password';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _password,
                                    obscureText: !visibility,
                                    decoration: InputDecoration(
                                      hintText: 'Your Password',
                                      hintStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 125, 123, 123),
                                        fontSize: constraints.maxWidth < 600
                                            ? screenWidth * 0.046
                                            : screenWidth * 0.015,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            visibility = !visibility;
                                          });
                                        },
                                        child: visibility
                                            ? Icon(
                                                Icons.visibility_off,
                                                color: Colors.white,
                                                size: constraints.maxWidth < 600
                                                    ? screenWidth * 0.04
                                                    : screenWidth * 0.02,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                color: Colors.white,
                                                size: constraints.maxWidth < 600
                                                    ? screenWidth * 0.04
                                                    : screenWidth * 0.02,
                                              ),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 119, 118, 118),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 40,
                                          bottom: 10,
                                        ),
                                        child: SizedBox(
                                          // width: 260,
                                          width: constraints.maxWidth < 600
                                              ? screenWidth * 0.67
                                              : screenWidth * 0.4,
                                          child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 190, 190, 164),
                                                ),
                                                shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                if (_formkey.currentState !=
                                                        null &&
                                                    _formkey.currentState!
                                                        .validate()) {
                                                  gotohomepage(context);
                                                } else {
                                                  print('null is here');
                                                }
                                              },
                                              child: Text(
                                                'Login as Admin',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      constraints.maxWidth < 600
                                                          ? screenWidth * 0.053
                                                          : screenWidth * 0.02,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
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
    final username = _username.text;
    final password = _password.text;

    if (username.trim() == crctusername.trim() &&
        password.trim() == crctpassword.trim()) {
      Login().adminLogin();
      // Login().setAdminStatus(true);
      // Login().setLoginStatus(false);
      setIsAdminLogged(true);
      setIsUserLogged(false);
      Navigator.of(cntxt).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }
}

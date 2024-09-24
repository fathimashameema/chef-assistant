import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/functions/login.dart';
import 'package:chef_assistant/functions/login_status.dart';
import 'package:chef_assistant/functions/signup.dart';
import 'package:chef_assistant/screens/home_screen.dart';
import 'package:chef_assistant/models/user_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  // static bool userlogged = false;
  final _formkey = GlobalKey<FormBuilderState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final FocusNode _usernamefocus = FocusNode();
  bool visibility = false;
  final Signup _uservalues = Signup();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _uservalues.openBox();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _uservalues.closeBox();
    _username.dispose();
    _password.dispose();
    _email.dispose();
  }

  // List<UserValues>? _uservaluelist = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: PresetColors.clipColor,
        body: Stack(
          children: [
            Positioned(
              top: 60,
              left: 30,
              child: Text('Sign-up',
                  style: GoogleFonts.orelegaOne(
                    color: PresetColors.white,
                    fontSize: 50,
                    // fontWeight: FontWeight.w300,
                  )),
            ),
            Positioned(
                top: 50,
                right: 30,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (ctxt) {
                          return const HomeScreen();
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: PresetColors.white,
                      fontSize: 17,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 180.0),
              child: ClipPath(
                clipper: OvalTopBorderClipper(),
                child: Container(
                  height: 670,
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
                              const Text(
                                'User name',
                                style: TextStyle(
                                  color: PresetColors.white,
                                  fontSize: 22,
                                ),
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Username field can't be empty";
                                  } else if (_uservalues
                                      .isUsernameExist(value)) {
                                    return 'Username unavailable.Try using another';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _username,
                                focusNode: _usernamefocus,
                                decoration: customInputDecoration(
                                    hintText: 'Your Username'),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                'Password',
                                style: TextStyle(
                                  color: PresetColors.white,
                                  fontSize: 22,
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
                                          ? const Icon(
                                              Icons.visibility_off,
                                              color: PresetColors.white,
                                              size: 15,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color: PresetColors.white,
                                              size: 15,
                                            ),
                                    ),
                                  )),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                'Email',
                                style: TextStyle(
                                  color: PresetColors.white,
                                  fontSize: 22,
                                ),
                              ),
                              TextFormField(
                                                                autovalidateMode: AutovalidateMode.onUserInteraction,

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return null;
                                  } else if (!isEmailValid(email: value)) {
                                    return "Please enter a valid email address";
                                  } else if (_uservalues.isEmailExist(value)) {
                                    return 'Email already exists';
                                  }
                                  return null;
                                },
                                controller: _email,
                                decoration: customInputDecoration(
                                  hintText: 'Your Email',
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 40,
                                      bottom: 10,
                                    ),
                                    child: SizedBox(
                                      width: 260,
                                      child: TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    PresetColors.buttonColor),
                                            shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (_formkey.currentState != null &&
                                                _formkey.currentState!
                                                    .validate()) {
                                              final values = UserValues(
                                                  username: _username.text,
                                                  password: _password.text,
                                                  email: _email.text);

                                              _uservalues.addUserValues(values);
                                              print(values);

                                              gotohomepage(context);
                                            } else {
                                              print('null is here');
                                            }
                                          },
                                          child: const Text(
                                            'Signup',
                                            style: TextStyle(
                                              color: PresetColors.black,
                                              fontSize: 20,
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
        ),
      ),
    );
  }

  Future<void> gotohomepage(BuildContext cntxt) async {
    Login().userLogin();
    LoginStatus().currentUser = _username.text;
    Navigator.of(cntxt).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  // Future loginpage() async {
  //   print('tapped');
  //   Navigator.of(context).push(MaterialPageRoute(builder: (ctxt) {
  //     return Userlogin();
  //   }));
  // }

  bool isEmailValid({required String email}) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(email);
  }
}

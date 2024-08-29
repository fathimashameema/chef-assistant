import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/functions/login.dart';
import 'package:chef_assistant/functions/login_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  TextEditingController _passwordController = TextEditingController();
  bool _visibility = false;

  @override
  void initState() {
    _passwordController =
        TextEditingController(text: LoginStatus().currentPassword);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _passwordController;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: PresetColors.black,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: customArrowBack(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: Text(
                          'Edit Password',
                          style: profileHeadingStyle(
                              fontSize: 28, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: customTextFormField(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _visibility = !_visibility;
                                });
                              },
                              child: _visibility
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: PresetColors.offwhite,
                                      size: 15,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: PresetColors.offwhite,
                                      size: 15,
                                    ),
                            ),
                            obscureText: !_visibility,
                            controller: _passwordController,
                            labelText: 'Password',
                            hintText: 'Password'),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 300,
                    child: TextButton(
                        style: customButtonStyle(),
                        onPressed: () {
                          savevalueDialogue();
                        },
                        child: Text(
                          'Save',
                          style: customButtonText(),
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Future savevalueDialogue() async {
    return showDialog(
        context: context,
        builder: (ctx) {
          return customAlertDialogue(
              title: Text('Save changes ?'),
              // content: Text('Save changes ?'),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _passwordController.text = LoginStatus().currentUser;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: PresetColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      saveValue();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: PresetColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ]);
        });
  }

  Future<void> saveValue() async {
    if (LoginStatus().currentUserId != null) {
      await Login().updatePassword(
          index: LoginStatus().currentUserId!,
          password: _passwordController.text);
      print('updated');
      LoginStatus().currentPassword = _passwordController.text;
      setState(() {
        _passwordController.text = LoginStatus().currentPassword;
      });

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      print('user id not found');
    }
  }
}

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/login.dart';
import 'package:chef_assistant/db_functions/login_status.dart';
import 'package:flutter/material.dart';

class EditUsername extends StatefulWidget {
    final Function(String) onUsernameChanged;

  const EditUsername({super.key, required this.onUsernameChanged});

  @override
  State<EditUsername> createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {
  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    _usernameController =
        TextEditingController(text: LoginStatus().currentUser);
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
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
                          'Edit Username',
                          style: profileHeadingStyle(
                              fontSize: 28, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: customTextFormField(
                            controller: _usernameController,
                            labelText: 'Username',
                            hintText: 'Username'),
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
              title: const Text('Save changes ?'),
              // content: Text('Save changes ?'),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _usernameController.text = LoginStatus().currentUser;
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
      await Login().updateUsername(
          index: LoginStatus().currentUserId!,
          username: _usernameController.text);
      print('updated');
      LoginStatus().currentUser = _usernameController.text;
      // setState(() {
      //   _usernameController.text = LoginStatus().currentUser;
      // });
      widget.onUsernameChanged(_usernameController.text);


      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      print('user id not found');
    }
  }
}

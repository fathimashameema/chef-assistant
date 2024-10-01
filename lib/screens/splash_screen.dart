import 'package:chef_assistant/db_functions/login_status.dart';
import 'package:chef_assistant/db_functions/login_status_functions.dart';
import 'package:chef_assistant/screens/admin/admin_side.dart';
import 'package:chef_assistant/screens/introduction_screen.dart';
import 'package:chef_assistant/screens/user/user_login.dart';
import 'package:chef_assistant/screens/user/user_side.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    entryCheck(); // Initiate the login check
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: kIsWeb
                ? Lottie.asset(
                    'assets/animations/Flow 2.json',
                    repeat: false,
                    fit: BoxFit.fill,
                  )
                : Lottie.asset(
                    'assets/animations/Flow 1 (4).json',
                    repeat: false,
                    fit: BoxFit.fill,
                  ),
          );
        },
      ),
    );
  }

  // Updated function with proper async handling and debug prints
  void entryCheck() async {
    await Future.delayed(
        const Duration(milliseconds: 4000)); // Simulate splash duration
    print('Splash screen ended');
    final hasSeenIntro = await getHasSeenIntro();
    final isUserLogged = await getIsUserLogged();
    final isAdminLogged = await getIsAdminLogged();

    if (isAdminLogged == true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const AdminSide()),
      );
    } else if (isUserLogged == true) {
      LoginStatus().isLogged = true;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (ctx) => UserSide(
                  isUserLogged: isUserLogged,
                )),
      );
    } else if (hasSeenIntro == true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const Userlogin()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const Introductionscreen()),
      );
    }
  }
}

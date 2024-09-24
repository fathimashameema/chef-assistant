import 'package:chef_assistant/functions/login_status.dart';
import 'package:chef_assistant/screens/admin/admin_side.dart';
import 'package:chef_assistant/screens/introduction_screen.dart';
import 'package:chef_assistant/screens/user/user_login.dart';
import 'package:chef_assistant/screens/user/user_side.dart';
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
    entryCheck();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Lottie.asset(
          'assets/animations/Flow 1 (4).json',
          repeat: false,
          fit: BoxFit.fill,
          // frameRate: FrameRate.max,
        ),
      ),
    );
  }

  Future animate() async {
    await Future.delayed(const Duration(milliseconds: 6000));

    if (LoginStatus().hasSeenIntro == false) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const Introductionscreen()));
      LoginStatus().hasSeenIntro = true;
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const Userlogin()));
    }
  }

  void entryCheck() {
    if (LoginStatus().isLogged && LoginStatus().isAdmin) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const AdminSide()));
    } else if (LoginStatus().isLogged) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const UserSide()));
    } else if (LoginStatus().hasSeenIntro) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const Userlogin()));
    } else {
      animate();
    }
  }
}

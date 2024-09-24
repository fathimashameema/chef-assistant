import 'package:chef_assistant/screens/admin/admin_side.dart';
import 'package:chef_assistant/functions/login_status.dart';
import 'package:chef_assistant/screens/user/user_side.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LoginStatus().isAdmin ? const AdminSide() : const UserSide();
  }
}

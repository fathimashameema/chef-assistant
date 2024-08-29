import 'package:flutter/material.dart';

class AdminItemsList extends StatefulWidget {
  const AdminItemsList({super.key});

  @override
  State<AdminItemsList> createState() => _AdminItemsListState();
}

class _AdminItemsListState extends State<AdminItemsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('List of items'),
      ),
    );
  }
}
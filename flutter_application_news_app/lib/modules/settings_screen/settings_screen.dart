import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
            "settings screen",
            style: TextStyle(fontSize: 40),
          ),
    );
  }
}
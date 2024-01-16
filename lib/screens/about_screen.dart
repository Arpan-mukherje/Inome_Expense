import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 240, 197),
        title: Text("Logout"),
      ),
      body: Center(
          child: Container(
        height: 200,
        width: 200,
        color: Colors.teal,
      )),
    );
  }
}

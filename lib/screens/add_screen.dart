import 'package:assignment/Services/google_signup.dart';
import 'package:assignment/screens/Authenticaton/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 240, 197),
        title: Text("Logout"),
      ),
      body: Center(
          child: GestureDetector(
        onTap: () {
          Authmethod auth = Authmethod();
          auth.signout();
          FirebaseAuth.instance.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Container(
          height: 200,
          width: 200,
          color: Colors.teal,
          child: Icon(
            Icons.logout,
            size: 50,
            color: Colors.white,
          ),
        ),
      )),
    );
  }
}

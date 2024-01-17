import 'package:assignment/Services/Firebase_services.dart/firebase_auth.dart';
import 'package:assignment/screens/Authenticaton/signup.dart';
import 'package:assignment/screens/first_page.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _performLogin() {
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email and password cannot be empty.'),
        ),
      );
    } else {
      AuthService.login(email, password).then((value) {
        if (value != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Login successful.'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect email or password. Please try again.'),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: const Center(
          child: Text(
            "Login",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minimumSize: Size(
                  MediaQuery.of(context).size.width * 0.9,
                  MediaQuery.of(context).size.height * 0.07,
                ),
              ),
              onPressed: _performLogin,
              child: const Text(
                "LOGIN",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // const Center(
            //   child: Text(
            //     "or with",
            //     style: TextStyle(fontSize: 18),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(18),
            //   child: OutlinedButton(
            //     onPressed: () {},
            //     style: OutlinedButton.styleFrom(
            //       backgroundColor: Colors.transparent,
            //       side: const BorderSide(color: Colors.grey),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       elevation: 0,
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            //       minimumSize: Size(
            //         MediaQuery.of(context).size.width * 0.8,
            //         MediaQuery.of(context).size.height * 0.07,
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Image.asset(
            //           'assets/flat-color-icons_google.png',
            //           height: 24,
            //           width: 24,
            //         ),
            //         const SizedBox(width: 10),
            //         const Text(
            //           "Sign Up with Google",
            //           style: TextStyle(color: Colors.black, fontSize: 20),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "Don't have any account? Sign Up",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}

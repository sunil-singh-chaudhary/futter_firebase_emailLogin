import 'package:firebase_first_demo/login_feature/login_screen.dart';
import 'package:firebase_first_demo/register_feature/core/Auth.dart';
import 'package:firebase_first_demo/register_feature/core/login_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = Auth();
  final loginauth = LoginAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          auth.signOut();
          loginauth.removeLoginDetails();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        },
        child: const Text('Logout',
            style: TextStyle(color: Colors.white, fontSize: 22)),
      )),
    );
  }
}

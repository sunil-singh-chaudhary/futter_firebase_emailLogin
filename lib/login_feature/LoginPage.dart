import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../mainScreen/HomeScreen.dart';
import '../firebase_options.dart';
import '../register_feature/core/Auth.dart';

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({super.key});

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  void initState() {
    Firebase.initializeApp(
      //initialized firebase
      options: DefaultFirebaseOptions.currentPlatform,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final n_auth = context.read<Auth>();

    void getloginData() async {
      if (kDebugMode) {
        print('calling clik');
      }
      final userinfo = await n_auth.googleButtonSignIn();
      if (userinfo!.uid.isEmpty) {
        if (kDebugMode) {
          print('Login ERRORR');
        }
      } else {
        if (kDebugMode) {
          print(' ${userinfo.email}');
        }
      }

      MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      );
    }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Login page')),
          body: Center(
              child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    getloginData();
                  },
                  child: const Text("signin google"))
            ],
          ))),
    );
  }
}

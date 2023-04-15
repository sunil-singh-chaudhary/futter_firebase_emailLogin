import 'package:firebase_first_demo/register_feature/core/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mainScreen/HomeScreen.dart';
import 'Auth.dart';

class LoginAuth {
  void startLoginProcess(
      {required BuildContext context,
      required Map<dynamic, dynamic> loginDataMap,
      required Auth auth,
      required TextEditingController email_controller,
      required TextEditingController passwrd_controller}) async {
    var user = await auth.LoginUsingEmail(
        emailAddress: email_controller.text, password: passwrd_controller.text);
    user.fold(
      (l) => ShowSnackBar.showCustomSnackbar(context, l.toString()),
      (r) {
        Navigator.push(
          //r denote succes
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        savetoSignInPref();
      },
    );
  }

  void savetoSignInPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
  }

  void removeLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogin');
    print(await prefs.remove('isLogin'));
  }
}

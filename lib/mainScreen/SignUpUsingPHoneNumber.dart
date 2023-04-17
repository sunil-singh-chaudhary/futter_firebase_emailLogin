import 'package:firebase_first_demo/register_feature/core/Auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'OTPScreen.dart';

class SignUpUsingPHoneNumber extends StatefulWidget {
  const SignUpUsingPHoneNumber({super.key});

  @override
  State<SignUpUsingPHoneNumber> createState() => _SignUpUsingPHoneNumberState();
}

class _SignUpUsingPHoneNumberState extends State<SignUpUsingPHoneNumber> {
  TextEditingController phone_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('OTP Verfication'),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(
                controller: phone_controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'enter phone no'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<Auth>()
                        .loginUsingPhonenumber(phone_controller.text.trim());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTPScreen(),
                        ));
                  },
                  child: const Text('send OTP')),
            )
          ],
        ),
      ),
    );
  }
}

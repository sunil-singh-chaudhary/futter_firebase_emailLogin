import 'package:firebase_first_demo/register_feature/core/Auth.dart';
import 'package:firebase_first_demo/register_feature/core/login_auth.dart';
import 'package:firebase_first_demo/register_feature/core/showSnackbar.dart';
import 'package:firebase_first_demo/register_feature/utils/CommonFocusNode.dart';
import 'package:firebase_first_demo/register_feature/widget/BottomText.dart';
import 'package:firebase_first_demo/register_feature/widget/CreateAcc.dart';
import 'package:firebase_first_demo/register_feature/widget/ErroViewField.dart';
import 'package:firebase_first_demo/register_feature/widget/FillTitle.dart';
import 'package:firebase_first_demo/register_feature/widget/SignUpText.dart';
import 'package:firebase_first_demo/register_feature/widget/TextStylish.dart';
import 'package:firebase_first_demo/register_feature/widget/prefixIconData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../mainScreen/HomeScreen.dart';
import '../register_feature/utils/maps.dart';

enum LoginENUM {
  email,
  password,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final keygobal = GlobalKey<FormState>();
  final email_controller = TextEditingController();
  final passwrd_controller = TextEditingController();
  final emailFocusNode = CommonFocusNode(); //FocusNode Init
  final passwordFocusNode = CommonFocusNode();
  final auth = Auth();
  final loginauth = LoginAuth();

  final _loginDataMap = {};

  @override
  void dispose() {
    // Clean up the FocusNode when the widget is disposed
    emailFocusNode.disposed();
    passwordFocusNode.disposed();
    super.dispose();
  }

  String _emailError = '';
  String _pswdError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF201a30),
      body: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: 30.h,
            width: double.infinity,
            child: const Image(
              image: AssetImage('assets/crop_bg.png'),
            ),
          ),
          CreateAccount(title: 'Login'),
          fillTitle(title: 'Please Sign in to continue'),
          Expanded(
              child: SingleChildScrollView(
            child: Form(
              key: keygobal,
              child: Column(children: [
                Stack(
                  children: [
                    emailWidget(),
                    Positioned(
                      bottom: 5,
                      left: 4,
                      child: ErrorVieFieldName(
                        nameError: _emailError,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    passwordWidget(),
                    Positioned(
                      bottom: 5,
                      left: 4,
                      child: ErrorVieFieldName(
                        nameError: _pswdError,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                sigUpText(
                  titletext: 'Login',
                  click_btn_callback: (context) {
                    keygobal.currentState!.save();
                    print(_loginDataMap);
                    bool containsEmptyValue = _loginDataMap.containsValue('');

                    if (containsEmptyValue) {
                      ShowSnackBar.showCustomSnackbar(
                          context, 'fill all Field First');
                      return;
                    }
                    loginauth.startLoginProcess(
                        context: context,
                        loginDataMap: _loginDataMap,
                        auth: auth,
                        email_controller: email_controller,
                        passwrd_controller: passwrd_controller);
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () {
                    print('ciick Forgot password');
                  },
                  child: SizedBox(
                    height: 5.h,
                    child: const Text('Forgot Password?',
                        style: TextStyle(
                            color: Color(0xFF11a5a0),
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                  ),
                )
              ]),
            ),
          ))
        ],
      ),
      bottomNavigationBar: BottomText(
        title: 'Sign Up',
        description: 'Don\'t have an account?',
        callbackAction: () {
          print('click on login  scren');
        },
      ),
    );
  }

  Widget emailWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: emailFocusNode.isFocused
            ? const Color(0xFF38304d)
            : const Color(0xFF201a31),
      ),
      width: double.infinity,
      child: TextFormField(
        key: const ValueKey('email_key'),
        focusNode: emailFocusNode.focusNode,
        style: stylish,
        controller: email_controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: PrefixIconData(
                isTextFieldFocused: emailFocusNode.isFocused,
                preIcon: Icons.email),
            hintStyle: const TextStyle(
              color: Color(0xFFf3f3f4),
            ),
            labelText: 'EMAIL',
            labelStyle:
                TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h)),
        onTap: () {
          onTextFieldTap('EMAIL');
        },
        onTapOutside: (event) {
          tapOutsidde();
        },
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          _loginDataMap['EMAIL'] = newValue!;
        },
        onChanged: (value) {
          _validateName(LoginENUM.email, value); // Call validation function
        },
      ),
    );
  }

  Widget passwordWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: passwordFocusNode.isFocused
            ? const Color(0xFF38304d)
            : const Color(0xFF201a31),
      ),
      width: double.infinity,
      child: TextFormField(
        key: const ValueKey('password_key'),
        focusNode: passwordFocusNode.focusNode,
        style: stylish,
        obscureText: true,
        controller: passwrd_controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: PrefixIconData(
                isTextFieldFocused: passwordFocusNode.isFocused,
                preIcon: Icons.lock),
            hintStyle: const TextStyle(
              color: Color(0xFFf3f3f4),
            ),
            labelText: 'PASSWORD',
            labelStyle:
                TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h)),
        onTap: () {
          onTextFieldTap('PASSWORD');
        },
        onTapOutside: (event) {
          tapOutsidde();
        },
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          _loginDataMap['PASSWORD'] = newValue!;
        },
        onChanged: (value) {
          _validateName(LoginENUM.password, value); // Call validation function
        },
      ),
    );
  }

  void tapOutsidde() {
    setState(() {
      emailFocusNode.unfocus();
      passwordFocusNode.unfocus();
    });
  }

  void onTextFieldTap(String tapon) {
    // print(tapon);
    setState(() {
      setState(() {
        if (tapon == 'EMAIL') {
          emailFocusNode.requestFocus();
        } else if (tapon == 'PASSWORD') {
          passwordFocusNode.requestFocus();
        }
      });
    });
  }

  void _validateName(LoginENUM LoginKEY, String value) {
    String error = ValidMap.errorMap[LoginKEY] ?? '';
    if (value == '') {
      setState(() {
        switch (LoginKEY) {
          case LoginENUM.email:
            _emailError = error;
            // Add email validation logic here
            break;

          case LoginENUM.password:
            _pswdError = error;
            // Add password validation logic here
            break;
        }
      });
    } else {
      setState(() {
        _emailError = '';
        _pswdError = '';
      });
    }
  }
}

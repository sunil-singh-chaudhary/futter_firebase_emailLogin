// ignore_for_file: non_constant_identifier_names

import 'package:firebase_first_demo/register_feature/core/Auth.dart';
import 'package:firebase_first_demo/register_feature/core/showSnackbar.dart';
import 'package:firebase_first_demo/register_feature/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../login_feature/login_screen.dart';
import '../utils/maps.dart';
import '../utils/validatePhoneNumber.dart';
import '../widget/BottomText.dart';
import '../widget/CreateAcc.dart';
import '../widget/ErroViewField.dart';
import '../widget/FillTitle.dart';
import '../widget/FormWidget.dart';
import '../widget/SignUpText.dart';
import '../widget/TextStylish.dart';
import '../widget/appbardesign.dart';
import '../widget/prefixIconData.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

enum FormFieldKey {
  name,
  email,
  password,
  phone,
  confirm_password,
}

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key, required this.preference});
  SharedPreferences preference;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

Map<String, String> _formData = {};

class _RegisterScreenState extends State<RegisterScreen> {
  bool isTextFieldFocused_nm = false; // Track focused state of TextFormField
  bool isTextFieldFocused_pn = false; // Track focused state of TextFormField
  bool isTextFieldFocused_eml = false; // Track focused state of TextFormField
  bool isTextFieldFocused_pswd = false; // Track focused state of TextFormField
  bool isTextFieldFocused_cnpswd = false;

  final globalkey = GlobalKey<FormState>();
  final _auth = Auth();
  @override
  void initState() {
    super.initState();
    FocusNodesMap.map.forEach((key, value) {
      FocusNodesMap.map[key]!.addListener(_onFocusChanged);
    });
  }

  @override
  void dispose() {
    // Clean up the FocusNode when the widget is disposed
    FocusNodesMap.map.forEach((key, value) {
      FocusNodesMap.map[key]!.removeListener(_onFocusChanged);
      FocusNodesMap.map[key]!.dispose();
    });

    super.dispose();
  }

  String _nameError = '',
      _phoneError = '',
      _emailError = '',
      _pswdError = '',
      _cnfrmError = '';
  void _onFocusChanged() {
    setState(() {
      isTextFieldFocused_nm = FocusNodesMap.map['_focusNode_nm']!.hasFocus;
      isTextFieldFocused_pn = FocusNodesMap.map['_focusNode_pn']!.hasFocus;
      isTextFieldFocused_eml = FocusNodesMap.map['_focusNode_eml']!.hasFocus;
      isTextFieldFocused_pswd = FocusNodesMap.map['_focusNode_pswd']!.hasFocus;
      isTextFieldFocused_cnpswd =
          FocusNodesMap.map['_focusNode_cnpswd']!.hasFocus;
      // Update focused state based on FocusNode
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const AppBarDesign(),
        backgroundColor: const Color(0xFF201a31),
        body: Column(
          children: [
            CreateAccount(title: 'Create Account'),
            fillTitle(title: 'Please fill the input below'),
            SizedBox(
              height: 4.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: globalkey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          nameWidget(),
                          Positioned(
                            bottom: 5,
                            left: 4,
                            child: ErrorVieFieldName(
                              nameError: _nameError,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          phoneWidget(),
                          Positioned(
                            bottom: 5,
                            left: 4,
                            child: ErrorVieFieldName(
                              nameError: _phoneError,
                            ),
                          ),
                        ],
                      ),
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
                      Stack(
                        children: [
                          conformPasswordWidget(),
                          Positioned(
                            bottom: 5,
                            left: 4,
                            child: ErrorVieFieldName(
                              nameError: _cnfrmError,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            sigUpText(
              titletext: 'SignUp',
              click_btn_callback: (context) {
                globalkey.currentState!.save();
                //first save then validate if edit form after submit
                bool containsEmptyValue = _formData.containsValue('');

                if (containsEmptyValue) {
                  ShowSnackBar.showCustomSnackbar(
                      context, 'fill all Field First');
                  return;
                }
                final userphoneno = ValidatePhoneNumber.onPhoneNumberChanged(
                    _formData['PHONE NO']!);

                if (!userphoneno.isRight()) {
                  ShowSnackBar.showCustomSnackbar(
                      context, 'Phone no Not Valid');
                  return;
                }

                var userpasword = _formData['PASSWORD'];
                var cnfpswd = _formData['CONFIRM PASSWORD'];
                var username = _formData['EMAIL'];
                if (userpasword != cnfpswd) {
                  ShowSnackBar.showCustomSnackbar(
                      context, 'password not match with confirm pasword');
                  return;
                }

                registerStarted(username!, userpasword!, context);
                //start registering
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomText(
          title: 'Sign In',
          description: 'Already have an account?',
          callbackAction: () {
            print('click on singin register scren');
          },
        ),
      ),
    );
  }

  void tapOutsidde() {
    setState(() {
      isTextFieldFocused_nm = false;
      isTextFieldFocused_pn = false;

      isTextFieldFocused_eml = false; // Toggle focused state
      isTextFieldFocused_pswd = false; // Toggle focused state
      isTextFieldFocused_cnpswd = false; // Toggle focused state

      // for (var focusNode in FocusNodesMap.focusNodesList) {
      //   focusNode.unfocus();
      // }

      FocusNodesMap.map['_focusNode_nm']!.unfocus(); // Toggle focused state
      FocusNodesMap.map['_focusNode_pn']!.unfocus(); // Toggle focused state

      FocusNodesMap.map['_focusNode_eml']!.unfocus(); // Toggle focused state
      FocusNodesMap.map['_focusNode_pswd']!.unfocus(); // Toggle focused state
      FocusNodesMap.map['_focusNode_cnpswd']!.unfocus();
    });
  }

  void onTextFieldTap(String tapon) {
    // print(tapon);
    setState(() {
      print(" ibtextfield Tap--$tapon");
      TextFieldFocusMap.map.forEach((key, value) {
        TextFieldFocusMap.map[key] = (key == tapon);
      });
    });
  }

  Widget nameWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isTextFieldFocused_nm
            ? const Color(0xFF38304d)
            : const Color(0xFF201a31),
      ),
      width: double.infinity,
      child: TextFormField(
        key: FormKeysMap.map['user_name_key'],
        focusNode: FocusNodesMap.map['_focusNode_nm']!,
        style: stylish,
        controller: TextEditingControllersMap.map['user_name']!,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: PrefixIconData(
                isTextFieldFocused: isTextFieldFocused_nm,
                preIcon: Icons.person),
            hintStyle: const TextStyle(
              color: Color(0xFFf3f3f4),
            ),
            labelText: 'NAME',
            labelStyle:
                TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h)),
        onTap: () {
          onTextFieldTap('NAME');
        },
        onTapOutside: (event) {
          tapOutsidde();
        },
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          _formData['NAME'] = newValue!;
        },
        onChanged: (value) {
          _validateName(FormFieldKey.name, value); // Call validation function
        },
      ),
    );
  }

  void _validateName(FormFieldKey fieldKey, String value) {
    String error = ValidMap.errorMap[fieldKey] ?? '';
    if (value == '') {
      setState(() {
        switch (fieldKey) {
          case FormFieldKey.name:
            _nameError = error;
            break;
          case FormFieldKey.email:
            _emailError = error;
            // Add email validation logic here
            break;
          case FormFieldKey.phone:
            _phoneError = error;
            // Add phone validation logic here
            break;
          case FormFieldKey.password:
            _pswdError = error;
            // Add password validation logic here
            break;
          case FormFieldKey.confirm_password:
            _cnfrmError = error;
            // Add confirm password validation logic here
            break;
        }
      });
    } else {
      setState(() {
        _nameError = '';
        _phoneError = '';
        _emailError = '';
        _pswdError = '';
        _cnfrmError = '';
      });
    }
  }

  Widget phoneWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isTextFieldFocused_pn
            ? const Color(0xFF38304d)
            : const Color(0xFF201a31),
      ),
      width: double.infinity,
      child: TextFormField(
        maxLength: 12,
        keyboardType: TextInputType.number,
        key: FormKeysMap.map['user_phone_key'],
        focusNode: FocusNodesMap.map['_focusNode_pn']!,
        style: stylish,
        controller: TextEditingControllersMap.map['user_phone']!,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: PrefixIconData(
              isTextFieldFocused: isTextFieldFocused_pn, preIcon: Icons.person),
          hintStyle: const TextStyle(
            color: Color(0xFFf3f3f4),
          ),
          labelText: 'PHONE NO',
          labelStyle:
              TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h),
          counterText: '', //overlappin hide after this
        ),
        onTap: () {
          onTextFieldTap('PHONE NO');
        },
        onTapOutside: (event) {
          tapOutsidde();
        },
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          _formData['PHONE NO'] = newValue!;
        },
        onChanged: (value) {
          _validateName(FormFieldKey.phone, value); // Call validation function
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
        color: isTextFieldFocused_eml
            ? const Color(0xFF38304d)
            : const Color(0xFF201a31),
      ),
      width: double.infinity,
      child: TextFormField(
        key: FormKeysMap.map['user_email_key'],
        focusNode: FocusNodesMap.map['_focusNode_eml']!,
        style: stylish,
        controller: TextEditingControllersMap.map['user_email']!,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: PrefixIconData(
                isTextFieldFocused: isTextFieldFocused_eml,
                preIcon: Icons.person),
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
          _formData['EMAIL'] = newValue!;
        },
        onChanged: (value) {
          _validateName(FormFieldKey.email, value); // Call validation function
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
        color: isTextFieldFocused_pswd
            ? const Color(0xFF38304d)
            : const Color(0xFF201a31),
      ),
      width: double.infinity,
      child: TextFormField(
        key: FormKeysMap.map['user_passord_key'],
        focusNode: FocusNodesMap.map['_focusNode_pswd']!,
        style: stylish,
        obscureText: true,
        controller: TextEditingControllersMap.map['user_password']!,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: PrefixIconData(
                isTextFieldFocused: isTextFieldFocused_pswd,
                preIcon: Icons.person),
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
          _formData['PASSWORD'] = newValue!;
        },
        onChanged: (value) {
          _validateName(
              FormFieldKey.password, value); // Call validation function
        },
      ),
    );
  }

  Widget conformPasswordWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isTextFieldFocused_cnpswd
            ? const Color(0xFF38304d)
            : const Color(0xFF201a31),
      ),
      width: double.infinity,
      child: TextFormField(
        key: FormKeysMap.map['cnf_user_password_key'],
        focusNode: FocusNodesMap.map['_focusNode_cnpswd']!,
        style: stylish,
        obscureText: true,
        controller: TextEditingControllersMap.map['cnf_user_password']!,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: PrefixIconData(
                isTextFieldFocused: isTextFieldFocused_cnpswd,
                preIcon: Icons.person),
            hintStyle: const TextStyle(
              color: Color(0xFFf3f3f4),
            ),
            labelText: "CONFIRM PASSWORD",
            labelStyle:
                TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h)),
        onTap: () {
          onTextFieldTap('CONFIRM PASSWORD');
        },
        onTapOutside: (event) {
          tapOutsidde();
        },
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          _formData['CONFIRM PASSWORD'] = newValue!;
        },
        onChanged: (value) {
          _validateName(
              FormFieldKey.confirm_password, value); // Call validation function
        },
      ),
    );
  }

  void registerStarted(
      String username, String password, BuildContext context) async {
    final users =
        await _auth.registerUser(emailAddress: username, password: password);

    users.fold(
        (l) => ShowSnackBar.showCustomSnackbar(
            context, l.toString()), //l denote left erorr
        (r) {
      Navigator.push(
          //r denote succes
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
      //setRegistrationCompleteUsingSecured('ISREGISTER', 'true');

      print(widget.preference.setBool('isRegistered', true));
      // widget.preference.set
    });
  }
}

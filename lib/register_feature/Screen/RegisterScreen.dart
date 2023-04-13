// ignore_for_file: non_constant_identifier_names

import 'package:firebase_first_demo/register_feature/core/Auth.dart';
import 'package:firebase_first_demo/register_feature/core/AuthException.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import '../../login_screen.dart';
import '../utils/maps.dart';
import '../widget/BottomText.dart';
import '../widget/CreateAcc.dart';
import '../widget/ErroViewField.dart';
import '../widget/FillTitle.dart';
import '../widget/FormWidget.dart';
import '../widget/SignUpText.dart';
import '../widget/TextStylish.dart';
import '../widget/appbardesign.dart';
import '../widget/prefixIconData.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

enum FormFieldKey {
  name,
  email,
  password,
  phone,
  confirm_password,

  // Add more form field keys as needed
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

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
  Auth _auth = Auth();
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
            const CreateAccount(),
            const fillTitle(),
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
              click_btn_callback: (context) {
                globalkey.currentState!.save();
                //first save then validate if edit form after submit
                bool containsEmptyValue = _formData.containsValue('');

                //check map has form field null value if any
                if (!containsEmptyValue) {
                  var userpasword = _formData['PASSWORD'];
                  var cnfpswd = _formData['CONFIRM PASSWORD'];
                  var username = _formData['EMAIL'];
                  if (userpasword == cnfpswd) {
                    registerStarted(username!, userpasword!, context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('password not match with confirm pasword')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fill All Field first')));
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: const BottomText(),
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

      FocusNodesMap.map['_focusNode_nm']!.unfocus(); // Toggle focused state
      FocusNodesMap.map['_focusNode_pn']!.unfocus(); // Toggle focused state

      FocusNodesMap.map['_focusNode_eml']!.unfocus(); // Toggle focused state
      FocusNodesMap.map['_focusNode_pswd']!.unfocus(); // Toggle focused state
      FocusNodesMap.map['_focusNode_cnpswd']!.unfocus(); // Toggle focused state
    });
  }

  void onTextFieldTap(String tapon) {
    // print(tapon);
    setState(() {
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
            labelText: "NAME",
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
    //fieledkey male female etc
    switch (fieldKey) {
      case FormFieldKey.name:
        if (value.isEmpty) {
          setState(() {
            _nameError = 'Name Field is requrid';
          });
        } else {
          setState(() {
            _nameError = '';
          });
        }
        break;
      case FormFieldKey.email:
        if (value.isEmpty) {
          setState(() {
            _emailError = 'Email Field is requrid';
          });
        } else {
          setState(() {
            _emailError = '';
          });
        }
        // Add email validation logic here
        break;
      case FormFieldKey.phone:
        if (value.isEmpty) {
          setState(() {
            _phoneError = 'Phone Field is requrid';
          });
        } else {
          setState(() {
            _phoneError = '';
          });
        }
        // Add email validation logic here
        break;
      case FormFieldKey.password:
        if (value.isEmpty) {
          setState(() {
            _pswdError = 'paswd Field is requrid';
          });
        } else {
          setState(() {
            _pswdError = '';
          });
        }
        // Add password validation logic here
        break;
      case FormFieldKey.confirm_password:
        if (value.isEmpty) {
          setState(() {
            _cnfrmError = 'confirmpswd Field is requrid';
          });
        } else {
          setState(() {
            _cnfrmError = '';
          });
        }
        // Add password validation logic here
        break;
      // Add more cases for other form field keys as needed
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
        key: FormKeysMap.map['user_phone_key'],
        focusNode: FocusNodesMap.map['_focusNode_pn']!,
        style: stylish,
        controller: TextEditingControllersMap.map['user_phone']!,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: PrefixIconData(
                isTextFieldFocused: isTextFieldFocused_pn,
                preIcon: Icons.person),
            hintStyle: const TextStyle(
              color: Color(0xFFf3f3f4),
            ),
            labelText: "PHONE NO",
            labelStyle:
                TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h)),
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
            labelText: "EMAIL",
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
            labelText: "PASSWORD",
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
    var users = await _auth
        .registerUser(emailAddress: username, password: password)
        .catchError((error) {
      if (error is AuthException) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
        throw error;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    });
    if (kDebugMode) {
      print(users!.email);
    }
    if (users!.email!.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    }
  }
}

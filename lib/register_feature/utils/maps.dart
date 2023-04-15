import 'package:firebase_first_demo/register_feature/utils/preferences.dart';
import 'package:flutter/material.dart';

import '../Screen/RegisterScreen.dart';

class TextEditingControllersMap {
  static final Map<String, TextEditingController> map = {
    'user_name': TextEditingController(),
    'user_phone': TextEditingController(),
    'user_email': TextEditingController(),
    'user_password': TextEditingController(),
    'cnf_user_password': TextEditingController(),
  };
}

// class FormKeysMap {
//   static final GlobalKey<FormState> userNameKey = GlobalKey<FormState>();
//   static final GlobalKey<FormState> userPhoneKey = GlobalKey<FormState>();
//   static final GlobalKey<FormState> userEmailKey = GlobalKey<FormState>();
//   static final GlobalKey<FormState> userPasswordKey = GlobalKey<FormState>();
//   static final GlobalKey<FormState> cnfUserPasswordKey = GlobalKey<FormState>();
// }
class FormKeysMap {
  static final Map<String, GlobalKey<FormState>> map = {
    'user_name_key': GlobalKey<FormState>(),
    'user_phone_key': GlobalKey<FormState>(),
    'user_email_key': GlobalKey<FormState>(),
    'user_password_key': GlobalKey<FormState>(),
    'cnf_user_password_key': GlobalKey<FormState>(),
  };
}

class FocusNodesMap {
  static final Map<String, FocusNode> map = {
    '_focusNode_nm': FocusNode(),
    '_focusNode_pn': FocusNode(),
    '_focusNode_eml': FocusNode(),
    '_focusNode_pswd': FocusNode(),
    '_focusNode_cnpswd': FocusNode(),
  };

  static List<FocusNode> focusNodesList = [
    FocusNodesMap.map['_focusNode_nm']!,
    FocusNodesMap.map['_focusNode_pn']!,
    FocusNodesMap.map['_focusNode_eml']!,
    FocusNodesMap.map['_focusNode_pswd']!,
    FocusNodesMap.map['_focusNode_cnpswd']!,
  ];
}

class FocusNodeLogin {
  static final Map<String, FocusNode> map = {
    '_focusNode_eml': FocusNode(),
    '_focusNode_pswd': FocusNode(),
  };
}

class TextFieldFocusMap {
  static final Map<String, bool> map = {
    'NAME': false,
    'EMAIL': false,
    'PHONE NO': false,
    'PASSWORD': false,
    'CONFIRM PASSWORD': false,
  };
}

class ValidMap {
  static final Map<FormFieldKey, String> errorMap = {
    FormFieldKey.name: 'Name Field is required',
    FormFieldKey.email: 'Email Field is required',
    FormFieldKey.phone: 'Phone Field is required',
    FormFieldKey.password: 'Password Field is required',
    FormFieldKey.confirm_password: 'Confirm Password Field is required',
    // Add more field keys and error messages as needed
  };
}

Future<bool> _handleCheckStatus(BuildContext context) async {
  bool? isRegistered = await isRegistrationCompleteUsingSecured(
      'ISREGISTER'); // Call checkStatus() and await for the result
  print('ISREGISTER: $isRegistered');
  return isRegistered;
}

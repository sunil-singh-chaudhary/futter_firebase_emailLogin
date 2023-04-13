import 'package:flutter/material.dart';

class TextEditingControllersMap {
  static final Map<String, TextEditingController> map = {
    'user_name': TextEditingController(),
    'user_phone': TextEditingController(),
    'user_email': TextEditingController(),
    'user_password': TextEditingController(),
    'cnf_user_password': TextEditingController(),
  };
}

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

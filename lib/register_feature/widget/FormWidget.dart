// import 'package:firebase_first_demo/register_feature/widget/prefixIconData.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:sizer/sizer.dart';

// import 'ErroViewField.dart';
// import 'TextStylish.dart';

// Map<String, String> formData = {};
// final globalkey = GlobalKey<FormState>();

// enum FormFieldKey {
//   name,
//   email,
//   password,
//   phone,
//   confirm_password,

//   // Add more form field keys as needed
// }

// class FormWidget extends StatefulWidget {
//   const FormWidget({
//     super.key,
//   });

//   @override
//   State<FormWidget> createState() => _FormWidgetState();
// }

// class _FormWidgetState extends State<FormWidget> {
//   bool isTextFieldFocused_nm = false; // Track focused state of TextFormField
//   bool isTextFieldFocused_pn = false; // Track focused state of TextFormField
//   bool isTextFieldFocused_eml = false; // Track focused state of TextFormField
//   bool isTextFieldFocused_pswd = false; // Track focused state of TextFormField
//   bool isTextFieldFocused_cnpswd = false;
//   Map<String, TextEditingController> textEditingControllerMap = {
//     'user_name': TextEditingController(),
//     'user_phone': TextEditingController(),
//     'user_email': TextEditingController(),
//     'user_password': TextEditingController(),
//     'cnf_user_password': TextEditingController(),
//   };
//   Map<String, GlobalKey<FormState>> formKeyMap = {
//     'user_name_key': GlobalKey<FormState>(),
//     'user_phone_key': GlobalKey<FormState>(),
//     'user_email_key': GlobalKey<FormState>(),
//     'user_password_key': GlobalKey<FormState>(),
//     'cnf_user_password_key': GlobalKey<FormState>(),
//   };

//   Map<String, FocusNode?> focuNodeMap = {
//     '_focusNode_nm': FocusNode(),
//     '_focusNode_pn': FocusNode(),
//     '_focusNode_eml': FocusNode(),
//     '_focusNode_pswd': FocusNode(),
//     '_focusNode_cnpswd': FocusNode(),
//   };

// // Track focused state of TextFormField
//   Map<String, bool> textFieldFocusMap = {
//     'NAME': false,
//     'EMAIL': false,
//     'PHONE NO': false,
//     'PASSWORD': false,
//     'CONFIRM PASSWORD': false,
//   };
//   @override
//   void initState() {
//     super.initState();
//     focuNodeMap.forEach((key, value) {
//       focuNodeMap[key]!.addListener(_onFocusChanged);
//     });
//   }

//   @override
//   void dispose() {
//     // Clean up the FocusNode when the widget is disposed
//     focuNodeMap.forEach((key, value) {
//       focuNodeMap[key]!.removeListener(_onFocusChanged);
//       focuNodeMap[key]!.dispose();
//     });

//     super.dispose();
//   }

//   String _nameError = '',
//       _phoneError = '',
//       _emailError = '',
//       _pswdError = '',
//       _cnfrmError = '';

//   void _onFocusChanged() {
//     setState(() {
//       isTextFieldFocused_nm = focuNodeMap['_focusNode_nm']!.hasFocus;
//       isTextFieldFocused_pn = focuNodeMap['_focusNode_pn']!.hasFocus;
//       isTextFieldFocused_eml = focuNodeMap['_focusNode_eml']!.hasFocus;
//       isTextFieldFocused_pswd = focuNodeMap['_focusNode_pswd']!.hasFocus;
//       isTextFieldFocused_cnpswd = focuNodeMap['_focusNode_cnpswd']!.hasFocus;
//       // Update focused state based on FocusNode
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: globalkey,
//       child: Column(
//         children: [
//           nameWidget(),
//           ErrorVieFieldName(
//             nameError: _nameError,
//           ),
//           phoneWidget(),
//           ErrorVieFieldName(
//             nameError: _phoneError,
//           ),
//           emailWidget(),
//           ErrorVieFieldName(
//             nameError: _emailError,
//           ),
//           passwordWidget(),
//           ErrorVieFieldName(
//             nameError: _pswdError,
//           ),
//           conformPasswordWidget(),
//           ErrorVieFieldName(
//             nameError: _cnfrmError,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget nameWidget() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
//       height: 8.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: isTextFieldFocused_nm
//             ? const Color(0xFF38304d)
//             : const Color(0xFF201a31),
//       ),
//       width: double.infinity,
//       child: TextFormField(
//         key: formKeyMap['user_name_key'],
//         focusNode: focuNodeMap['_focusNode_nm']!,
//         style: stylish,
//         controller: textEditingControllerMap['user_name']!,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             prefixIcon: PrefixIconData(
//                 isTextFieldFocused: isTextFieldFocused_nm,
//                 preIcon: Icons.person),
//             hintStyle: const TextStyle(
//               color: Color(0xFFf3f3f4),
//             ),
//             labelText: "NAME",
//             labelStyle:
//                 TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h)),
//         onTap: () {
//           onTextFieldTap('NAME');
//         },
//         onTapOutside: (event) {
//           tapOutsidde();
//         },
//         textInputAction: TextInputAction.next,
//         onSaved: (newValue) {
//           formData['NAME'] = newValue!;
//         },
//         onChanged: (value) {
//           _validateName(FormFieldKey.name, value); // Call validation function
//         },
//       ),
//     );
//   }

//   void _validateName(FormFieldKey fieldKey, String value) {
//     //fieledkey male female etc
//     if (value.isEmpty) {
//       switch (fieldKey) {
//         case FormFieldKey.name:
//           if (value.isEmpty) {
//             setState(() {
//               _nameError = 'Name Field is requrid';
//             });
//           }
//           break;
//         case FormFieldKey.email:
//           if (value.isEmpty) {
//             setState(() {
//               _emailError = 'Email Field is requrid';
//             });
//           }
//           // Add email validation logic here
//           break;
//         case FormFieldKey.phone:
//           if (value.isEmpty) {
//             setState(() {
//               _phoneError = 'Phone Field is requrid';
//             });
//           }
//           // Add email validation logic here
//           break;
//         case FormFieldKey.password:
//           if (value.isEmpty) {
//             setState(() {
//               _pswdError = 'paswd Field is requrid';
//             });
//           }
//           // Add password validation logic here
//           break;
//         case FormFieldKey.confirm_password:
//           if (value.isEmpty) {
//             setState(() {
//               _cnfrmError = 'confirmpswd Field is requrid';
//             });
//           }
//           // Add password validation logic here
//           break;
//         // Add more cases for other form field keys as needed
//       }
//     } else {
//       setState(() {
//         _nameError = '';
//         _emailError = '';
//         _phoneError = '';
//         _pswdError = '';
//         _cnfrmError = '';
//       });
//     }
//   }

//   Widget phoneWidget() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
//       height: 8.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: isTextFieldFocused_pn
//             ? const Color(0xFF38304d)
//             : const Color(0xFF201a31),
//       ),
//       width: double.infinity,
//       child: TextFormField(
//         key: formKeyMap['user_phone_key'],
//         focusNode: focuNodeMap['_focusNode_pn']!,
//         style: stylish,
//         controller: textEditingControllerMap['user_phone']!,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             prefixIcon: PrefixIconData(
//                 isTextFieldFocused: isTextFieldFocused_pn,
//                 preIcon: Icons.person),
//             hintStyle: const TextStyle(
//               color: Color(0xFFf3f3f4),
//             ),
//             labelText: "PHONE NO",
//             labelStyle:
//                 TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h)),
//         onTap: () {
//           onTextFieldTap('PHONE NO');
//         },
//         onTapOutside: (event) {
//           tapOutsidde();
//         },
//         textInputAction: TextInputAction.next,
//         onSaved: (newValue) {
//           formData['PHONE NO'] = newValue!;
//         },
//       ),
//     );
//   }

//   Widget emailWidget() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
//       height: 8.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: isTextFieldFocused_eml
//             ? const Color(0xFF38304d)
//             : const Color(0xFF201a31),
//       ),
//       width: double.infinity,
//       child: TextFormField(
//         key: formKeyMap['user_email_key'],
//         focusNode: focuNodeMap['_focusNode_eml']!,
//         style: stylish,
//         controller: textEditingControllerMap['user_email']!,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             prefixIcon: PrefixIconData(
//                 isTextFieldFocused: isTextFieldFocused_eml,
//                 preIcon: Icons.person),
//             hintStyle: const TextStyle(
//               color: Color(0xFFf3f3f4),
//             ),
//             labelText: "EMAIL",
//             labelStyle:
//                 TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h)),
//         onTap: () {
//           onTextFieldTap('EMAIL');
//         },
//         onTapOutside: (event) {
//           tapOutsidde();
//         },
//         textInputAction: TextInputAction.next,
//         onSaved: (newValue) {
//           formData['EMAIL'] = newValue!;
//         },
//         onChanged: (value) {
//           _validateName(FormFieldKey.email, value); // Call validation function
//         },
//       ),
//     );
//   }

//   Widget passwordWidget() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
//       height: 8.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: isTextFieldFocused_pswd
//             ? const Color(0xFF38304d)
//             : const Color(0xFF201a31),
//       ),
//       width: double.infinity,
//       child: TextFormField(
//         key: formKeyMap['user_passord_key'],
//         focusNode: focuNodeMap['_focusNode_pswd']!,
//         style: stylish,
//         obscureText: true,
//         controller: textEditingControllerMap['user_password']!,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             prefixIcon: PrefixIconData(
//                 isTextFieldFocused: isTextFieldFocused_pswd,
//                 preIcon: Icons.person),
//             hintStyle: const TextStyle(
//               color: Color(0xFFf3f3f4),
//             ),
//             labelText: "PASSWORD",
//             labelStyle:
//                 TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h)),
//         onTap: () {
//           onTextFieldTap('PASSWORD');
//         },
//         onTapOutside: (event) {
//           tapOutsidde();
//         },
//         textInputAction: TextInputAction.next,
//         onSaved: (newValue) {
//           formData['PASSWORD'] = newValue!;
//         },
//         onChanged: (value) {
//           _validateName(
//               FormFieldKey.password, value); // Call validation function
//         },
//       ),
//     );
//   }

//   Widget conformPasswordWidget() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
//       height: 8.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: isTextFieldFocused_cnpswd
//             ? const Color(0xFF38304d)
//             : const Color(0xFF201a31),
//       ),
//       width: double.infinity,
//       child: TextFormField(
//         key: formKeyMap['cnf_user_password_key'],
//         focusNode: focuNodeMap['_focusNode_cnpswd']!,
//         style: stylish,
//         obscureText: true,
//         controller: textEditingControllerMap['cnf_user_password']!,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             prefixIcon: PrefixIconData(
//                 isTextFieldFocused: isTextFieldFocused_cnpswd,
//                 preIcon: Icons.person),
//             hintStyle: const TextStyle(
//               color: Color(0xFFf3f3f4),
//             ),
//             labelText: "CONFIRM PASSWORD",
//             labelStyle:
//                 TextStyle(color: const Color(0xFFf3f3f4), fontSize: 1.8.h)),
//         onTap: () {
//           onTextFieldTap('CONFIRM PASSWORD');
//         },
//         onTapOutside: (event) {
//           tapOutsidde();
//         },
//         textInputAction: TextInputAction.next,
//         onSaved: (newValue) {
//           formData['CONFIRM PASSWORD'] = newValue!;
//         },
//         onChanged: (value) {
//           _validateName(
//               FormFieldKey.confirm_password, value); // Call validation function
//         },
//       ),
//     );
//   }

//   void tapOutsidde() {
//     setState(() {
//       isTextFieldFocused_nm = false;
//       isTextFieldFocused_pn = false;

//       isTextFieldFocused_eml = false; // Toggle focused state
//       isTextFieldFocused_pswd = false; // Toggle focused state
//       isTextFieldFocused_cnpswd = false; // Toggle focused state

//       focuNodeMap['_focusNode_nm']!.unfocus(); // Toggle focused state
//       focuNodeMap['_focusNode_pn']!.unfocus(); // Toggle focused state

//       focuNodeMap['_focusNode_eml']!.unfocus(); // Toggle focused state
//       focuNodeMap['_focusNode_pswd']!.unfocus(); // Toggle focused state
//       focuNodeMap['_focusNode_cnpswd']!.unfocus(); // Toggle focused state
//     });
//   }

//   void onTextFieldTap(String tapon) {
//     // print(tapon);
//     setState(() {
//       textFieldFocusMap.forEach((key, value) {
//         textFieldFocusMap[key] = (key == tapon);
//       });
//     });
//   }
// }

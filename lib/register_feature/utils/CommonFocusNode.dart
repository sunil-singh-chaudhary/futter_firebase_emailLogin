import 'package:flutter/material.dart';

class CommonFocusNode {
  FocusNode? focusNode;
  late bool isFocused;

  CommonFocusNode() {
    focusNode = FocusNode();
    isFocused = false;
    focusNode?.addListener(() {
      // Use null-aware operator
      isFocused = focusNode?.hasFocus ??
          false; // Use null-aware operator and provide a default value
    });
  }

  void requestFocus() {
    focusNode?.requestFocus();
  }

  // bool isfocused() {
  //   return focusNode!.hasFocus();
  // }

  void unfocus() {
    focusNode?.unfocus();
  }

  void disposed() {
    focusNode?.removeListener(() {});
    focusNode?.dispose();
  }
}

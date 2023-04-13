import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PrefixIconData extends StatelessWidget {
  IconData preIcon;
  bool isTextFieldFocused;
  PrefixIconData({
    super.key,
    required this.preIcon,
    required this.isTextFieldFocused,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 5.w,
      height: 8.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            // Use AnimatedPositioned to animate icon's position
            bottom: isTextFieldFocused
                ? 15.0
                : 20.0, // Move icon to bottom when typing
            left: 10.0, // Align icon to the right
            child: Icon(
              preIcon,
              color: Colors.white,
            ), // Icon to be placed as suffix
          ),
        ],
      ),
    );
  }
}

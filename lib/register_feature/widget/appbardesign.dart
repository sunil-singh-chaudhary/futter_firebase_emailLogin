import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class AppBarDesign extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF201a31),
      elevation: 0,
      // leading: IconButton(
      //     onPressed: () {
      //       const BackButton();
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: Color(0xFF919193),
      //     )),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 7.h);
}

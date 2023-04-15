import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class CreateAccount extends StatelessWidget {
  String title;
  CreateAccount({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      width: double.infinity,
      margin: EdgeInsets.only(left: 2.7.h, top: 2.h),
      child: Text(title,
          style: TextStyle(
              color: const Color(0xFFf3f3f4),
              fontSize: 22.sp,
              fontWeight: FontWeight.bold)),
    );
  }
}

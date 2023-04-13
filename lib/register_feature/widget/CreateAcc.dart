import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      width: double.infinity,
      margin: EdgeInsets.only(left: 2.2.h, top: 2.h),
      child: Text('Create Account',
          style: TextStyle(
              color: const Color(0xFFf3f3f4),
              fontSize: 25.sp,
              fontWeight: FontWeight.bold)),
    );
  }
}

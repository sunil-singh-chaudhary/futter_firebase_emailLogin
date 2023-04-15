import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class fillTitle extends StatelessWidget {
  String title;
  fillTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.h,
      width: double.infinity,
      margin: EdgeInsets.only(left: 2.7.h),
      child: Text(title,
          style: TextStyle(
              color: const Color(0xFF777381),
              fontSize: 13.sp,
              fontWeight: FontWeight.normal)),
    );
  }
}

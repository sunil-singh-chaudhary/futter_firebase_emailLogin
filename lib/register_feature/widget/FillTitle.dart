import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class fillTitle extends StatelessWidget {
  const fillTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.h,
      width: double.infinity,
      margin: EdgeInsets.only(left: 2.7.h),
      child: Text('Please fill the input below',
          style: TextStyle(
              color: const Color(0xFF777381),
              fontSize: 13.sp,
              fontWeight: FontWeight.normal)),
    );
  }
}

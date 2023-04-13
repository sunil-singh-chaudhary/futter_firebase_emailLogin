import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class sigUpText extends StatelessWidget {
  Function(BuildContext context) click_btn_callback;
  sigUpText({
    super.key,
    required this.click_btn_callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 17.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.h),
        color: const Color(0xFF0df5e3),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(17.h),
        splashColor: Colors.yellow, // set the color of the splash effect
        highlightColor: Colors.transparent,
        onTap: () {
          click_btn_callback(context);
        },
        child: Center(
            child: Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}

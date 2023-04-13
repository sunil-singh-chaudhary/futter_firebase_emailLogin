import 'package:firebase_first_demo/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 1.h),
      height: 6.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Already have an account?',
            style: TextStyle(color: Color(0xFF78777b), fontSize: 12.sp),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            child: Container(
                padding: EdgeInsets.only(left: 1.w),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                      color: Color(0xFF0df5e3), fontWeight: FontWeight.w800),
                )),
          )
        ],
      ),
    );
  }
}

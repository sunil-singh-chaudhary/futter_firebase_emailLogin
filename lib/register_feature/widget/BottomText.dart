import 'package:firebase_first_demo/login_feature/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class BottomText extends StatelessWidget {
  VoidCallback callbackAction;
  String title;
  String description;
  BottomText(
      {super.key,
      required this.callbackAction,
      required this.title,
      required this.description});

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
            description,
            style: TextStyle(color: const Color(0xFF78777b), fontSize: 12.sp),
          ),
          InkWell(
            onTap: () {
              callbackAction();
            },
            child: Container(
                padding: EdgeInsets.only(left: 1.w),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Color(0xFF0df5e3), fontWeight: FontWeight.w800),
                )),
          )
        ],
      ),
    );
  }
}

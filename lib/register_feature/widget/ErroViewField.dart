import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class ErrorVieFieldName extends StatelessWidget {
  String nameError;
  ErrorVieFieldName({super.key, required this.nameError});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.h,
      margin: EdgeInsets.only(left: 10.w),
      alignment: Alignment.bottomLeft,
      child: Text(
        nameError,
        style: TextStyle(
            color: Colors.red, fontSize: 12.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}

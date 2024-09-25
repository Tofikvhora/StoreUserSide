import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceandstore/Constant/Colors.dart';

class ButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String name;
  const ButtonWidget({super.key, required this.onTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorsOfApp.secondaryColor),
        child: Text(
          name,
          style: TextStyle(
              fontSize: 25.sp,
              color: ColorsOfApp.primaryColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceandstore/Constant/Colors.dart';

class StylesOfApp {
  StylesOfApp._();
  static TextStyle heading = TextStyle(
      fontSize: 25.sp,
      color: ColorsOfApp.textColor,
      fontWeight: FontWeight.bold);
  static TextStyle subheading = TextStyle(
      fontSize: 14.sp,
      color: ColorsOfApp.textColor,
      fontWeight: FontWeight.bold);
  static TextStyle small = TextStyle(
      fontSize: 12.sp,
      color: ColorsOfApp.textColor,
      fontWeight: FontWeight.bold);
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/features/Auth/Login/View/LoginPage.dart';
import 'package:serviceandstore/features/Home/MainPage/View/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("asset/images/50806.jpg"))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Text(
              "Electric Store & \nServices",
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: Text(
              "All Type Of Electrical items And Services are available",
              style: TextStyle(
                  fontSize: 18.sp,
                  color: ColorsOfApp.shadowColor,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () async {
              SharedPreferences sf = await SharedPreferences.getInstance();
              String? data = sf.getString("userdata");
              data == null
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
              height: 60.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorsOfApp.secondaryColor),
              child: Text(
                "Explore now",
                style: TextStyle(
                    fontSize: 25.sp,
                    color: ColorsOfApp.primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
          )
        ],
      ),
    );
  }
}

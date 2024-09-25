import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';

class CardViewWidget extends HookWidget {
  const CardViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return StreamBuilder(
        stream: firestore
            .collection("Admin")
            .doc("Banner-Data")
            .collection("Details")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
                    color: ColorsOfApp.secondaryColor));
          }
          final snapData = snapshot.data!.docs;
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            color: ColorsOfApp.shadowColor,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            elevation: 10,
            shadowColor: ColorsOfApp.textColor,
            borderOnForeground: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            semanticContainer: true,
            child: Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.8,
                      fit: BoxFit.cover,
                      image: NetworkImage(snapData[0]["Banner-image"]))),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                color: ColorsOfApp.primaryColor.withOpacity(0.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 190.w,
                      child: Text(
                        snapData[0]["Banner-heading"].toString(),
                        style: StylesOfApp.heading.copyWith(fontSize: 22.sp),
                      ),
                    ),
                    Text(
                      snapData[0]["Banner-subheading"],
                      style: StylesOfApp.subheading.copyWith(
                          color: ColorsOfApp.textColor, fontSize: 19.sp),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

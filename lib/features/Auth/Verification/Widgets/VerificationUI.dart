import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/features/Auth/Verification/Controller/VerificationController.dart';

class VerificationUI extends StatelessWidget {
  const VerificationUI({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<VerificationController>(context);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          ),
          elevation: 10,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Image.asset(
                "asset/images/50806.jpg",
                height: MediaQuery.of(context).size.height * 0.6,
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 80.h,
        ),
        Text("We have Sent you verification link please check your email box!",
            textAlign: TextAlign.center, style: StylesOfApp.heading),
      ],
    );
  }
}

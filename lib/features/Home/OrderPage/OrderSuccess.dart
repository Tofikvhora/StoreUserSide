import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/View/NavBar.dart';
import 'package:serviceandstore/Widgets/ButtonWidget.dart';

class OrderSuccess extends HookWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text("Order Successfully placed",
                    style: StylesOfApp.heading)),
            Center(
                child: Text(
                    "You can check out your order in Profile > My Order page",
                    style: StylesOfApp.subheading.copyWith(
                        color: ColorsOfApp.textColor.withOpacity(0.5)))),
            SizedBox(
              height: 20.h,
            ),
            ButtonWidget(
                onTap: () async {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(auth.currentUser!.email)
                      .collection("Cart-data")
                      .get()
                      .then((snapshot) {
                    for (DocumentSnapshot doc in snapshot.docs) {
                      doc.reference.delete();
                    }
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavBarView()));
                },
                name: "Home Page"),
          ],
        ),
      ),
    );
  }
}

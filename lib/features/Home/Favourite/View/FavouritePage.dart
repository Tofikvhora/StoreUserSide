import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/features/Home/DetailsPage/View/DetailsPage.dart';

class FavouritePage extends HookWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore fs = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: Animate(
        effects: const [
          FadeEffect(
              duration: Duration(milliseconds: 500), curve: Curves.easeIn),
          MoveEffect(
              duration: Duration(milliseconds: 600), curve: Curves.easeIn),
        ],
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          children: [
            SafeArea(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "You're favorite products",
                  style: StylesOfApp.heading,
                ),
                Icon(
                  IconlyLight.notification,
                  color: ColorsOfApp.textColor,
                  size: 30.h,
                ),
              ],
            )),
            SizedBox(height: 10.h),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(auth.currentUser!.email.toString())
                    .collection("FavData")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorsOfApp.secondaryColor,
                      ),
                    );
                  }
                  final snapData = snapshot.data!.docs;
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: snapData.isEmpty
                        ? Center(
                            child: Text(
                            "Select Products",
                            style: StylesOfApp.heading
                                .copyWith(color: ColorsOfApp.textColor),
                          ))
                        : GridView.builder(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.7,
                                    mainAxisSpacing: 10.h,
                                    crossAxisSpacing: 10.w),
                            itemCount: snapData.length,
                            itemBuilder: (context, index) {
                              final data = snapData[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsPage(data: data)));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: ColorsOfApp.shadowColor,
                                            offset: Offset(0.5, 1),
                                            blurStyle: BlurStyle.outer,
                                            spreadRadius: 4,
                                            blurRadius: 4)
                                      ]),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15)),
                                          child: Image.network(
                                            data["Multi-Images"]["Images"][0],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "\$ ${data["Product-Price"]}",
                                                style: StylesOfApp.heading
                                                    .copyWith(fontSize: 18.sp),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data["Product-Name"],
                                                    style: StylesOfApp
                                                        .subheading
                                                        .copyWith(
                                                            fontSize: 15.sp),
                                                  ),
                                                  Text(
                                                    data["Category-Name"],
                                                    style: StylesOfApp.small
                                                        .copyWith(
                                                            color: ColorsOfApp
                                                                .textColor
                                                                .withOpacity(
                                                                    0.5)),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await FirebaseFirestore.instance
                                                  .runTransaction((Transaction
                                                      myTransaction) async {
                                                myTransaction.delete(snapshot
                                                    .data!
                                                    .docs[index]
                                                    .reference);
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.delete,
                                                size: 25.w,
                                                color: ColorsOfApp.textColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

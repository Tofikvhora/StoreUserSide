import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/features/Home/DetailsPage/View/DetailsPage.dart';
import 'package:serviceandstore/features/Home/MainPage/Controller/HomePageController.dart';

class TabBarPage extends HookWidget {
  final TextEditingController textEditingController;
  const TabBarPage({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<HomePageController>(context);
    FirebaseFirestore fs = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Admin")
              .doc("Product-data")
              .collection("details")
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
            return notifier.filterData.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.58,
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            height: MediaQuery.of(context).size.height * 0.1,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              style: StylesOfApp.subheading
                                                  .copyWith(fontSize: 15.sp),
                                            ),
                                            Text(
                                              data["Category-Name"],
                                              style: StylesOfApp.small.copyWith(
                                                  color: ColorsOfApp.textColor
                                                      .withOpacity(0.5)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                            onTap: () {
                                              notifier.addToFav(data);
                                            },
                                            child: Icon(
                                              IconlyLight.heart,
                                              color: Colors.black,
                                              size: 25.h,
                                            ))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w),
                    itemCount: notifier.filterData.length,
                    itemBuilder: (context, index) {
                      final data = notifier.filterData[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPage(data: data)));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
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
                                    notifier.filterData[index]["Multi-Images"]
                                        ["Images"][0],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 5.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "\$ ${notifier.filterData[index]["Product-Price"]}",
                                          style: StylesOfApp.heading
                                              .copyWith(fontSize: 18.sp),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notifier.filterData[index]
                                                  ["Product-Name"],
                                              style: StylesOfApp.subheading
                                                  .copyWith(fontSize: 15.sp),
                                            ),
                                            Text(
                                              notifier.filterData[index]
                                                  ["Category-Name"],
                                              style: StylesOfApp.small.copyWith(
                                                  color: ColorsOfApp.textColor
                                                      .withOpacity(0.5)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        notifier.addToFav(data);
                                      },
                                      child: Icon(
                                        IconlyLight.heart,
                                        color: Colors.black,
                                        size: 25.h,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
            ;
          }),
    );
  }
}

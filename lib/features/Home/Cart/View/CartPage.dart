import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/Widgets/ButtonWidget.dart';
import 'package:serviceandstore/features/Home/Address/View/AddressPage.dart';
import 'package:serviceandstore/features/Home/Cart/Controller/CartNotifier.dart';
import 'package:serviceandstore/features/Home/Paymnet/View/PaymentPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<CartNotifier>(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore fs = FirebaseFirestore.instance;
    final currentQty = useState(0);
    final price = useState(0);
    final totalPrice = useState(0);
    final newPrice = useState(0);
    var data;
    useEffect(() {
      notifier.totalP();
      return () {
        notifier.totalPrice = 0;
      };
    }, []);
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(auth.currentUser!.email.toString())
              .collection("Cart-data")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: ColorsOfApp.secondaryColor));
            }
            final snapData = snapshot.data!.docs;
            return Animate(
              effects: const [
                FadeEffect(duration: Duration(seconds: 1)),
                MoveEffect(duration: Duration(seconds: 1), curve: Curves.easeIn)
              ],
              child: snapData.isEmpty
                  ? Center(
                      child: Text("Shopping Cart is Empty",
                          style: StylesOfApp.heading))
                  : ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      children: [
                        SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Shopping Bag",
                                      style: StylesOfApp.heading),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(snapData.length.toString(),
                                      style: StylesOfApp.subheading.copyWith(
                                          color: ColorsOfApp.textColor
                                              .withOpacity(0.5),
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              InkWell(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection("Cart-data")
                                        .get()
                                        .then((snapshot) {
                                      for (DocumentSnapshot ds
                                          in snapshot.docs) {
                                        ds.reference.delete();
                                      }
                                      ;
                                    });
                                  },
                                  child: Text("Remove All",
                                      style: StylesOfApp.subheading)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            itemCount: snapData.length,
                            itemBuilder: (context, index) {
                              data = snapData[index];
                              return Card(
                                elevation: 10,
                                color: ColorsOfApp.primaryColor,
                                semanticContainer: true,
                                shadowColor: ColorsOfApp.shadowColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              snapData[index]["Multi-Images"]
                                                  ["Images"][0],
                                              width: 110.w,
                                              height: 150.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                snapData[index]["Product-Name"],
                                                style: StylesOfApp.heading
                                                    .copyWith(fontSize: 15.sp),
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                snapData[index]
                                                    ["Category-Name"],
                                                style: StylesOfApp.heading
                                                    .copyWith(fontSize: 15.sp),
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                snapData[index]["Company-Name"],
                                                style: StylesOfApp.heading
                                                    .copyWith(fontSize: 15.sp),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2.w,
                                                            vertical: 10.h),
                                                    width: 30.w,
                                                    height: 30.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: ColorsOfApp
                                                            .shadowColor),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (snapData[index]
                                                                ["Quantity"] ==
                                                            1) {
                                                        } else {
                                                          currentQty.value =
                                                              snapData[index]
                                                                  ["Quantity"];
                                                          price.value = int
                                                              .parse(snapData[
                                                                      index][
                                                                  "init-Price"]);
                                                          currentQty.value--;
                                                          int newPrice = price
                                                                  .value *
                                                              currentQty.value;
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Users")
                                                              .doc(auth
                                                                  .currentUser!
                                                                  .email
                                                                  .toString())
                                                              .collection(
                                                                  "Cart-data")
                                                              .doc(snapData[
                                                                  index]["id"])
                                                              .update({
                                                            "Quantity":
                                                                currentQty
                                                                    .value,
                                                            "Product-Price":
                                                                newPrice
                                                                    .toString(),
                                                            "Total": snapData[
                                                                        index][
                                                                    "Product-Price"]
                                                                .toString()
                                                          }).then((value) {
                                                            currentQty.value =
                                                                1;
                                                            price.value = 0;
                                                            notifier
                                                                .removeTotalP();
                                                            notifier
                                                                .totalPrice = 0;
                                                            // notifier.clearAdd();
                                                          });
                                                        }
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        size: 25.w,
                                                        color: ColorsOfApp
                                                            .textColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2.w,
                                                              vertical: 10.h),
                                                      width: 30.w,
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: ColorsOfApp
                                                              .shadowColor),
                                                      child: Text(
                                                        snapData[index]
                                                                ["Quantity"]
                                                            .toString(),
                                                        style: StylesOfApp
                                                            .subheading,
                                                      )),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2.w,
                                                            vertical: 10.h),
                                                    width: 30.w,
                                                    height: 30.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: ColorsOfApp
                                                            .shadowColor),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        currentQty.value =
                                                            snapData[index]
                                                                ["Quantity"];
                                                        price.value = int.parse(
                                                            snapData[index]
                                                                ["init-Price"]);
                                                        currentQty.value++;
                                                        newPrice.value = price
                                                                .value *
                                                            currentQty.value;
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(auth
                                                                .currentUser!
                                                                .email
                                                                .toString())
                                                            .collection(
                                                                "Cart-data")
                                                            .doc(snapData[index]
                                                                ["id"])
                                                            .update({
                                                          "Quantity":
                                                              currentQty.value,
                                                          "Product-Price":
                                                              newPrice.value
                                                                  .toString(),
                                                          "Total": snapData[
                                                                      index][
                                                                  "Product-Price"]
                                                              .toString()
                                                        }).then((value) {
                                                          currentQty.value = 0;
                                                          price.value = 0;
                                                          notifier.totalP();
                                                          notifier.totalPrice =
                                                              0;
                                                          // notifier.clearAdd();
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 25.w,
                                                        color: ColorsOfApp
                                                            .textColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .runTransaction((Transaction
                                                          myTransaction) async {
                                                    myTransaction.delete(
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                            .reference);
                                                  }).then((value) {
                                                    notifier.removeTotalP();
                                                    notifier.totalPrice = 0;
                                                  });
                                                },
                                                child: Text(
                                                  "Remove",
                                                  style: StylesOfApp.subheading,
                                                ),
                                              ),
                                              SizedBox(height: 10.h),
                                              Text("\$ 249",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color: ColorsOfApp
                                                          .shadowColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .lineThrough)),
                                              Text(
                                                "\$ ${snapData[index]["Product-Price"]}",
                                                style: StylesOfApp.heading
                                                    .copyWith(fontSize: 15.sp),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(
                          color: ColorsOfApp.textColor,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Dummy Data (2)",
                              style: StylesOfApp.subheading.copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            Text("\$ ${notifier.totalPrice.abs()}",
                                style: StylesOfApp.subheading.copyWith(
                                    color: ColorsOfApp.textColor
                                        .withOpacity(0.5))),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Delivery Charges",
                              style: StylesOfApp.subheading.copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\$ 10",
                              style: StylesOfApp.subheading
                                  .copyWith(fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: StylesOfApp.heading,
                            ),
                            Text("\$ ${notifier.totalPrice.abs()}",
                                style: StylesOfApp.heading),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("User")
                                .doc(auth.currentUser!.email)
                                .collection("User-address")
                                .snapshots(),
                            builder: (context, snap) {
                              return ButtonWidget(
                                  onTap: () async {
                                    SharedPreferences sf =
                                        await SharedPreferences.getInstance();
                                    String? address =
                                        sf.get("address").toString();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => address == ""
                                                ? const AddressPage()
                                                : PaymentPage(
                                                    data: data,
                                                    total: notifier.totalPrice
                                                        .abs(),
                                                  )));
                                  },
                                  name: "Buy Now");
                            }),
                        SizedBox(height: 20.h),
                        Text(
                          textAlign: TextAlign.center,
                          "Confirm Order And Checkout For Delivery And Payment Proccess",
                          style: StylesOfApp.subheading,
                        )
                      ],
                    ),
            );
          }),
    );
  }
}

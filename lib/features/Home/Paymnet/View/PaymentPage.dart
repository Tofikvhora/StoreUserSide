import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/Widgets/ButtonWidget.dart';
import 'package:serviceandstore/features/Home/Paymnet/Controller/PaymentController.dart';

class PaymentPage extends HookWidget {
  final data;
  final int total;
  const PaymentPage({super.key, required this.data, required this.total});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PaymentMethod>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
              child: Text(
                "Payment",
                style: StylesOfApp.heading,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Image.network(data["Multi-Images"]["Images"][0]),
            // SizedBox(
            //   height: 20.h,
            // ),
            // Text("Product Name is : ${data["Product-Name"]}"),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10.h),
            //   child: Text("Product Company is : ${data["Company-Name"]}"),
            // ),
            // Text("Product Category is : ${data["Category-Name"]}"),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10.h),
            //   child: Text("Product Details : ${data["Details-Name"]}"),
            // ),
            Text(
              "Total Amount is  : \$ $total",
              style: StylesOfApp.heading,
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                "Please Verify Details Then Pay bill",
                style: StylesOfApp.subheading
                    .copyWith(color: ColorsOfApp.textColor.withOpacity(0.5)),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ButtonWidget(
                onTap: () {
                  notifier.payToOrder(context, data, total);
                },
                name: "Pay Now")
          ],
        ),
      ),
    );
  }
}

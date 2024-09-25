import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../Utils/ToastUtils.dart';

class CartController extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addDataToCart(var data) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(auth.currentUser!.email.toString())
        .collection("Cart-data")
        .doc();
    await docRef.set({
      "id": "",
      "Multi-Images": {"Images": data["Multi-Images"]["Images"]},
      "Product-Name": data["Product-Name"],
      "Product-Price": data["Product-Price"],
      "init-Price": data["Product-Price"],
      "Category-Name": data["Category-Name"],
      "Company-Name": data["Company-Name"],
      "Colors-Names": {"Colors": data["Colors-Names"]},
      "Details-Name": data["Details-Name"],
      "Quantity": 1,
      "Total": ""
    }).then((value) async {
      await docRef.update({
        "id": docRef.id,
      });
      ToastUtils().showToastMethod("Added To cart");
      notifyListeners();
    });
  }

  // void addPrice(var data) async {
  //   DocumentReference docRef = FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(auth.currentUser!.email.toString())
  //       .collection("Cart-price")
  //       .doc();
  //   await docRef
  //       .set({"id": "", "price": data["Product-Price"]}).then((value) async {
  //     await docRef.update({
  //       "id": docRef.id,
  //     });
  //   });
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CartNotifier extends ChangeNotifier {
  int add = 1;
  int qtyValue = 0;
  int price = 0;
  int newPrice = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  int totalPrice = 0;

  void totalP() async {
    QuerySnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(auth.currentUser!.email)
        .collection("Cart-data")
        .get();

    for (var data in documentSnapshot.docs) {
      int total = int.parse(data["Product-Price"]);
      print(total.toString());
      totalPrice += total;
      notifyListeners();
    }
    notifyListeners();
  }

  void removeTotalP() async {
    QuerySnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(auth.currentUser!.email)
        .collection("Cart-data")
        .get();

    for (var data in documentSnapshot.docs) {
      int total = int.parse(data["Product-Price"]);
      print(total.toString());
      totalPrice = totalPrice - total;
      notifyListeners();
    }
    notifyListeners();
  }

  void addPlus() {
    add++;
    notifyListeners();
  }

  void clearAdd() {
    add = 0;
    price = 0;
    newPrice = 0;
    notifyListeners();
  }

  void removePlus() {
    if (add <= 1) {
    } else {
      add--;
    }

    notifyListeners();
  }
}

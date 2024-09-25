import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:serviceandstore/Utils/ToastUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  List<String> currentId = [];
  List<dynamic> filterData = [];

  void searchOnChange(String query) async {
    final data = await FirebaseFirestore.instance
        .collection("Admin")
        .doc("Product-data")
        .collection("details")
        .get();
    final showData = [];
    if (textEditingController.text.isNotEmpty) {
      for (var inData in data.docs) {
        final name = inData["Category-Name"].toString().toLowerCase();
        if (name.contains(query.toLowerCase())) {
          showData.add(inData);
          notifyListeners();
        }
      }
    }
    filterData = showData;
    if (textEditingController.text.isEmpty) {
      filterData.clear();
      notifyListeners();
    } else {}
    notifyListeners();
  }

  Future<void> addToFav(
    var data,
  ) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    final userId = user!.uid;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(auth.currentUser!.email.toString())
        .collection("FavData")
        .doc()
        .set({
      "Multi-Images": {"Images": data["Multi-Images"]["Images"]},
      "Product-Name": data["Product-Name"],
      "Product-Price": data["Product-Price"],
      "Category-Name": data["Category-Name"],
      "Company-Name": data["Company-Name"],
      "Colors-Names": {"Colors": data["Colors-Names"]},
      "Details-Name": data["Details-Name"],
      "Quantity": data["Quantity"],
      "Added": true,
    }).then((value) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      ToastUtils().showToastMethod("Added To Favorite");
      notifyListeners();
    });
  }
}

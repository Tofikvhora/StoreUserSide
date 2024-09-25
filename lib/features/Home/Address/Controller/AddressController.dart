import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:serviceandstore/Utils/ToastUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends ChangeNotifier {
  String currentAddressOfUser = "";
  TextEditingController street = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  void getUserLocation() async {
    try {
      final status = await Permission.location.request();
      if (status.isDenied) {
        print("status is denied");
      } else {
        var position = await GeolocatorPlatform.instance.getCurrentPosition(
            locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.high,
                distanceFilter: 10,
                timeLimit: Duration(seconds: 5)));
        _getAddressFromLatLng(position);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getAddressFromLatLng(var currentPosition) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(52.2165157, 6.9437819);
      await placemarkFromCoordinates(
              currentPosition.latitude, currentPosition.longitude)
          .catchError((er) {
        print(er.toString());
      }).then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        currentAddressOfUser =
            '${place.street},${place.locality}, ${place.thoroughfare},${place.administrativeArea},${place.country} ${place.postalCode}';
        print(currentAddressOfUser);
        notifyListeners();
      }).catchError((e) {
        debugPrint(e);
      });
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> addData(bool isWrong) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (isWrong == false) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(auth.currentUser!.email)
          .collection("User-address")
          .doc()
          .set({"address": currentAddressOfUser}).then((value) async {
        SharedPreferences sf = await SharedPreferences.getInstance();
        sf.setString("address", currentAddressOfUser);
        ToastUtils().showToastMethod("Address Saved");
      });
    } else {
      if (street.text.isEmpty &&
          city.text.isEmpty &&
          country.text.isEmpty &&
          area.text.isEmpty) {
        ToastUtils().showToastMethod("Please Add All Fields To Save Address");
      } else {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(auth.currentUser!.email)
            .collection("User-address")
            .doc()
            .set({
          "address": "${street.text},${area.text},${city.text},${country.text}"
        }).then((value) async {
          SharedPreferences sf = await SharedPreferences.getInstance();
          sf.setString("address", street.text);
          ToastUtils().showToastMethod("Address Saved");
        });
      }
    }
  }
}

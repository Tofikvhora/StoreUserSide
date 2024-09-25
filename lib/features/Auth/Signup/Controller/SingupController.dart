import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serviceandstore/Utils/ToastUtils.dart';
import 'package:serviceandstore/features/Auth/Verification/View/VerificationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignUpController {
  void signUpMethod(TextEditingController email, TextEditingController password,
      BuildContext context) async {}
}

class SignUpFunction extends SignUpController with ChangeNotifier {
  bool _loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool get loading => _loading;
  @override
  void signUpMethod(TextEditingController email, TextEditingController password,
      BuildContext context) async {
    try {
      _loading = true;
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) async {
        SharedPreferences sf = await SharedPreferences.getInstance();
        _loading = false;
        await sf.setString("userdata", email.text).then((value) =>
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VerificationPage())));

        notifyListeners();
      });
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _loading = false;
      ToastUtils().showToastMethod(e.message.toString());
      notifyListeners();
    }
    notifyListeners();
  }
}

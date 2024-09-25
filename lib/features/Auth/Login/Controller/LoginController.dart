import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:serviceandstore/Utils/ToastUtils.dart';
import 'package:serviceandstore/View/NavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginController {
  Future<void> login(TextEditingController email,
      TextEditingController password, bool loading, BuildContext context);
}

class LoginFunction extends LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<void> login(
      TextEditingController email,
      TextEditingController password,
      bool loading,
      BuildContext context) async {
    SharedPreferences _sf = await SharedPreferences.getInstance();
    try {
      loading = true;
      await _auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) async {
        loading = false;
        await _sf.setString("userdata", email.text);
        ToastUtils().showToastMethod("Login Successfully");
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => const NavBarView()));
      });
    } on FirebaseAuthException catch (e) {
      loading = false;
      ToastUtils().showToastMethod(e.message.toString());
      await _sf.clear();
    }
  }
}

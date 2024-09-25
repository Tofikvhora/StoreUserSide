import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:serviceandstore/Utils/ToastUtils.dart';
import 'package:serviceandstore/View/NavBar.dart';
import 'package:serviceandstore/features/Auth/Verification/Controller/VerificationController.dart';
import 'package:serviceandstore/features/Auth/Verification/Widgets/VerificationUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationPage extends HookWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    VerificationController verificationController = VerificationController();
    final timer = useState<Timer?>(null);
    useEffect(() {
      verificationController.emailVerification();
      timer.value = Timer.periodic(const Duration(seconds: 30), (timer) async {
        await FirebaseAuth.instance.currentUser!.reload();
        if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => const NavBarView()));
          ToastUtils().showToastMethod("Register Successfully 🎊 ");
          timer.cancel();
        } else {
          SharedPreferences sf = await SharedPreferences.getInstance();
          sf.clear();
          await FirebaseAuth.instance.currentUser!.delete();
          ToastUtils().showToastMethod("email verification Timeout try again");
          timer.cancel();
        }
      });
      return () async {
        timer.value!.cancel();
        SharedPreferences sf = await SharedPreferences.getInstance();
        sf.clear();
      };
    }, []);
    return const Scaffold(
      body: VerificationUI(),
    );
  }
}

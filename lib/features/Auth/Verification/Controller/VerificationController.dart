import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> emailVerification() async {
    await _auth.currentUser!.sendEmailVerification();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:serviceandstore/features/Auth/Signup/Widget/SignupUI.dart';

class SignupPage extends HookWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignupUi());
  }
}

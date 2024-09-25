import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/Widgets/ButtonWidget.dart';
import 'package:serviceandstore/features/Auth/Signup/Controller/SingupController.dart';

class SignupUi extends HookWidget {
  const SignupUi({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<SignUpFunction>(context);
    final email = useTextEditingController();
    final password = useTextEditingController();
    final name = useTextEditingController();
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          ),
          elevation: 10,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Image.asset("asset/images/50806.jpg")),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SignUp",
                style: StylesOfApp.heading,
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: name,
                style: StylesOfApp.subheading,
                onChanged: (value) {},
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: ColorsOfApp.textColor,
                  ),
                  hintText: "Enter Your Name",
                  hintStyle:
                      StylesOfApp.subheading.copyWith(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: email,
                style: StylesOfApp.subheading,
                onChanged: (value) {},
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: ColorsOfApp.textColor,
                  ),
                  hintText: "Enter Your Email",
                  hintStyle:
                      StylesOfApp.subheading.copyWith(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: password,
                style: StylesOfApp.subheading,
                onChanged: (value) {},
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.password,
                    color: ColorsOfApp.textColor,
                  ),
                  hintStyle:
                      StylesOfApp.subheading.copyWith(color: Colors.grey),
                  hintText: "Enter Your Password",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(height: 15.h),
              notifier.loading == true
                  ? const CircularProgressIndicator(
                      color: ColorsOfApp.secondaryColor)
                  : ButtonWidget(
                      onTap: () {
                        SignUpFunction().signUpMethod(email, password, context);
                      },
                      name: "Signup"),
              Divider(
                height: 50.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Now? Login",
                    style: StylesOfApp.subheading.copyWith(
                        fontSize: 15.sp,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/Widgets/ButtonWidget.dart';
import 'package:serviceandstore/features/Auth/Login/Controller/LoginController.dart';
import 'package:serviceandstore/features/Auth/Signup/View/SignupPage.dart';

class LoginUI extends HookWidget {
  const LoginUI({super.key});

  @override
  Widget build(BuildContext context) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final isLoading = useState(false);
    LoginFunction login = LoginFunction();
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
                "Login",
                style: StylesOfApp.heading,
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
                  hintText: "Enter Your Password",
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
              SizedBox(height: 15.h),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "Forgot Password?",
                    textAlign: TextAlign.end,
                    style: StylesOfApp.subheading
                        .copyWith(color: ColorsOfApp.secondaryColor),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              isLoading.value == false
                  ? ButtonWidget(
                      onTap: () {
                        login.login(email, password, isLoading.value, context);
                      },
                      name: "Login")
                  : const CircularProgressIndicator(
                      color: ColorsOfApp.textColor),
              Divider(
                height: 50.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()));
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Already Have An Account? SignUp",
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

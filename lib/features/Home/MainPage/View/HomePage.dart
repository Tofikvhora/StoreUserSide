import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/features/Home/MainPage/Controller/HomePageController.dart';
import 'package:serviceandstore/features/Home/MainPage/Widgets/CardView.dart';
import 'package:serviceandstore/features/Home/MainPage/Widgets/Pages/TabBarPage.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<HomePageController>(context);
    final catList = useState([]);
    final contactList = useState([]);
    final searchCon = useTextEditingController();
    return DefaultTabController(
      length: catList.value.length,
      child: Scaffold(
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          children: [
            SafeArea(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "You're Store",
                  style: StylesOfApp.heading,
                ),
                Icon(
                  IconlyLight.notification,
                  color: ColorsOfApp.textColor,
                  size: 30.h,
                ),
              ],
            )),
            SizedBox(height: 10.h),
            TextField(
              controller: notifier.textEditingController,
              onChanged: (value) {
                notifier.searchOnChange(value);
                print(notifier.filterData);
              },
              style: StylesOfApp.heading.copyWith(fontSize: 18.sp),
              keyboardType: TextInputType.text,
              cursorOpacityAnimates: true,
              cursorColor: ColorsOfApp.textColor,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  IconlyLight.search,
                  size: 25.h,
                  color: ColorsOfApp.textColor,
                ),
                hintText: "Search Items by Category name ex : fan led ",
                hintStyle: StylesOfApp.subheading.copyWith(
                    fontSize: 13.sp,
                    color: ColorsOfApp.textColor.withOpacity(0.5)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedErrorBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                errorBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 10.h),
            Animate(
              effects: const [
                SlideEffect(
                    duration: Duration(milliseconds: 900),
                    curve: Curves.easeIn),
                FadeEffect(
                  begin: 0,
                  end: 1,
                  curve: Curves.easeIn,
                )
              ],
              child: const CardViewWidget(),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Animate(
                effects: const [
                  SlideEffect(
                      duration: Duration(milliseconds: 800),
                      end: Offset(0, 0),
                      begin: Offset(-1, 0)),
                  FadeEffect(begin: 0, end: 1, curve: Curves.ease)
                ],
                child: TabBarPage(
                  textEditingController: searchCon,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

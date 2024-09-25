import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/Widgets/ButtonWidget.dart';
import 'package:serviceandstore/features/Home/Address/Controller/AddressController.dart';

class AddressPage extends HookWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<AddressController>(context);
    final isWrong = useState(false);
    useEffect(() {
      notifier.getUserLocation();
    }, []);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        children: [
          SafeArea(
              child:
                  Text("You're Current address", style: StylesOfApp.heading)),
          isWrong.value == true
              ? const SizedBox()
              : Text(
                  notifier.currentAddressOfUser.toString(),
                  style: StylesOfApp.subheading
                      .copyWith(color: ColorsOfApp.textColor.withOpacity(0.5)),
                ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("If its Wrong add manually",
                  style: StylesOfApp.heading.copyWith(
                      color: ColorsOfApp.textColor.withOpacity(0.7),
                      fontSize: 19.sp)),
              Switch.adaptive(
                inactiveTrackColor: ColorsOfApp.shadowColor,
                inactiveThumbColor: ColorsOfApp.textColor,
                autofocus: false,
                trackOutlineColor:
                    const WidgetStatePropertyAll(Colors.transparent),
                value: isWrong.value,
                onChanged: (value) {
                  isWrong.value = value;
                },
                activeColor: ColorsOfApp.secondaryColor,
              )
            ],
          ),
          SizedBox(height: 10.h),
          Opacity(
            opacity: isWrong.value == false ? 0.2 : 1,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: notifier.street,
                        readOnly: isWrong.value == false ? true : false,
                        decoration: InputDecoration(
                          hintText: "Street road",
                          hintStyle: StylesOfApp.subheading.copyWith(
                              fontSize: 15.sp,
                              color: ColorsOfApp.textColor.withOpacity(0.5)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: notifier.area,
                        readOnly: isWrong.value == false ? true : false,
                        decoration: InputDecoration(
                          hintStyle: StylesOfApp.subheading.copyWith(
                              fontSize: 15.sp,
                              color: ColorsOfApp.textColor.withOpacity(0.5)),
                          hintText: "Area name",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                TextField(
                  controller: notifier.city,
                  readOnly: isWrong.value == false ? true : false,
                  decoration: InputDecoration(
                    hintText: "City name",
                    hintStyle: StylesOfApp.subheading.copyWith(
                        fontSize: 15.sp,
                        color: ColorsOfApp.textColor.withOpacity(0.5)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  controller: notifier.country,
                  readOnly: isWrong.value == false ? true : false,
                  decoration: InputDecoration(
                    hintStyle: StylesOfApp.subheading.copyWith(
                        fontSize: 15.sp,
                        color: ColorsOfApp.textColor.withOpacity(0.5)),
                    hintText: "Country name with postalCode",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
          ButtonWidget(
              onTap: () {
                notifier.addData(isWrong.value);
              },
              name: "Save Address")
        ],
      ),
    );
  }
}

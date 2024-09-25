import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/Constant/Styles.dart';
import 'package:serviceandstore/Widgets/ButtonWidget.dart';
import 'package:serviceandstore/features/ArView/View/ARImageView.dart';
import 'package:serviceandstore/features/Home/DetailsPage/Controller/CartController.dart';

class DetailsPage extends HookWidget {
  final data;
  const DetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<CartController>(context);
    final imageList = useState([]);
    final imageIndex = useState(0);
    final colorIndex = useState(0);
    final colorList = useState([]);
    useEffect(() {
      for (String image in data["Multi-Images"]["Images"]) {
        imageList.value.addAll([image]);
      }
      for (String image in data["Colors-Names"]["Colors"]) {
        colorList.value.addAll([image]);
      }
      return () {
        imageList.value.clear();
      };
    }, []);
    return Scaffold(
      body: Animate(
        effects: const [
          FadeEffect(duration: Duration(seconds: 1)),
          MoveEffect(duration: Duration(seconds: 1), curve: Curves.easeIn)
        ],
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.zero,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(data["Multi-Images"]["Images"]
                                [imageIndex.value])),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 5.h),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(IconlyLight.arrow_left,
                                      size: 25.w,
                                      color: ColorsOfApp.textColor)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageList.value.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            imageIndex.value = index;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: imageIndex.value == index
                                        ? ColorsOfApp.textColor
                                        : ColorsOfApp.shadowColor,
                                    width: 3)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 15.h),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                fit: BoxFit.cover,
                                imageList.value[index],
                                width: 100.w,
                                height: 80.h,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: colorList.value.length,
                      itemBuilder: (context, index) {
                        final colorCode = "0xff${colorList.value[index]}";
                        return GestureDetector(
                          onTap: () {
                            colorIndex.value = index;
                          },
                          child: Container(
                            width: 60.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                                color: Color(int.parse(colorCode)),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: colorIndex.value == index
                                        ? ColorsOfApp.textColor
                                        : ColorsOfApp.shadowColor,
                                    width: 3)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 15.h),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["Product-Name"],
                              style: StylesOfApp.heading
                                  .copyWith(fontWeight: FontWeight.w300),
                            ),
                            Text(data["Category-Name"],
                                style: StylesOfApp.subheading.copyWith(
                                    color: ColorsOfApp.textColor
                                        .withOpacity(0.5))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["Company-Name"],
                              style: StylesOfApp.heading,
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 25.w,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 25.w,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 25.w,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 25.w,
                                ),
                                Text("4.8",
                                    style: StylesOfApp.subheading.copyWith(
                                        color: ColorsOfApp.textColor,
                                        fontSize: 18.sp)),
                              ],
                            ),
                          ],
                        ),
                        Text("\$ ${data["Product-Price"]}",
                            style: StylesOfApp.subheading.copyWith(
                                color: ColorsOfApp.textColor, fontSize: 20.sp)),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Text(
                      data["Details-Name"],
                      style: StylesOfApp.subheading,
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.h),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ButtonWidget(
                      onTap: () {
                        notifier.addDataToCart(data);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CartPage()));
                      },
                      name: "Add To cart")),
            )
          ],
        ),
      ),
    );
  }
}

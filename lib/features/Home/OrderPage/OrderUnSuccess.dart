import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:serviceandstore/Constant/Styles.dart';

import '../../../View/NavBar.dart';
import '../../../Widgets/ButtonWidget.dart';

class OrderUnSuccess extends HookWidget {
  const OrderUnSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 7), () {
        Navigator.pop(context);
      });
    }, []);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text("Something Want Wrong", style: StylesOfApp.heading)),
          ButtonWidget(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NavBarView()));
              },
              name: "Home Page"),
        ],
      ),
    );
  }
}

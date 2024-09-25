import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/View/NavBar.dart';
import 'package:serviceandstore/features/Auth/Signup/Controller/SingupController.dart';
import 'package:serviceandstore/features/Auth/Verification/Controller/VerificationController.dart';
import 'package:serviceandstore/features/Home/Address/Controller/AddressController.dart';
import 'package:serviceandstore/features/Home/Cart/Controller/CartNotifier.dart';
import 'package:serviceandstore/features/Home/DetailsPage/Controller/CartController.dart';
import 'package:serviceandstore/features/Home/MainPage/Controller/HomePageController.dart';
import 'package:serviceandstore/features/Home/Paymnet/Controller/PaymentController.dart';
import 'package:serviceandstore/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpFunction()),
        ChangeNotifierProvider(create: (context) => VerificationController()),
        ChangeNotifierProvider(create: (context) => HomePageController()),
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => CartNotifier()),
        ChangeNotifierProvider(create: (context) => AddressController()),
        ChangeNotifierProvider(create: (context) => PaymentMethod()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(380, 840),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Service And Store',
          theme: ThemeData(
            scaffoldBackgroundColor: ColorsOfApp.primaryColor,
            iconTheme: const IconThemeData(
                color: ColorsOfApp.secondaryColor,
                size: 18,
                applyTextScaling: true),
            brightness: Brightness.light,
            hintColor: ColorsOfApp.shadowColor,
            iconButtonTheme: const IconButtonThemeData(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(ColorsOfApp.primaryColor))),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const NavBarView(),
        ),
      ),
    );
  }
}

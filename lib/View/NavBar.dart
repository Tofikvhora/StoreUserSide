import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:serviceandstore/Constant/Colors.dart';
import 'package:serviceandstore/features/Home/Cart/View/CartPage.dart';
import 'package:serviceandstore/features/Home/Favourite/View/FavouritePage.dart';
import 'package:serviceandstore/features/Home/MainPage/View/HomePage.dart';

class NavBarView extends HookWidget {
  const NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    final screens =
        useState([const HomePage(), const FavouritePage(), const CartPage()]);
    return Scaffold(
      body: screens.value[selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsOfApp.textColor,
        selectedItemColor: ColorsOfApp.secondaryColor,
        unselectedItemColor: ColorsOfApp.shadowColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: selectedIndex.value,
        onTap: (index) {
          selectedIndex.value = index;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
        ],
      ),
    );
  }
}

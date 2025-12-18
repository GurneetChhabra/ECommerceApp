import 'package:ecommerce_app/modules/my_cart.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class HomeBottomScreen extends StatefulWidget {
  Map? arguments;
  bool? fromOrderSearchScreen = false;
  HomeBottomScreen({Key? key, this.arguments, this.fromOrderSearchScreen})
      : super(key: key);

  @override
  _HomeBottomScreenState createState() => _HomeBottomScreenState();
}

class _HomeBottomScreenState extends State<HomeBottomScreen> {
  int currentIndex = 0;
  UniqueKey uniqueKey = UniqueKey();
  List<Widget> screens = [];
  bool isUpdated = false;

  @override
  void initState() {
    print(
        "------------------------------------------------------in initstate of homebottom -------------------------------------------------");
    screens = [HomeScreen(), CartScreen(), CartScreen(), CartScreen()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            screens.removeAt(1);
            screens.insert(
                1,
                CartScreen(
                  key: UniqueKey(),
                ));
            currentIndex = value;
          });
        },
        selectedItemColor: const Color(0xffff3e00),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 30,
              ),
              label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}

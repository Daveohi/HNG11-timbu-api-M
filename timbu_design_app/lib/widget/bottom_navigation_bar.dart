import 'package:flutter/material.dart';
import 'package:timbu_design_app/screens/order_page.dart';
import '../screens/account_page.dart';
import '../screens/storepage.dart';
import '../screens/wish_list_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StorePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WishlistPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrdersPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AccountPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/store.png',
            width: 24,
            height: 24,
            color: currentIndex == 0 ? Colors.green : Colors.grey,
          ),
          label: 'Store',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/liked.png',
            width: 24,
            height: 24,
            color: currentIndex == 1
                ? const Color.fromARGB(255, 35, 122, 42)
                : Colors.grey,
          ),
          label: 'WishList',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/orders.png',
            width: 24,
            height: 24,
            color: currentIndex == 2
                ? const Color.fromARGB(255, 35, 122, 42)
                : Colors.grey,
          ),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/account.png',
            width: 24,
            height: 24,
            color: currentIndex == 3
                ? const Color.fromARGB(255, 35, 122, 42)
                : Colors.grey,
          ),
          label: 'Account',
        ),
      ],
    );
  }
}

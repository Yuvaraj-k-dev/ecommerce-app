import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'Screens/homescreen.dart';
import 'Screens/searchScreen.dart';
import 'Screens/cartScreen.dart';
import 'Screens/wishListScreen.dart';
import 'Screens/profileScreen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0; // Index to track selected tab

  // List of pages corresponding to the tabs
  final List<Widget> _pages = [
    Homescreen(),
    Searchscreen(),
    Cartscreen(),
    WishlistScreen(),
    Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ), // Show selected page
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index; // Update index on tap
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(
            icon: Icon(Iconsax.search_normal),
            label: 'Search',
          ),
          NavigationDestination(icon: Icon(Iconsax.shop), label: 'Cart'),
          NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}

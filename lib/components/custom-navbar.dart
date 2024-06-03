import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [BottomNavigationBarItem(icon: Icon(Icons.home))],
    );
  }
}

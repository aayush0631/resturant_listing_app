import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'list'),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle),
          label: 'bookings',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.pending), label: 'settings'),
      ],
    );
  }
}
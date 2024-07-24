import 'package:flutter/material.dart';

Widget bottomNav(int selectedIndex, Function(int) onItemTapped) {
  return BottomNavigationBar(
    backgroundColor: Color.fromARGB(255, 203, 211, 218),
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.library_books),
        label: 'Library',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        label: 'School',
      ),
    ],
    currentIndex: selectedIndex,
    onTap: onItemTapped,
  );
}

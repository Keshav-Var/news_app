import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void onTap(int index, BuildContext context) {
    _selectedIndex = index;
    if (index == 0) {
      context.go("/home");
    } else {
      context.go("/saved_news");
    }
    notifyListeners();
  }

  void setSelectedIndexByRoute(String route) {
    if (route == '/home') {
      _selectedIndex = 0;
    } else if (route == '/saved_news') {
      _selectedIndex = 1;
    }
    notifyListeners();
  }
}

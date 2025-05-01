import 'package:flutter/material.dart';
import 'package:news_app/core/uttils/constants.dart';
import 'package:news_app/skeleton/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    BottomNavigationProvider provider = Provider.of<BottomNavigationProvider>(
      context,
    );

    return BottomNavigationBar(
      onTap: (index) {
        provider.onTap(index, context);
      },
      currentIndex: provider.selectedIndex,
      selectedItemColor: primaryColor,
      unselectedItemColor: secondaryTextColor,
      selectedLabelStyle: TextStyle(color: secondaryTextColor, fontSize: 16),
      unselectedLabelStyle: TextStyle(color: secondaryTextColor, fontSize: 14),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: provider.selectedIndex == 0 ? 30 : 25),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark,
            size: provider.selectedIndex == 1 ? 30 : 25,
          ),
          label: "Saved News",
        ),
      ],
    );
  }
}

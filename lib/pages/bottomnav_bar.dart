import 'package:emotional_chat/pages/settings_page/settings_body.dart';
import 'package:flutter/material.dart';
import 'home_page/home_page.dart';

class NavBar extends StatefulWidget {
  int finalindex;

  NavBar({super.key, required this.finalindex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final widgetOptions = [
    const HomePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: widget.finalindex,
        onTap: (x) {
          setState(() {
            widget.finalindex = x;
          });
        },
        iconSize: 30,
        elevation: 8.0,
        showSelectedLabels: true,
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 214, 90, 49),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 214, 90, 49),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Color.fromARGB(255, 214, 90, 49),
              ),
              label: "Settings"),
        ],
      ),
      body: widgetOptions[widget.finalindex],
    );
  }
}

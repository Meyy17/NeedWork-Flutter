import 'package:flutter/material.dart';
import 'package:pas_app/Screen/Home/HomeScreen.dart';
import 'package:pas_app/Screen/Profile/ProfileScreen.dart';
import 'package:pas_app/Screen/Saved/SavedScreen.dart';
import 'package:pas_app/Submitted/SubmittedScreen.dart';

class NavBotBar extends StatefulWidget {
  const NavBotBar({Key? key}) : super(key: key);

  @override
  State<NavBotBar> createState() => _NavBotBarState();
}

class _NavBotBarState extends State<NavBotBar> {
  @override
  int _currentIndex = 0;
  final List<Widget> _widgetList = [
    const HomeScreen(),
    const SubmittedScreen(),
    const SavedScreen(),
    const ProfileScreen(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
        selectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 0, 123, 245)),
        unselectedLabelStyle: TextStyle(color: Colors.grey[400]),
        selectedLabelStyle:
            const TextStyle(color: Color.fromARGB(255, 0, 123, 245)),
        fixedColor: Color.fromARGB(255, 0, 123, 245),
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded), label: 'Submitted'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
        ],
      ),
      body: Center(child: _widgetList[_currentIndex]),
    );
  }

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/screens/home.dart';
import 'package:sewa_kendaraan/screens/order.dart';
import 'package:sewa_kendaraan/screens/profile.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Tabs = [Home(), Order(), Profile()];
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Tabs[currentTabIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (currentIndex) {
          currentTabIndex = currentIndex;
          setState(() {
            
          });
        },
        selectedLabelStyle: const TextStyle(color: Colors.white),
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black), label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books, color: Colors.black),
              label: 'library')
        ],
      ),
    );
  }
}

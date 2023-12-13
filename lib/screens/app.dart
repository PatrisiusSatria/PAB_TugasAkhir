import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/screens/home.dart';
import 'package:sewa_kendaraan/screens/orderList.dart';
import 'package:sewa_kendaraan/screens/profile.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: non_constant_identifier_names
  final Tabs = [const HomePage(), OrderPage(), const Profile()];
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
              icon: Icon(Icons.library_books, color: Colors.black), label: 'Order'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box, color: Colors.black),
              label: 'Profile')
        ],
      ),
    );
  }
}

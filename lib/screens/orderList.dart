import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/screens/noRating.dart';
import 'package:sewa_kendaraan/screens/onGoing.dart';
import 'package:sewa_kendaraan/screens/rating.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int currentTabIndex = 0;
  final Tab = [OnGoing() , NoRating(), Rating()];

  Color tabColor(int index) {
    return index == currentTabIndex
        ? const Color(0xB2D9D9D9)
        : Colors.transparent;
  }

  createAppBar() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Color(0xFFC70039), // Set background color to red
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                currentTabIndex = 0;
              });
            },
            child: Container(
              height: 30,
              width: 130,
              decoration: ShapeDecoration(
                color: tabColor(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 5,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'onGoing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Harmattan',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                currentTabIndex = 1;
              });
            },
            child: Container(
              // margin: const EdgeInsets.only(right: 10),
              height: 30,
              width: 130,
              decoration: ShapeDecoration(
                color: tabColor(1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 5,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'belum diReview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Harmattan',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                currentTabIndex = 2;
              });
            },
            child: Container(
              // margin: const EdgeInsets.only(right: 10),
              height: 30,
              width: 130,
              decoration: ShapeDecoration(
                color: tabColor(2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 5,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Sudah diReview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Harmattan',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pesanan'),
          backgroundColor:Color(0xFFC70039),
        ),
        body: Column(
          children: [createAppBar(), Tab[currentTabIndex]],
        ));
  }
}

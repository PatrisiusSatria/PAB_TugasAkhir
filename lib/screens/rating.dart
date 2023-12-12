import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/data/data_kendaraan.dart';
import 'package:sewa_kendaraan/models/kendaraan.dart';
import 'package:sewa_kendaraan/screens/detailOrderAfterRate.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {

  @override
  Widget build(BuildContext context) {
   List<Kendaraan> rented = kendaraanList
        .where((kendaraan) => !kendaraan.onRent && !kendaraan.Rate && kendaraan.Rating)
        .toList();
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: rented.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(rented[index].name),
              subtitle: Text(rented[index].name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailOrderAfterRate(id: rented[index].id),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

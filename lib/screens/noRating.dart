import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/data/data_kendaraan.dart';
import 'package:sewa_kendaraan/models/kendaraan.dart';
import 'package:sewa_kendaraan/screens/detailOrderBeforeRate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoRating extends StatefulWidget {
  const NoRating({super.key});

  @override
  State<NoRating> createState() => _NoRatingState();
}

class _NoRatingState extends State<NoRating> {
  late int lamaPemakaian = 0;
  late String tanggalPemakian = '';
  late int totalHarga = 0;

  @override
  void initState() {
    super.initState();
    loadDataOrder();
  }

  Future<void> loadDataOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lamaPemakaian = prefs.getInt('durationOrder') ?? 0;
      tanggalPemakian = prefs.getString('startDateOrder') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Kendaraan> rented = kendaraanList
        .where((kendaraan) => !kendaraan.onRent && kendaraan.Rate && !kendaraan.Rating)
        .toList();

    return Expanded(
      child: ListView.builder(
        itemCount: rented.length,
        itemBuilder: (context, index) {
          // Hitung total harga
          totalHarga = lamaPemakaian * rented[index].harga;

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              tileColor:
                  Colors.grey[300], // Ganti warna background sesuai keinginan
              contentPadding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Row(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        rented[index].imageUrls[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rented[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text('Lama Pemakaian: $lamaPemakaian hari'),
                        Text('Tanggal Pemakaian: $tanggalPemakian'),
                        Text('Total Harga: $totalHarga'),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailOrderBeforeRate(id: rented[index].id),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

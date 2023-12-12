import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/data/data_kendaraan.dart';
import 'package:sewa_kendaraan/models/kendaraan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailOrder extends StatefulWidget {
  final int id;

  const DetailOrder({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailOrderState createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  late String _namaOrder = '';
  late String _nohpOrder = '';
  late String _namaKendaraan = '';
  late String _jenisKendaraan = '';
  late int _durationOrder = 0;
  late int _harga = 0;
  late String _startDateOrder = '';
  late String _endDateOrder = '';
  late double _subTotal = 0;

  @override
  void initState() {
    super.initState();
    _loadOrderDetails();
  }

  Future<void> _loadOrderDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _namaOrder = prefs.getString('namaOrder') ?? '';
      _nohpOrder = prefs.getString('nohpOrder') ?? '';
      _namaKendaraan = prefs.getString('namaKendaraanOrder') ?? '';
      _jenisKendaraan = prefs.getString('jenisKendaraanOrder') ?? '';
      _durationOrder = prefs.getInt('durationOrder') ?? 0;
      _startDateOrder = prefs.getString('startDateOrder') ?? '';
      _endDateOrder = prefs.getString('endDateOrder') ?? '';
      _subTotal = (prefs.getInt('subTotalOrder') ?? 0) * 95 / 100;
      _harga = prefs.getInt('hargaOrder') ?? 0;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Order'),
        backgroundColor: const Color(0xFFC70039),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nama',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_namaOrder),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nomor HP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_nohpOrder),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _jenisKendaraan,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_namaKendaraan),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Lama Sewa (hari)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('$_durationOrder'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tanggal Mulai Sewa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_startDateOrder),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tanggal Selesai Sewa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_endDateOrder),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Harga',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('$_harga'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'diskon',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('5%'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'subtotal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('$_subTotal'),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        Kendaraan selected = kendaraanList.firstWhere(
                            (kendaraan) => kendaraan.id == widget.id);
                        selected.onRent = false;
                        selected.Rate = true;

                        Navigator.pop(context);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pesanan Selesai'),
                              content: const Text(
                                  'Terima kasih! Pesanan Anda telah selesai.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFFC70039), // Atur warna latar belakang tombol menjadi merah
                      ),
                      child: const Text('Selesai Sewa')),
                ))
          ],
        ),
      ),
    );
  }
}

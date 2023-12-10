import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/data/data_kendaraan.dart';
import 'package:sewa_kendaraan/models/kendaraan.dart';
import 'package:sewa_kendaraan/screens/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailOrder extends StatefulWidget {
  final int id;

  const DetailOrder({Key? key, required this.id}) : super(key: key);

  @override
  _DetailOrderState createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  late String _namaOrder = '';
  late String _nohpOrder = '';
  late int _durationOrder = 0;
  late String _startDateOrder = '';
  late String _endDateOrder = '';

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
      _durationOrder = prefs.getInt('durationOrder') ?? 0;
      _startDateOrder = prefs.getString('startDateOrder') ?? '';
      _endDateOrder = prefs.getString('endDateOrder') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Order'),
        backgroundColor: const Color(0xFFC70039),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
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
                    'Selesai Sewa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Kendaraan selected =
                    kendaraanList.firstWhere((kendaraan) => kendaraan.id == widget.id);
                      selected.onRent = false;
                      selected.Rate = true;

                      Navigator.pop(context); // Kembali ke layar sebelumnya

                      // Menampilkan dialog "Pesanan Selesai"
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
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyApp()), // Ganti HomeScreen() dengan halaman utama Anda
                                    (route) =>
                                        false, // Menghapus semua rute di atas home
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Selesai Sewa'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

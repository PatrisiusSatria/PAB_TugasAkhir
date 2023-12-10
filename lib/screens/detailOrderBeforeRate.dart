import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/data/data_kendaraan.dart';
import 'package:sewa_kendaraan/models/kendaraan.dart';
import 'package:sewa_kendaraan/screens/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailOrderBeforeRate extends StatefulWidget {
  final int id;

  const DetailOrderBeforeRate({Key? key, required this.id}) : super(key: key);

  @override
  _DetailOrderBeforeRateState createState() => _DetailOrderBeforeRateState();
}

class _DetailOrderBeforeRateState extends State<DetailOrderBeforeRate> {
  late String _namaOrder = '';
  late String _nohpOrder = '';
  late int _durationOrder = 0;
  late String _startDateOrder = '';
  late String _endDateOrder = '';
  late int _rating = 0;

  @override
  void initState() {
    super.initState();
    _loadOrderDetails();
    _loadRating(); // Panggil fungsi untuk memuat nilai rating
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

  Future<void> _loadRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedRating = prefs.getInt('car_${widget.id}_rating') ?? 0;

    setState(() {
      _rating = savedRating;
    });
  }

  Future<void> _saveRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('car_${widget.id}_rating', _rating);
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
            _buildRatingSection(), // Panggil fungsi untuk menampilkan bagian rating
            ElevatedButton(
              onPressed: () async {
                await _saveRating();
                Kendaraan selected =
                    kendaraanList.firstWhere((kendaraan) => kendaraan.id == widget.id);
                selected.Rate = false;
                selected.Rating = true;

                Navigator.pop(context);
                // ignore: use_build_context_synchronously
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
                ); // Kembali ke layar sebelumnya
              },
              child: const Text('Submit Rating'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Rating',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
                icon: Icon(
                  Icons.star,
                  color: _rating > index ? Colors.yellow : Colors.grey,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

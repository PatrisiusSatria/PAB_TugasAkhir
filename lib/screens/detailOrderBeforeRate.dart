import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/data/data_kendaraan.dart';
import 'package:sewa_kendaraan/models/kendaraan.dart';
import 'package:sewa_kendaraan/screens/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailOrderBeforeRate extends StatefulWidget {
  final int id;

  const DetailOrderBeforeRate({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailOrderBeforeRateState createState() => _DetailOrderBeforeRateState();
}

class _DetailOrderBeforeRateState extends State<DetailOrderBeforeRate> {
  late String _namaOrder = '';
  late String _nohpOrder = '';
  late String _namaKendaraan = '';
  late String _jenisKendaraan = '';
  late int _durationOrder = 0;
  late int _harga = 0;
  late String _startDateOrder = '';
  late String _endDateOrder = '';
  late double _subTotal = 0;
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
      _namaKendaraan = prefs.getString('namaKendaraanOrder') ?? '';
      _jenisKendaraan = prefs.getString('jenisKendaraanOrder') ?? '';
      _durationOrder = prefs.getInt('durationOrder') ?? 0;
      _startDateOrder = prefs.getString('startDateOrder') ?? '';
      _endDateOrder = prefs.getString('endDateOrder') ?? '';
      _subTotal = (prefs.getInt('subTotalOrder') ?? 0) * 95 / 100;
      _harga = prefs.getInt('hargaOrder') ?? 0;
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
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRatingSection(),
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
            Center(
              child: ElevatedButton(
  
                onPressed: () async {
                  await _saveRating();
                  Kendaraan selected = kendaraanList
                      .firstWhere((kendaraan) => kendaraan.id == widget.id);
                  selected.Rate = false;
                  selected.Rating = true;
            
                  // ignore: use_build_context_synchronously
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
                                    builder: (context) => const MyApp()),
                                (route) => false,
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Submit Rating'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection() {
    return Container(
      margin: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          return IconButton(
            onPressed: () {
              setState(() {
                _rating = index + 1;
              });
            },
            icon: Icon(
              Icons.star,
              size: 50,
              opticalSize: 50,
              color: _rating > index ? const Color(0xFFC70039) : Colors.grey,
            ),
          );
        }),
      ),
    );
  }
}

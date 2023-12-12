import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/data/data_kendaraan.dart';
import 'package:sewa_kendaraan/models/kendaraan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order extends StatefulWidget {
  final int id;

  const Order({Key? key, required this.id}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  late Kendaraan selected;

  DateTime? startDate;
  DateTime? endDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    super.initState();
    selected =
        kendaraanList.firstWhere((kendaraan) => kendaraan.id == widget.id);
  }

  _showSuccessOrder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: FractionallySizedBox(
            heightFactor: 0.4,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Pesanan Diterima",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC70039),
                      fixedSize: const Size(150, 40),
                    ),
                    child: const Text(
                      "Tutup",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _showCancellationOrder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: FractionallySizedBox(
            heightFactor: 0.4,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Pesanan Dibatalkan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Menutup dialog ketika tombol ditekan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC70039),
                      fixedSize: const Size(150, 40),
                    ),
                    child: const Text(
                      "Tutup",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showConfirmationModal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String namaKendaraan = selected.name;
    String jenisKendaraan = selected.kendaraan;
    int duration = int.tryParse(durationController.text) ?? 0;
    int harga = selected.harga;
    int subTotal = selected.harga * duration;

    // ignore: use_build_context_synchronously
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Order'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama: ${nameController.text}'),
              Text('Nomor HP: ${phoneController.text}'),
              Text('Lama Sewa: ${durationController.text} hari'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await prefs.setString('namaOrder', nameController.text);
                await prefs.setString('nohpOrder', phoneController.text);
                await prefs.setString('namaKendaraanOrder', namaKendaraan);
                await prefs.setString('jenisKendaraanOrder', jenisKendaraan);
                await prefs.setInt('durationOrder',
                    int.tryParse(durationController.text) ?? 0);
                await prefs.setString('startDateOrder',
                    selectedStartDate?.toLocal().toString() ?? '');
                await prefs.setString('endDateOrder',
                    selectedEndDate?.toLocal().toString() ?? '');
                await prefs.setInt('subTotalOrder', subTotal);
                await prefs.setInt('hargaOrder', harga);

                Kendaraan selected = kendaraanList
                    .firstWhere((kendaraan) => kendaraan.id == widget.id);
                selected.onRent = true;

                Navigator.of(context).pop();

                _showSuccessOrder();
              },
              child: const Text('Yakin'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showCancellationOrder();
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sewa'),
        backgroundColor: const Color(0xFFC70039),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nama',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC70039)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nomor HP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Nomor HP',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC70039)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lama Sewa (hari)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Lama Sewa (hari)',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC70039)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC70039),
                        ),
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (selectedDate != null &&
                              selectedDate != startDate) {
                            setState(() {
                              startDate = selectedDate;
                              selectedStartDate = selectedDate;
                            });
                          }
                        },
                        child: const Text('Mulai Sewa'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC70039),
                        ),
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (selectedDate != null && selectedDate != endDate) {
                            setState(() {
                              endDate = selectedDate;
                              selectedEndDate = selectedDate;
                            });
                          }
                        },
                        child: const Text('Selesai Sewa'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                selectedStartDate != null
                    ? Text(
                        'Tanggal Mulai Sewa: ${selectedStartDate?.toLocal()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 8),
                selectedEndDate != null
                    ? Text(
                        'Tanggal Selesai Sewa: ${selectedEndDate?.toLocal()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final String name = nameController.text;
                    final String phone = phoneController.text;
                    final int duration =
                        int.tryParse(durationController.text) ?? 0;

                    if (name.isNotEmpty &&
                        phone.isNotEmpty &&
                        duration > 0 &&
                        startDate != null &&
                        endDate != null) {
                      _showConfirmationModal();
                    } else {
                      print('Input tidak valid');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC70039),
                    fixedSize: const Size(200, 50),
                  ),
                  child: const Text('Submit Order'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

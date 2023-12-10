import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/data/data_kendaraan.dart';
import 'package:sewa_kendaraan/models/kendaraan.dart';
import 'package:sewa_kendaraan/screens/order.dart';
import 'package:sewa_kendaraan/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


_showDetailsOverlay(BuildContext context, int id, String title,
    String description, int harga, String imageUrl) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: FractionallySizedBox(
          heightFactor: 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Rp.$harga/Hari",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await signInCheck(context, id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC70039),
                  fixedSize: const Size(300, 15),
                ),
                child: const Text(
                  "Pesan Sekarang",
                  style: TextStyle(fontSize: 15), // Menentukan ukuran teks
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

signInCheck(BuildContext context, int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('login') ?? false;

  if (isLoggedIn) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Order(id: id),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: FractionallySizedBox(
            heightFactor: 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 16),
                Text(
                  "Silahkan login terlebih dahulu.",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC70039),
                    fixedSize: const Size(200, 15),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 10),

              ],
            ),
          ),
        );
      },
    );
  }
}

class _SearchScreenState extends State<SearchScreen> {
  List<Kendaraan> _filter = kendaraanList;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC70039),
        title: const Text("Pencarian Mobil"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple[50],
              ),
              child: TextField(
                // TODO 6: Implementasi Fitur Pencarian
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                    _filter = kendaraanList
                        .where((mobil) => mobil.name
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                        .toList();
                  });
                },
                controller: _searchController,
                autofocus: false,
                decoration: const InputDecoration(
                  hintText: "Cari Mobil ...",
                  prefixIcon: Icon(Icons.search),
                  // TODO 7 : Implementasi pengosongan input
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filter.length,
              itemBuilder: (context, index) {
                final Kendaraan kendaraan = _filter[index];
                return GestureDetector(
                  onTap: () {
                    _showDetailsOverlay(
                      context,
                      kendaraanList[index].id,
                      kendaraanList[index].name,
                      kendaraanList[index].description,
                      kendaraanList[index].harga,
                      kendaraanList[index].imageUrls[0],
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              kendaraan.imageUrls[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kendaraan.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                width: 400,
                                child: Text(
                                  kendaraan.description,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

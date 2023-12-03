import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/screens/itemCard.dart';
import 'package:sewa_kendaraan/screens/order.dart';
import 'package:sewa_kendaraan/screens/search.dart';
import 'package:sewa_kendaraan/data/mobil_data.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedWine Rent',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

_showDetailsOverlay(BuildContext context, int id, String title,
    String description, int harga, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16.0),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Order()),
                  );
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selamat datang di RedWine Rent',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor:const Color(0xFFC70039),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFC70039),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Search()));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white54),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFC70039),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 170,
                          child: ElevatedButton(
                            onPressed: () {
                              // Aksi ketika tombol ditekan
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD9D9D9),
                            ),
                            child: const Text(
                              'Motor',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Kameron',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          )),
                      SizedBox(
                          width: 170,
                          child: ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:const Color(0xFFD9D9D9),
                            ),
                            child: const Text(
                              'Mobil',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Kameron',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 170,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:const Color(0xFFC70039),
                          ),
                          child:const Text('Button 1'),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC70039),
                          ),
                          onPressed: () {},
                          child:const Text('Button 2'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 600,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  padding: const EdgeInsets.all(8),
                  itemCount: mobilList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _showDetailsOverlay(
                          context,
                          mobilList[index].id,
                          mobilList[index].name,
                          mobilList[index].description,
                          mobilList[index].harga,
                          mobilList[index].imageUrls[0],
                        );
                      },
                      child: ItemCard(mobil: mobilList[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/screens/itemCard.dart';
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
        backgroundColor: Colors.red,
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
                  color: Colors.red,
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
                  color: Color(0xFFC70039),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 170,
                          child: ElevatedButton(
                            onPressed: () {
                              // Aksi ketika tombol ditekan
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD9D9D9),
                              // Ganti dengan warna yang diinginkan
                            ),
                            child: Text(
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
                      Container(
                          width: 170,
                          child: ElevatedButton(
                            onPressed: () {
                              // Aksi ketika tombol ditekan
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD9D9D9),
                              // Ganti dengan warna yang diinginkan
                            ),
                            child: Text(
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
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 170,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Button 1'),
                        ),
                      ),
                      Container(
                        width: 170,
                        child: ElevatedButton(
                          onPressed: () {
                            // Aksi ketika tombol kanan ditekan
                          },
                          child: Text('Button 2'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 600,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  padding: EdgeInsets.all(8),
                  itemCount: mobilList.length,
                  itemBuilder: (context, index) {
                    return ItemCard(mobil: mobilList[index]);
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

import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class Akun {
  final String name;
  final String email;

  Akun({
    required this.name,
    required this.email,
  });
}

class _ProfileState extends State<Profile> {
  late Akun akun = Akun(name: '', email: '');
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      akun = Akun(
        name: prefs.getString('name') ?? '',
        email: prefs.getString('email') ?? '',
      );
      isLogin = prefs.getBool('login') ?? false;
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('login', false);
      isLogin = prefs.getBool('login') ?? false;
    });
    print("logout");
    print(isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLogin
          ? SignInScreen()
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const CircleAvatar(
                        radius: 60,
                        // backgroundImage: AssetImage('path/to/your/image.jpg'), // Ganti dengan path gambar profil Anda
                      ),
                    ),
                    Text(
                      'Nama Pengguna: ${akun.name}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Kameron',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Email: ${akun.email}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        logout();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFC70039),
                        fixedSize: Size(200, 50),
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _konfirmPasswordController =
      TextEditingController();
  String _errorTextPass = '';
  String _errorTextKonfirm = '';
  bool _obscurePassword = true;
  bool _obscurePasswordKonf = true;

 void _signUp() async{
  final String name = _nameController.text.trim();
  final String email = _emailController.text.trim();
  final String password = _passwordController.text.trim();
  final String konfirmPassword = _konfirmPasswordController.text.trim();

  // Lakukan validasi dan logic sign-up
  if (password.length < 8 ||
      !password.contains(RegExp(r'[A-Z]')) ||
      !password.contains(RegExp(r'[a-z]')) ||
      !password.contains(RegExp(r'[0-9]')) ||
      !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    setState(() {
      _errorTextPass =
          'Minimal 8 karakter, kombinasi [A-Z], [a-z], [0-9],[!@#\\\$%^&*(),.?":{}|<>]';
    });
    return;
  }

  if (password != konfirmPassword) {
    setState(() {
      _errorTextKonfirm = 'Konfirmasi Password berbeda dengan password!';
    });
    return;
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', name);
  prefs.setString('email', email);
  prefs.setString('password', password);
  

  // ignore: use_build_context_synchronously
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const SignInScreen(),
    ),
    (route) => false,
  );

  // print('*** Sign up berhasil!');
  // print('Nama: $name');
  // print('Email: $email');
  // print('Password: $password');
}


  @override
  void dispose() {
    _nameController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 100, top: 20),
                  child: const CircleAvatar(
                    radius: 60,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5, bottom: 8),
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
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Masukkan Nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 5, bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Masukkan Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 5, bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Password',
                    errorText:
                        _errorTextPass.isNotEmpty ? _errorTextPass : null,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 5, bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Konfirmasi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _konfirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password',
                    errorText:
                        _errorTextKonfirm.isNotEmpty ? _errorTextKonfirm : null,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePasswordKonf = !_obscurePasswordKonf;
                        });
                      },
                      icon: Icon(_obscurePasswordKonf
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  obscureText: _obscurePasswordKonf,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC70039),
                    fixedSize: const Size(200, 50),
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

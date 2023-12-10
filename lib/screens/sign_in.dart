import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/screens/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorTextPass = '';
  String _errorTextEmail = '';
  bool _obscurePassword = true;

  Future<void> _signIn() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _errorTextEmail = 'Email harus diisi';
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _errorTextPass = 'Password harus diisi';
      });
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedEmail = prefs.getString('email') ?? '';
    String storedPassword = prefs.getString('password') ?? '';

    // ignore: prefer_is_not_empty
    if (!(email.isEmpty) && !(password.isEmpty)) {
      if (email == storedEmail && password == storedPassword) {
        // Login berhasil
        prefs.setBool('login', true);
       
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          ),
          (route) => false,
        );
      } else {
        setState(() {
          _errorTextEmail = 'Email atau password tidak sesuai';
          _errorTextPass = 'Email atau password tidak sesuai';
        });
      }
    }
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
                  padding: EdgeInsets.only(left: 16, bottom: 8),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText:
                          _errorTextEmail.isNotEmpty ? _errorTextEmail : null,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 8),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText:
                          _errorTextPass.isNotEmpty ? _errorTextPass : null,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        // Navigasi ke halaman sign-up
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text('Buat Akun ?'),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC70039),
                      fixedSize: const Size(200, 50),
                    ),
                    child: const Text('Sign In'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

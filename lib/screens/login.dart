import 'package:flutter/material.dart';
import './home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool firsTimeOpened = true;

  void _handleLogin() {
    final String username = usernameController.text;
    final String password = passwordController.text;

    if (firsTimeOpened && username == 'username' && password == '12345') {
      firsTimeOpened = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SiswaPage()),
      );
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [],
      //     );
      //   },
      // );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login Gagal', style: TextStyle(color: Colors.red))
              ],
            ),
            content: Text(
                'Username atau Password Salah.'),
            actions: <Widget>[
              TextButton(
                child: Text('Kembali'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Login',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Selamat Datang Pada Halaman Login',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _handleLogin,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

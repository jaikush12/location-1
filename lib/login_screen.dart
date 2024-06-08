import 'package:flutter/material.dart';
import 'navigation_bar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulate successful login (replace with actual logic)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NavigationBarPage()),
            );
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}

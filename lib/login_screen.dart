import 'package:flutter/material.dart';
import 'navigation_bar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(227, 183, 120, 100),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),        
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            Text(
              'FOOTPRINTS\nPowered By MapSense',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30.0,
                fontFamily: 'YourCustomFont',
              ),
            ),
            SizedBox(width: 10.0), // Add some horizontal spacing between text and image
            Image.asset(
              'assets/Directions-bro.png', // Replace with your image path
              height: 400.0, // Adjust image height as needed
              width: 400.0, // Adjust image width as needed
            ),
          ],),
        toolbarHeight: 800.0,
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
          child: Text('Get Started',
          style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(227, 183, 120, 100), // Set background color
          ),
        ),
      ),
    );
  }
}

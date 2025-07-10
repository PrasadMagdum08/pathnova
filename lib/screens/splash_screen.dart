import 'package:Pathnova/screens/auth/login_screen.dart' show LoginScreen;
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(24),
                  child: Icon(Icons.school, size: 48, color: Colors.black),
                ),
                SizedBox(height: 24),
                Text(
                  'PathNova',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Shape your future',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 32),
                CircularProgressIndicator(color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'login_page.dart'; // Import file LoginPage
import 'high_score_page.dart'; // Import file HighScorePage
import 'permainan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 166, 213, 252), // Ubah warna background

      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(
            fontFamily: 'Courier New',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 8, 51, 127), // Ubah warna teks
          ),
        ),

        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 96, 184, 255), // Warna header
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => permainan()),
                );
              },
              child: Text('Play'),
            ),

            SizedBox(height: 20), // Spacer

            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Login'),
            ),

            SizedBox(height: 20), // Spacer

            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman high score
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HighScorePage()),
                );
              },
              child: Text('High Score'),
            ),
          ],
        ),
      ),
    );
  }
}

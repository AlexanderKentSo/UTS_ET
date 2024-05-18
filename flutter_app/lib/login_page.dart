import 'package:flutter/material.dart';
import 'main.dart'; // Import variabel loggedInUsername dari main.dart

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        actions: <Widget>[
          if (loggedInUsername != null) // Tampilkan tombol logout hanya jika pengguna telah login
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Reset the loggedInUsername value to null to indicate logout
                setState(() {
                  loggedInUsername = null;
                });
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController, // Connect the controller to the TextField
              decoration: InputDecoration(
                hintText: 'Enter your username',
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20), // Spacer
            TextField(
              obscureText: true, // Hide text
              decoration: InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20), // Spacer
            ElevatedButton(
              onPressed: () {
                // Send the username value back to the previous page (HomePage)
                Navigator.pop(context, usernameController.text);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

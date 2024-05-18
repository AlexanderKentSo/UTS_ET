import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'high_score_page.dart';
import 'permainan.dart';

late SharedPreferences _prefs; // Declare _prefs globally

void main() async { // Add async keyword here
  WidgetsFlutterBinding.ensureInitialized();
  _prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

String? loggedInUsername;

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int highScore;
  late int attempts;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() {
    setState(() {
      highScore = _prefs.getInt('highScore') ?? 0; // Load high score from SharedPreferences
      attempts = _prefs.getInt('attempts') ?? 0; // Load attempts from SharedPreferences
    });
  } 

  _saveData() {
    _prefs.setInt('highScore', highScore); // Save high score to SharedPreferences
    _prefs.setInt('attempts', attempts); // Save attempts to SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loggedInUsername != null ? 'Welcome, $loggedInUsername' : 'Home Page',
          style: TextStyle(
            fontFamily: 'Courier New',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 8, 51, 127),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 96, 184, 255),
        actions: <Widget>[
          if (loggedInUsername != null)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                setState(() {
                  loggedInUsername = null;
                });
              },
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.png'), // Path to your image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => permainan()),
                  );
                  setState(() {
                    attempts++; // Update attempts
                    if (result > highScore) {
                      highScore = result; // Update high score if the result is higher
                      _saveData(); // Save data when the state changes
                    }
                  });
                },
                child: Text('Play'),
              ),
              SizedBox(height: 20),
              if (loggedInUsername == null)
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    if (result != null) {
                      setState(() {
                        loggedInUsername = result;
                      });
                    }
                  },
                  child: Text('Login'),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HighScorePage(
                        highScore: highScore,
                        attempts: attempts,
                      ),
                    ),
                  );
                },
                child: Text('High Score'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

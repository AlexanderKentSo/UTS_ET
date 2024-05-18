import 'package:flutter/material.dart';

class HighScorePage extends StatelessWidget {
  final int highScore;
  final int attempts;

  HighScorePage({required this.highScore, required this.attempts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('High Score Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('High Score: $highScore'),
            Text('Attempts: $attempts'),
          ],
        ),
      ),
    );
  }
}

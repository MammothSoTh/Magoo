import 'package:flutter/material.dart';
import 'package:magoo101/homepage.dart';

void main() {
  runApp(const MagooApp());
}

class MagooApp extends StatelessWidget {
  const MagooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magoo Indoor Navigation',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MagooHomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:magoo101/speech.dart';

class MagooNavigation extends StatefulWidget {
  final List<double> destination;
  final List<double> assign;
  final String destinationName;
  const MagooNavigation(
      {super.key,
      required this.destination,
      required this.assign,
      this.destinationName = "destination"});

  @override
  State<MagooNavigation> createState() => MagooNavigationState();
}

class MagooNavigationState extends State<MagooNavigation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.brown),
        title: Text(
          "Navigating to ${widget.destinationName}",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.brown.shade500,
          height: double.infinity,
          minWidth: 1000.0,
          onPressed: () {
            Future.delayed(Duration(milliseconds: 300), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MagooSpeechRecognitionPage()));
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.arrow_upward,
                size: 170,
                color: Colors.white,
              ),
              Text(
                'Go Forward',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

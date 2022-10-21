import 'package:flutter/material.dart';
import 'package:magoo101/speech.dart';

class MagooHomePage extends StatelessWidget {
  const MagooHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            Center(
              child: MaterialButton(
                minWidth: 360,
                color: Colors.white,
                //height: double.infinity,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MagooSpeechRecognitionPage()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to Magoo',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 36),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'Application for blind navigation',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
            //],
            // )
          ]),
    );
  }
}

class MagooFailed extends StatelessWidget {
  final String error;
  const MagooFailed(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Sorry, Magoo is unavailable for your device.",
            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

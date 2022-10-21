import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:magoo101/homepage.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'navigation_start.dart';

class MagooSpeechRecognitionPage extends StatefulWidget {
  const MagooSpeechRecognitionPage({super.key});

  @override
  State<MagooSpeechRecognitionPage> createState() =>
      _MagooSpeechRecognitionPageState();
}

class _MagooSpeechRecognitionPageState
    extends State<MagooSpeechRecognitionPage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _wordResults = '';
  String _statusText = 'Tap to speak';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speechToText.initialize().then((available) => !available
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MagooFailed(
                    "Speech Recognition can't be initialized")))
        : null);
    setState(() {
      _wordResults = '';
    });
  }

  void _startListening() async {
    setState(() {
      _isListening = true;
      _statusText = 'Listening...';
    });
    if (kDebugMode) print("Starting Speech...");
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    if (kDebugMode) print("Stopping Speech...");
    setState(() {
      _statusText = "Thinking...";
      _isListening = false;
    });
    if (_wordResults.isEmpty) _statusText = "Please try again...";
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (kDebugMode) print(result.recognizedWords);
    setState(() {
      _wordResults = result.recognizedWords;
      if (result.finalResult) {
        _stopListening();
        result.recognizedWords.isEmpty
            ? _wordResults = "Unknown Destination"
            : null;
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MagooNavigationStart(destination: _wordResults)));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.brown),
          title: const Text(
            "Speak To Go",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.brown,
          //backgroundColor: Colors.transparent,
          //elevation: 0.0,
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            // Text(
            //   _statusText,
            //   style: const TextStyle(
            //       fontWeight: FontWeight.bold, fontSize: 24),
            // // ),
            // const SizedBox(height: 24.0),
            // _wordResults.isEmpty
            //     ? const SizedBox()
            //     : Text(
            //         _wordResults,
            //         style: const TextStyle(
            //             color: Colors.black, fontWeight: FontWeight.bold),
            //       ),
            // IconButton(
            //   onPressed: () =>
            //       !_isListening ? _startListening() : _stopListening(),
            //   color: Colors.pink,
            //   icon: Icon(!_isListening ? Icons.near_me : Icons.stop),
            //   iconSize: 48,
            // ),
            Center(
              child: MaterialButton(
                color: Colors.brown.shade500,
                height: double.infinity,
                minWidth: 360.00,
                onPressed: () =>
                    !_isListening ? _startListening() : _stopListening(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _wordResults,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _statusText,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      Icon(
                        !_isListening ? Icons.near_me : Icons.stop,
                        size: 100,
                        color: Colors.white,
                      ),
                      Text(
                        'Tap to speak',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const Text("Try \"ห้องนอน\" or \"Toilet\"",
                          style: TextStyle(fontSize: 12, color: Colors.grey))
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 18.0),
              // const Text("Try \"ห้องนอน\" or \"Toilet\"",
              //     style: TextStyle(fontSize: 12, color: Colors.grey))
            ),
          ],
        )
        // ]),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:magoo101/room.dart';
import 'package:magoo101/speech.dart';

class MagooNavigation extends StatefulWidget {
  final List<double> destination;
  final List<double> assign;
  final String destinationName;
  final bool gobedroom;

  const MagooNavigation(
      {super.key,
      required this.destination,
      required this.assign,
      this.destinationName = "destination",
      required this.gobedroom});

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
      //appBar: AppBar(

      //title: Text("Navigating to ${gobedroom}",)

      //),
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.brown),
      //   title: Text(
      //     "Navigating to ${widget.destinationName}",
      //     style: const TextStyle(color: Colors.black),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: MaterialApp(
        title: 'Magoo Indoor Navigation',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const DiscoveryPage(),
      ),
    );
  }
}

class MagooNavigationFail extends StatefulWidget {
  final List<double> destination;
  final List<double> assign;
  final String destinationName;
  final bool gobedroom;

  const MagooNavigationFail(
      {super.key,
      required this.destination,
      required this.assign,
      this.destinationName = "destination",
      required this.gobedroom});

  @override
  State<MagooNavigationFail> createState() => MagooNavigationFailState();
}

class MagooNavigationFailState extends State<MagooNavigationFail> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();
  speak() async {
    await flutterTts.setLanguage("en-US");
    //await flutterTts.setLanguage("th-TH");
    await flutterTts.setPitch(1);
    await flutterTts.speak("tap and tell where you want to go".toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //appBar: AppBar(

      //title: Text("Navigating to ${gobedroom}",)

      //),
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.brown),
      //   title: Text(
      //     "Navigating to ${widget.destinationName}",
      //     style: const TextStyle(color: Colors.black),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
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
                    builder: (context) => MagooSpeechRecognitionPage(),
                  ));
              // flutterTts.speak(
              //     "No Position in database please tap and try again"
              //         .toString());
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.do_not_disturb,
                size: 200,
                color: Colors.white,
              ),
              Text(
                'No Position in database please tap and try again',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

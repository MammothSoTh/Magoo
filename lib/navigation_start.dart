import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:magoo101/navigation.dart';

class MagooNavigationStart extends StatefulWidget {
  final String destination;
  const MagooNavigationStart({super.key, required this.destination});

  @override
  MagooNavigationStartState createState() => MagooNavigationStartState();
}

class MagooNavigationStartState extends State<MagooNavigationStart> {
  String navigationStatus = 'Initializing...';
  List<double> destinationLocation = [];
  List<double> userLocation = [];
  bool gobedroom = false;
  bool gobathroom = false;
  bool golivingroom = false;
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
    _initNavigation();
  }

  void _initNavigation() {
    Future.delayed(const Duration(milliseconds: 1800), () {
      widget.destination.toString() == "ห้องน้ำ".toString()
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MagooNavigation(
                        destination: destinationLocation,
                        assign: userLocation,
                        destinationName: widget.destination,
                        gobedroom: gobedroom = true,
                      )))
          : widget.destination.toString() == "ห้องนอน".toString()
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MagooNavigation(
                            destination: destinationLocation,
                            assign: userLocation,
                            destinationName: widget.destination,
                            gobedroom: gobedroom,
                          )))
              : widget.destination.toString() == "ห้องนั่งเล่น".toString()
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MagooNavigation(
                                destination: destinationLocation,
                                assign: userLocation,
                                destinationName: widget.destination,
                                gobedroom: gobedroom,
                              )))
                  : {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MagooNavigationFail(
                                    destination: destinationLocation,
                                    assign: userLocation,
                                    destinationName: widget.destination,
                                    gobedroom: gobedroom,
                                  ))),
                      flutterTts.speak(
                          "No Position in database please tap and try again"
                              .toString())
                    };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Starting Navigating to...' + '\n'),
        Text(widget.destination,
            style: TextStyle(color: Colors.brown, fontSize: 36)),
        const SizedBox(height: 24.0),
        destinationLocation.isNotEmpty
            ? Text('Destination: ${destinationLocation.join(" ")}')
            : const SizedBox(),
        userLocation.isNotEmpty
            ? Text('User Location: ${userLocation.join(" ")}')
            : const SizedBox(),
        Text(navigationStatus, style: const TextStyle(color: Colors.grey))
      ],
    ));
  }
}

import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    _initNavigation();
  }

  void _initNavigation() {
    Future.delayed(const Duration(milliseconds: 1800), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MagooNavigation(
                    destination: destinationLocation,
                    assign: userLocation,
                    destinationName: widget.destination,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Starting Navigating to...'),
        Text(widget.destination,
            style: TextStyle(color: Colors.pink[200], fontSize: 36)),
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

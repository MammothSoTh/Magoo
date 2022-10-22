import 'package:flutter/material.dart';
import 'package:magoo101/room.dart';

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

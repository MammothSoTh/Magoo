import 'package:flutter/material.dart';

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
          iconTheme: const IconThemeData(color: Colors.pink),
          title: Text(
            "Navigating to ${widget.destinationName}",
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text("Go forward"), Icon(Icons.arrow_upward)],
              ),
            ]));
  }
}

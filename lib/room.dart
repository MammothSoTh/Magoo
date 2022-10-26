import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:magoo101/navigation_start.dart';
import 'package:magoo101/widgets.dart';

import 'cal.dart';
import 'speech.dart';

//void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Indoor Navigation',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         body: Center(child: DiscoveryPage()),
//       ),
//     );
//   }
// }

class DiscoveryPage extends StatefulWidget {
  /// If true, discovery starts on page start, otherwise user must press action button.
  final bool start;
  const DiscoveryPage({this.start = true});

  @override
  _DiscoveryPage createState() => new _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  Distancing distancing = new Distancing();
  final FlutterTts flutterTts = FlutterTts();

  speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setLanguage("th-TH");
    await flutterTts.setPitch(1);
    await flutterTts.speak("tab and tell where you want to go");
  }

  Widget finding() {
    Future.delayed(const Duration(milliseconds: 1800));
    flutterTts.setLanguage("en-US");
    //flutterTts.setLanguage("th-TH");
    flutterTts.setPitch(1);
    flutterTts.speak("finding your position");
    return Container(width: 0, height: 0);
  }

  Widget gostraight() {
    Future.delayed(const Duration(milliseconds: 1800));
    flutterTts.setLanguage("en-US");
    //flutterTts.setLanguage("th-TH");
    flutterTts.setPitch(1);
    flutterTts.speak("go straight");
    return Container(width: 0, height: 0);
  }

  Widget gobackward() {
    Future.delayed(const Duration(milliseconds: 1800));
    flutterTts.setLanguage("en-US");
    //flutterTts.setLanguage("th-TH");
    flutterTts.setPitch(1);
    flutterTts.speak("go backward");
    return Container(width: 0, height: 0);
  }

  Widget turnleft() {
    Future.delayed(const Duration(milliseconds: 1800));
    flutterTts.setLanguage("en-US");
    //flutterTts.setLanguage("th-TH");
    flutterTts.setPitch(1);
    flutterTts.speak("turnleft");
    return Container(width: 0, height: 0);
  }

  Widget turnright() {
    Future.delayed(const Duration(milliseconds: 1800));
    flutterTts.setLanguage("en-US");
    //flutterTts.setLanguage("th-TH");
    flutterTts.setPitch(1);
    flutterTts.speak("turnrigt");
    return Container(width: 0, height: 0);
  }

  Widget allzero() {
    Future.delayed(const Duration(milliseconds: 1800));
    flutterTts.setLanguage("en-US");
    //flutterTts.setLanguage("th-TH");
    flutterTts.setPitch(1);
    flutterTts.speak("finding your position");
    distancing.setallzero();
    return Container(width: 0, height: 0);
  }

  Widget atdestination() {
    Future.delayed(const Duration(milliseconds: 1800));
    flutterTts.setLanguage("en-US");
    //flutterTts.setLanguage("th-TH");
    flutterTts.setPitch(1);
    flutterTts.speak("you are at your destination ");
    return Column(
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MagooSpeechRecognitionPage()));
            Future.delayed(const Duration(milliseconds: 1800));
            speak();
          },
        )
      ],
    );
  }

  Goto goto = new Goto();
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  bool isDiscovering = false;

  _DiscoveryPage();

  @override
  void initState() {
    super.initState();
    isDiscovering = widget.start;
    flutterTts.speak("finding your position");
    if (isDiscovering) {
      _startDiscovery();
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });
    print(results.toString());
    _startDiscovery();
  }

  Future<void> _startDiscovery() async {
    await FlutterBluetoothSerial.instance.cancelDiscovery();

    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        final existingIndex = results.indexWhere(
            (element) => element.device.address == r.device.address);
        if (existingIndex >= 0)
          results[existingIndex] = r;
        else
          results.add(r);
      });
    });

    _streamSubscription!.onDone(() {
      setState(() {
        isDiscovering = false;
        // sleep(Duration(milliseconds: 50));
      });
      distancing.positional().toString() != "null"
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Text(
                    distancing.positional().toString(),
                    style: TextStyle(color: Colors.white70),
                  ),
                  Goto().gotobedroom == true
                      ? distancing.x as int > 6 + -1 //bedroom x = 6
                          ? gobackward()
                          : distancing.x as int < 6 + -1
                              ? gostraight()
                              : distancing.x as int == 6 + -1
                                  ? distancing.y as int > 7 + -1 //bedroom y = 7
                                      ? turnleft()
                                      : distancing.y as int < 7 + -1
                                          ? turnright()
                                          : distancing.y as int == 7 + -1
                                              ? atdestination()
                                              : allzero()
                                  : allzero()
                      : allzero()
                  // : Goto().gotolivingroom == true
                  //  ?finding()
                  // : Goto().gotobathroom == true
                ])
          : finding();
      _restartDiscovery();
    });
  }

  // @TODO . One day there should be `_pairDevice` on long tap on something... ;)

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: isDiscovering
            ? Text('Discovering devices')
            : Text('Discovered devices'),
        actions: <Widget>[
          isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: new EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      body: Container(
        color: Colors.brown.shade500,
        height: double.infinity,
        width: 500.0,
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.brown,
                height: 500,
                width: 500.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.length,
                  itemBuilder: (BuildContext context, index) {
                    BluetoothDiscoveryResult result = results[index];
                    final device = result.device;
                    final address = device.address;
                    return BluetoothDeviceListEntry(
                      device: device,
                      rssi: result.rssi, distancing: this.distancing,
                      //distancing: Distancing(1,2,3,4),
                    );
                  },
                ),
              ),
              Icon(
                Icons.location_on,
                size: 50,
                color: Colors.white,
              ),
              // Text(distancing.positional().toString())
              // distancing.positional().toString() != "null"
              //     ? Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //             Text(
              //               distancing.positional().toString(),
              //               style: TextStyle(color: Colors.white70),
              //             ),
              //             Goto().gotobedroom == true
              //                 ? finding()
              //                 : Goto().gotolivingroom == true
              //                     ? finding()
              //                     : Goto().gotobathroom == true
              //                         ? finding()
              //                         : finding()
              //           ])
              //     : finding(),

              if (distancing.positional().toString() != "null")
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        // '\n'
                        //'Your Position is ' +
                        distancing.positional().toString(),
                        // results.map((element) {
                        //   return element.rssi;
                        // }
                        // ).join("/"),
                        style: TextStyle(color: Colors.white70),
                      ),
                    ])
              else
                // flutterTts.speak("Finding your position")
                Text(
                  //'\n'
                  "Finding your position",
                  //
                  // results.map((element) {
                  //   return element.rssi;
                  // }
                  // ).join("/"),
                  style: TextStyle(color: Colors.white70),
                ),

              // distancing.positional().toString() != null
              //     ? Text(
              //         "Your Position = " + distancing.positional().toString(),
              //         style: TextStyle(color: Colors.white70),
              //       )
              //     : Container(width: 0, height: 0),
            ]),
      ),
    );
  }
}

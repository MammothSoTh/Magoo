import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:magoo101/navigation_start.dart';
import 'package:magoo101/widgets.dart';

import 'cal.dart';

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

  Goto goto = new Goto();
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  bool isDiscovering = false;

  _DiscoveryPage();

  @override
  void initState() {
    super.initState();
    isDiscovering = widget.start;
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
    distancing.setallzero();
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
  void initState2() {
    super.initState();
    _initNavigation2();
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
                Text(
                  '\n'
                  "Finding your position",

                  // results.map((element) {
                  //   return element.rssi;
                  // }
                  // ).join("/"),
                  style: TextStyle(color: Colors.white70),
                )

              // flutterTts.speak("Finding your position"))

              // position.toString() !== null
              //     ? Text(
              //         "Your Position = "+ position.tostring,
              //         style: TextStyle(color: Colors.white70),
              //       )
              //     : Container(width: 0, height: 0),
            ]),
      ),
    );
  }

  void _initNavigation2() {
    Future.delayed(const Duration(milliseconds: 1800), () {
      distancing.positional() != "Null".toString()
          ? flutterTts.speak("No Position in database please tap and try again")
          //distancing.positional().X ==

          : flutterTts.speak(
              "No Position in database please tap and try again".toString());
    });
  }
}

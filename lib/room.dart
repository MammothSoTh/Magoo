import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:magoo101/widgets.dart';

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
                      rssi: result.rssi,
                    );
                  },
                ),
              ),
              Icon(
                Icons.location_on,
                size: 50,
                color: Colors.white,
              ),
              //Text(positional().toString())
              // positional().toString() != null
              //     ? Text(
              //         '\n'
              //                 'Your Position is ' +
              //             positional().toString(),
              //         // results.map((element) {
              //         //   return element.rssi;
              //         // }
              //         // ).join("/"),
              //         style: TextStyle(color: Colors.white70),
              //       )
              //     : Text(
              //         '\n'
              //         'Findind your position',
              //
              //         // results.map((element) {
              //         //   return element.rssi;
              //         // }
              //         // ).join("/"),
              //         style: TextStyle(color: Colors.white70),
              //       )

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
}

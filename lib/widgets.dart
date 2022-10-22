import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'cal.dart';

class BluetoothDeviceListEntry extends ListTile {
  BluetoothDeviceListEntry({
    required BluetoothDevice device,
    int? rssi,
    String? l,
    int? rssi1,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
    bool enabled = true,
  }) : super(
          //
          //title: Text(device.name ?? ""),
          //subtitle: Text(device.address.toString() + "\n"
          title: device.address.toString() == "A0:67:20:4B:84:7D".toString()
              ? Container(
                  child: Text(
                    "distance from bt2 = ",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : device.address.toString() == "E0:67:81:7E:3C:6B".toString()
                  ? Text(
                      "distance from bt2 = ",
                      style: TextStyle(color: Colors.white70),
                    )
                  : Text(device.address.toString()),
          // +
          // position(rssi.toString(), device.address.toString())
          //     .then((result) {
          //   return result.toString();
          // })
          //),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              device.address.toString() == "A0:67:20:4B:84:7D".toString()
                  ? Column(
                      children: [Funtion1(rssi!)],
                    )
                  : device.address.toString() == "E0:67:81:7E:3C:6B".toString()
                      ? Funtion1(rssi!)
                      : Funtion1(rssi!)
            ],
          ),
        );
}

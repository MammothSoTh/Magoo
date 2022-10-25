import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:magoo101/cal.dart';

import 'cal.dart';

class BluetoothDeviceListEntry extends ListTile {
  // BluetoothDeviceListEntry(this.distancing);

  Distancing distancing = new Distancing();
  BluetoothDeviceListEntry({
    super.key,
    required this.distancing,
    //this.distancing;
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
                    "distance from bt 1 = ",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : device.address.toString() == "E0:67:81:7E:3C:6B".toString()
                  ? Text(
                      "distance from bt 2 = ",
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
              device.address.toString() == "43:CE:8D:8A:E3:C0".toString()
                  ? Container(
                      child: Text(
                        //"dh",
                        // distancing.distance1.toString() != null
                        distancing.setdistance1(rssi!).toString(),
                        // notiflylistenner(),
                        //: "no",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : device.address.toString() == "E0:67:81:7E:3C:6B".toString()
                      ? Container(
                          child: Text(
                            distancing.setdistance2(rssi!).toString(),
                            //positional().toString(),
                            //togetvalue2(rssi!).toString(), //AsFixed(2) + " m.",
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : Container(
                          child: Text(
                              // "ji",
                              distancing.positional().toString()
                              // +                              distancing.setdistance1(99999).toString(),
                              ))
            ],
          ),
        );
}

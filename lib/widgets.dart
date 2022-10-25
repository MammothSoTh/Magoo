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
          title: device.address.toString() == "DC:72:23:B4:DE:AA".toString()
              ? Container(
                  child: Text(
                    "distance from bt 1 = ",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : device.address.toString() == "00:C3:F4:84:7C:A6".toString()
                  ? Text(
                      "distance from bt 2 = ",
                      style: TextStyle(color: Colors.white70),
                    )
                  : device.address.toString() == "10:76:36:8D:63:0A".toString()
                      ? Text(
                          "distance from bt 3 = ",
                          style: TextStyle(color: Colors.white70),
                        )
                      : device.address.toString() ==
                              "73:22:66:50:7A:E4".toString()
                          ? Text(
                              "distance from bt 4 = ",
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
              device.address.toString() == "DC:72:23:B4:DE:AA".toString()
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
                  : device.address.toString() == "00:C3:F4:84:7C:A6".toString()
                      ? Container(
                          child: Text(
                            distancing.setdistance2(rssi!).toString(),
                            //positional().toString(),
                            //togetvalue2(rssi!).toString(), //AsFixed(2) + " m.",
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : device.address.toString() ==
                              "10:76:36:8D:63:0A".toString()
                          ? Container(
                              child: Text(
                                distancing.setdistance3(rssi!).toString(),
                                //positional().toString(),
                                //togetvalue2(rssi!).toString(), //AsFixed(2) + " m.",
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                          : device.address.toString() ==
                                  "73:22:66:50:7A:E4".toString()
                              ? Container(
                                  child: Text(
                                    distancing.setdistance4(rssi!).toString(),
                                    //positional().toString(),
                                    //togetvalue2(rssi!).toString(), //AsFixed(2) + " m.",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                )
                              : Container(
                                  child: Text(
                                  "Don't recognize this divice",
                                  //distancing.positional().toString()
                                  // +                              distancing.setdistance1(99999).toString(),
                                ))
            ],
          ),
        );
}

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
          title: device.address.toString() == "20:16:09:18:51:34".toString()
              ? Container(
                  child: Text(
                    "distance from bt 1 = ",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : device.address.toString() == "20:16:09:08:32:69".toString()
                  ? Text(
                      "distance from bt 2 = ",
                      style: TextStyle(color: Colors.white70),
                    )
                  : device.address.toString() == "20:16:09:18:67:57".toString()
                      ? Text(
                          "distance from bt 3 = ",
                          style: TextStyle(color: Colors.white70),
                        )
                      : device.address.toString() ==
                              "E1:43:13:11:54:45".toString()
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
              device.address.toString() == "20:16:09:18:51:34".toString()
                  ? Container(
                      child: Text(
                        // rssi.toString(),
                        //"dh",
                        // distancing.distance1.toString() != null
                        distancing.setdistance1(rssi!.toDouble()).toString(),
                        // notiflylistenner(),
                        //: "no",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : device.address.toString() == "20:16:09:08:32:69".toString()
                      ? Container(
                          child: Text(
                            // rssi.toString(),
                            distancing
                                .setdistance2(rssi!.toDouble())
                                .toString(),
                            //positional().toString(),
                            //togetvalue2(rssi!).toString(), //AsFixed(2) + " m.",
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : device.address.toString() ==
                              "20:16:09:18:67:57".toString()
                          ? Container(
                              child: Text(
                                distancing
                                    .setdistance3(rssi!.toDouble())
                                    .toString(),
                                //positional().toString(),
                                //togetvalue2(rssi!).toString(), //AsFixed(2) + " m.",
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                          : device.address.toString() ==
                                  "E1:43:13:11:54:45".toString()
                              ? Container(
                                  child: Text(
                                    // rssi.toString(),
                                    distancing
                                        .setdistance4(rssi!.toDouble())
                                        .toString(),
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

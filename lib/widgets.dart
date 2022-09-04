import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'cal.dart';

class BluetoothDeviceListEntry extends ListTile {
  BluetoothDeviceListEntry({
    required BluetoothDevice device,
    int? rssi,
    String? l,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
    bool enabled = true,
  }) : super(
          //
          title: Text(device.name ?? ""),
          subtitle: Text(device.address.toString() + position(rssi).toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              rssi != null
                  ? Container(
                      margin: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(rssi.toString() + "dBm"),
                          Text(distance(rssi)),
                          //Text(position(rssi))
                        ],
                      ),
                    )
                  : Container(width: 0, height: 0),
              device.isConnected
                  ? Icon(Icons.import_export)
                  : Container(width: 0, height: 0),
              device.isBonded
                  ? Icon(Icons.link)
                  : Container(width: 0, height: 0),
            ],
          ),
        );
}

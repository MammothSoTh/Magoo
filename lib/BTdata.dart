// To parse this JSON data, do
//
//     final bTdata = bTdataFromJson(jsonString);

import 'dart:convert';

BTdata bTdataFromJson(String str) => BTdata.fromJson(json.decode(str));

String bTdataToJson(BTdata data) => json.encode(data.toJson());

class BTdata {
  BTdata({
    required this.devicesPosition,
  });

  Map<String, DevicesPosition> devicesPosition;

  factory BTdata.fromJson(Map<String, dynamic> json) => BTdata(
        devicesPosition: Map.from(json["devicesPosition"]).map((k, v) =>
            MapEntry<String, DevicesPosition>(k, DevicesPosition.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "devicesPosition": Map.from(devicesPosition)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class DevicesPosition {
  DevicesPosition(this.positionx, this.positiony, this.positionz,
      [this.name = "Unknow"]);

  String name;
  int positionx;
  int positiony;
  int positionz;

  factory DevicesPosition.fromJson(Map<String, dynamic> json) =>
      DevicesPosition(
        json["name"],
        json["positionx"],
        json["positiony"],
        json["positionz"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "positionx": positionx,
        "positiony": positiony,
        "positionz": positionz,
      };
}

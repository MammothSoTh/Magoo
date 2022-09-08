import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:ml_linalg/linalg.dart';

import 'BTdata.dart';

String powerrssi(int s) {
  return "_s" + s.toString();
}

num distance(int rssi) {
  double n;
  int A;
  n = 2.4;
  A = -79;
  return pow(10, (A - rssi) / (10 * n));
}

Future<String> position(rssi, String macadress) async {
  var jsonx1 =
      json.decode(await rootBundle.loadString('assets/db.json').toString());
  print(await jsonx1["devicesPosition"][macadress]["positionx"]);
  var jsony1 =
      json.decode(await rootBundle.loadString('assets/db.json').toString());
  print(await jsony1["devicesPosition"][macadress]["positiony"]);
  var jsonz1 =
      json.decode(await rootBundle.loadString('assets/db.json').toString());
  print(await jsonz1["devicesPosition"][macadress]["positionz"]);

  var sx = DevicesPosition(12, 12, 3);
  print(sx.toString());
  // if (sx == null) {
  //   //return sx = 0;
  // }
  //dynamic sy = BTData().devicesPosition?.b0BE8369621A?.positiony;
  int x1 = 1,
      x2 = 15,
      x3 = 84,
      y1 = 63,
      y2 = 11,
      y3 = 12,
      z1 = 13,
      z2 = 14,
      z3 = 15,
      s1 = 2,
      s2 = 3,
      s3 = 4;
  var x, y, z;
  final matrix1 = Matrix.fromList([
    [
      1,
      jsonx1["devicesPosition"][macadress]["positionx"] * (-2),
      jsony1["devicesPosition"][macadress]["positiony"] * (-2),
      jsonz1["devicesPosition"][macadress]["positionz"] * (-2),
    ],
    [1, x2 * (-2), y2 * (-2), z2 * (-2)],
    [1, x3 * (-2), y3 * (-2), z3 * (-2)],
  ]);
  final matrix3 = Matrix.fromList([
    [455],
    [25],
    [560],
  ]);
  //x=((At*A)^-1)*At *B
  final matrix1T = matrix1.transpose(); //1transpose
  final matrix11T = matrix1T * matrix1; //1*1Transpose
  final matrix11Ti = matrix11T.inverse(); //(1*1Transpose)^-1
  final matrix11Ti1t = matrix11Ti * matrix1T; //((1*1Transpose)^-1)*1Transpose
  final matrix11Tit3 =
      matrix11Ti1t * matrix3; //(((1*1Transpose)^-1)*1Transpose)*2

  final a = matrix11Tit3[1];
  final asum = a.sum();
  print(asum.toString());
  final b = matrix11Tit3[2];
  final bsum = b.sum();
  final c = matrix11Tit3[3];
  final csum = c.sum();
  // print(matrix11Tit3);
  //print("a=" + a.toString());
  //final asum = a.sum();
  print("your position is =" +
      (asum.toStringAsFixed(2)) +
      "," +
      (bsum.toStringAsFixed(2)) +
      "," +
      (csum.toStringAsFixed(2)).toString());
  return (
      // matrix11Tit3.toString()
      "your position is =" +
          "\n" +
          (asum.toStringAsFixed(2)) +
          "," +
          (bsum.toStringAsFixed(2)) +
          "," +
          (csum.toStringAsFixed(2)).toString());
}

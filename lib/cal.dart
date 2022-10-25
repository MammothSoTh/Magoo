import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:ml_linalg/linalg.dart';

String powerrssi(int s) {
  return "_s" + s.toString();
}

num? distance(int rssi) {
  double n;
  int A;
  n = 2.4;
  A = -79;
  if (rssi == null)
    return null;
  else
    return pow(10, (A - rssi) / (10 * n));
}

class Distancing extends ChangeNotifier {
  late int? rssi1 = 99999, rssi2 = 99999, rssi3 = 99999, rssi4 = 99999;
  int a = 2;

  Distancing(
      // [this.distance1 = 9999999,
      // this.distance2 = 9999999,
      // this.distance3 = 9999999,
      // this.distance4 = 9999999]
      ) {}

  // Method.
  num? setdistance1(int rssi1) {
    this.rssi1 = rssi1;
    var distance1 = distance(rssi1!);
    notifyListeners();
    print("rssi1 = ");
    print(rssi1);
    return distance1;
  }

  num? setdistance2(int rssi2) {
    //this.distance2 = distance(rssi2) as int?;
    this.rssi2 = rssi2;
    var distance2 = distance(rssi2!);
    notifyListeners();
    print("rssi2 = ");
    print(rssi2);
    return distance2;
  }

  num? setdistance3(int rssi3) {
    this.rssi3 = rssi3;
    var distance3 = distance(rssi3!);
    notifyListeners();
    print("rssi3 = ");
    print(rssi3);
    return distance3;
  }

  num? setdistance4(int rssi4) {
    this.rssi4 = rssi4;
    var distance4 = distance(rssi4!);
    notifyListeners();
    print("rssi4 = ");
    print(rssi4);
    return distance4;
  }

  num? distance(int rssi) {
    double n;
    int A;
    n = 2.4;
    A = -79;
    if (rssi == null)
      return null;
    else
      return pow(10, (A - rssi) / (10 * n));
  }

  String? positional() {
    int x1 = 1,
        y1 = 63,
        z1 = 13,
        x2 = 15,
        y2 = 11,
        z2 = 14,
        x3 = 19,
        y3 = 12,
        z3 = 15,
        x4 = 13,
        y4 = 9,
        z4 = 15;
    var distance1 = distance(rssi1!);
    var distance2 = distance(rssi2!);
    print("rssi2 =" + distance1.toString());
    var distance3 = distance(rssi3!);
    var distance4 = distance(rssi4!);
    //device1 = (x1,y1,z1)
    // var x, y, z;
    final matrix1 = Matrix.fromList([
      [1, x1 * (-2), y1 * (-2), z1 * (-2)],
      [1, x2 * (-2), y2 * (-2), z2 * (-2)],
      [1, x3 * (-2), y3 * (-2), z3 * (-2)],
      [1, x4 * (-2), y4 * (-2), z4 * (-2)],
    ]);
    final matrix3 = Matrix.fromList([
      [sqrt(distance1!) - sqrt(x1) - sqrt(y1) - sqrt(z1)],
      [sqrt(distance2!) - sqrt(x2) - sqrt(y2) - sqrt(z2)],
      [sqrt(distance3!) - sqrt(x3) - sqrt(y3) - sqrt(z3)],
      [sqrt(distance4!) - sqrt(x1) - sqrt(y1) - sqrt(z1)],
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
    //print(asum.toString());
    final b = matrix11Tit3[2];
    final bsum = b.sum();
    final c = matrix11Tit3[3];
    final csum = c.sum();
    print(matrix11Tit3);
    //print("a=" + a.toString());
    //final asum = a.sum();
    print("your position is =" +
        (asum.toStringAsFixed(2)) +
        "," +
        (bsum.toStringAsFixed(2)) +
        "," +
        (csum.toStringAsFixed(2)).toString());

    if (distance1 != 0 && distance2 != 0)
      return (
          // matrix11Tit3.toString()
          "your position is =" +
              "\n" +
              (asum.toStringAsFixed(2)) +
              "," +
              (bsum.toStringAsFixed(2)) +
              "," +
              (csum.toStringAsFixed(2)).toString() +
              "  d2=" +
              distance2.toString());
    else
      return ("null".toString());
  }
}

//int? d1 = distance1.toInt(), d2 = rssi2.toInt();
//
// String? positional() {
//   int x1 = 1,
//       y1 = 63,
//       z1 = 13,
//       x2 = 15,
//       y2 = 11,
//       z2 = 14,
//       x3 = 19,
//       y3 = 12,
//       z3 = 15,
//       x4 = 13,
//       y4 = 9,
//       z4 = 15;
//   int? d1 = rssi1.toInt(), d2 = rssi2.toInt();
//   //device1 = (x1,y1,z1)
//   // var x, y, z;
//   final matrix1 = Matrix.fromList([
//     [1, x1 * (-2), y1 * (-2), z1 * (-2)],
//     [1, x2 * (-2), y2 * (-2), z2 * (-2)],
//     [1, x3 * (-2), y3 * (-2), z3 * (-2)],
//     [1, x4 * (-2), y4 * (-2), z4 * (-2)],
//   ]);
//   final matrix3 = Matrix.fromList([
//     [sqrt(d1) - sqrt(x1) - sqrt(y1) - sqrt(z1)],
//     [sqrt(d2) - sqrt(x2) - sqrt(y2) - sqrt(z2)],
//     [sqrt(d2) - sqrt(x3) - sqrt(y3) - sqrt(z3)],
//     [sqrt(d1) - sqrt(x1) - sqrt(y1) - sqrt(z1)],
//   ]);
//   //x=((At*A)^-1)*At *B
//   final matrix1T = matrix1.transpose(); //1transpose
//   final matrix11T = matrix1T * matrix1; //1*1Transpose
//   final matrix11Ti = matrix11T.inverse(); //(1*1Transpose)^-1
//   final matrix11Ti1t = matrix11Ti * matrix1T; //((1*1Transpose)^-1)*1Transpose
//   final matrix11Tit3 =
//       matrix11Ti1t * matrix3; //(((1*1Transpose)^-1)*1Transpose)*2
//
//   final a = matrix11Tit3[1];
//   final asum = a.sum();
//   //print(asum.toString());
//   final b = matrix11Tit3[2];
//   final bsum = b.sum();
//   final c = matrix11Tit3[3];
//   final csum = c.sum();
//   print(matrix11Tit3);
//   //print("a=" + a.toString());
//   //final asum = a.sum();
//   print("your position is =" +
//       (asum.toStringAsFixed(2)) +
//       "," +
//       (bsum.toStringAsFixed(2)) +
//       "," +
//       (csum.toStringAsFixed(2)).toString() +
//       rssi1.toString() +
//       rssi2.toString());
//
//   // if (rssi1 != null && rssi2 != null && rssi3 != null && rssi4 != null)
//   //   return ("null".toString());
//   // else
//   //   return (matrix11Tit3.toString());
//   return (
//       // matrix11Tit3.toString()
//       "your position is =" +
//           "\n" +
//           (asum.toStringAsFixed(2)) +
//           "," +
//           (bsum.toStringAsFixed(2)) +
//           "," +
//           (csum.toStringAsFixed(2)).toString() +
//           "  d1=" +
//           d1.toString());
// }

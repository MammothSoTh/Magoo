import 'dart:math';

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

double rssi1 = 9999, rssi2 = 9999, rssi3 = 9999, rssi4 = 9999;

String togetvalue(rssi) {
  final double rssi1 = distance(rssi)!.toDouble();
  //print("rssi1 = " + rssi1.toString());
  return rssi1.toString();
}

String togetvalue2(rssi) {
  final double rssi2 = distance(rssi)!.toDouble();
  print("rssi1 = " + rssi1.toString());
  return rssi2.toString();
}

int? d1 = rssi1.toInt(), d2 = rssi2.toInt();

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
  //device1 = (x1,y1,z1)
  // var x, y, z;
  final matrix1 = Matrix.fromList([
    [1, x1 * (-2), y1 * (-2), z1 * (-2)],
    [1, x2 * (-2), y2 * (-2), z2 * (-2)],
    [1, x3 * (-2), y3 * (-2), z3 * (-2)],
    [1, x4 * (-2), y4 * (-2), z4 * (-2)],
  ]);
  final matrix3 = Matrix.fromList([
    [sqrt(d1!) - sqrt(x1) - sqrt(y1) - sqrt(z1)],
    [sqrt(d2!) - sqrt(x2) - sqrt(y2) - sqrt(z2)],
    [sqrt(d2!) - sqrt(x3) - sqrt(y3) - sqrt(z3)],
    [sqrt(d1!) - sqrt(x1) - sqrt(y1) - sqrt(z1)],
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
      (csum.toStringAsFixed(2)).toString() +
      rssi1.toString() +
      rssi2.toString());

  // if (rssi1 != null && rssi2 != null && rssi3 != null && rssi4 != null)
  //   return ("null".toString());
  // else
  //   return (matrix11Tit3.toString());
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

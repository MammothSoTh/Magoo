import 'dart:math';

import 'package:ml_linalg/linalg.dart';

String powerrssi(int s) {
  return "_s" + s.toString();
}

String distance(int rssi) {
  double n;
  int A;
  n = 2.4;
  A = -79;

  return "distance = " +
      (pow(10, ((A - rssi) / (10 * n)))).toStringAsFixed(3) +
      " m.";
}

String position(rssi) {
  int x1 = 85,
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
    [1, x1 * (-2), y1 * (-2), z1 * (-2)],
    [1, x2 * (-2), y2 * (-2), z2 * (-2)],
    [1, x3 * (-2), y3 * (-2), z3 * (-2)],
  ]);
  // final matrix2 = Matrix.fromList([
  //   //[(x * x) + (y * y) + (z * z)],
  //   [x],
  //   [y],
  //   [z],
  // ]);
  final matrix3 = Matrix.fromList([
    [4],
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
          (asum.toStringAsFixed(2)) +
          "," +
          (bsum.toStringAsFixed(2)) +
          "," +
          (csum.toStringAsFixed(2)).toString());
  // ","
}

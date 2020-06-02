import 'package:flutter/material.dart';

class Styles {
  Styles._();

  static const TextStyle whiteText = TextStyle(color: Colors.white);
  static const TextStyle errorText = TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900);

  static const EdgeInsetsGeometry paddingNone = const EdgeInsets.all(0);
  static const EdgeInsetsGeometry paddingAll = const EdgeInsets.all(16.0);
  static const EdgeInsetsGeometry paddingVerticalOnly = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0);
  static const EdgeInsetsGeometry paddingVerticalSymmetric =
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
  static const EdgeInsetsGeometry paddingOnlyRight = const EdgeInsets.only(right: 8.0);
  static const EdgeInsetsGeometry paddingOnlyLeft = const EdgeInsets.only(left: 8.0);
}

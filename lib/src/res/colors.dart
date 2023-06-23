import 'package:flutter/material.dart';

const Color incomeCardColor = Colors.blueGrey;
final Color expenseCardColor = Colors.red[100];
const Color inComeColor = Colors.green;
const Color expenseColor = Colors.red;

const Color primary = Colors.blueGrey;
final Color messageColor = Colors.blue[900];
const Color fontColor = Colors.black;
const Color subtitleColor = Colors.grey;

final Color dataRowColor = Colors.grey[300];
final Color dataHeadingColor = Colors.blueGrey[50];

/// Construct a color from a hex code string, of the format #RRGGBB.
Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

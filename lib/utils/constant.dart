import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constanst {
  static double defaultMarginPadding = 16.0;
  static double sizeTitle = 20.0;
  static double sizeText = 14.0;
  static Color colorWhite = Colors.white;
  static Color colorBlack = Colors.black;
  static Color colorBlue = Colors.blue;

  static String convertDate(String date) {
    DateTime convert = DateTime.parse(date);
    var outputDate = DateFormat('EEEE, dd-MM-yyyy');
    return outputDate.format(convert);
  }

  static String convertDateSimpanLaundry(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String convertGetMonth(String date) {
    DateTime convert = DateTime.parse(date);
    var outputDate = DateFormat('MM');
    return outputDate.format(convert);
  }
}

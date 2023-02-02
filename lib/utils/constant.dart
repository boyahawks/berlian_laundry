import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constanst {
  static double defaultMarginPadding = 16.0;
  static double sizeTitle = 20.0;
  static double sizeText = 14.0;
  static Color colorWhite = Colors.white;
  static Color colorBlack = Colors.black;
  static Color colorBlue = Colors.blue;
  static Color colorPrimary = Color.fromARGB(255, 1, 26, 47);

  static String convertDate(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);
    var hari = DateFormat('EEEE');
    var tanggal = DateFormat('dd-MM-yyyy');
    var convertHari = hari.format(inputDate);
    var hasilConvertHari = hariIndo(convertHari);
    var valid2 = tanggal.format(inputDate);
    var validFinal = "$hasilConvertHari, $valid2";
    return validFinal;
  }

  static String convertDateSimpanLaundry(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String convertPrintStruk(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var inputDate = inputFormat.parse(date);
    var hari = DateFormat('EEEE');
    var tanggal = DateFormat('dd-MM-yyyy');
    var convertHari = hari.format(inputDate);
    var hasilConvertHari = hariIndo(convertHari);
    var valid2 = tanggal.format(inputDate);
    var validFinal = "$hasilConvertHari, $valid2";
    return validFinal;
  }

  static String convertGetMonth(String date) {
    DateTime convert = DateTime.parse(date);
    var outputDate = DateFormat('MM');
    return outputDate.format(convert);
  }

  // BORDER RADIUS
  static BorderRadius borderStyle1 = BorderRadius.only(
      topLeft: Radius.circular(6),
      topRight: Radius.circular(6),
      bottomLeft: Radius.circular(6),
      bottomRight: Radius.circular(6));

  static BorderRadius borderStyle2 = BorderRadius.only(
      topLeft: Radius.circular(8),
      topRight: Radius.circular(8),
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8));

  static BorderRadius borderStyle3 = BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16));

  static BorderRadius borderStyle4 = BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(24),
      bottomRight: Radius.circular(24));

  static int validasiValueint(String value) {
    var vld1 = value.replaceAll(",", "");
    var vld2 = vld1.replaceAll(".", "");
    var val3 = int.parse(vld2);
    return val3;
  }

  static double validasiValueDouble(String value) {
    var vld1 = value.replaceAll(",", ".");
    var vld2 = vld1.replaceAll(".", ".");
    var val3 = double.parse(vld2);
    return val3;
  }

  static double convertStringRpToDouble(String value) {
    var filter1 = value.replaceAll("Rp", "");
    var filter2 = filter1.replaceAll(" ", "");
    var filter3 = filter2.replaceAll(".", "");
    var filter4 = filter3.replaceAll(",", ".");
    var valueFinal = double.parse(filter4);
    return valueFinal;
  }

  static String hariIndo(String hari) {
    if (hari == "Monday") {
      hari = "Senin";
    } else if (hari == "Tuesday") {
      hari = "Selasa";
    } else if (hari == "Wednesday") {
      hari = "Rabu";
    } else if (hari == "Thursday") {
      hari = "Kamis";
    } else if (hari == "Friday") {
      hari = "Jumat";
    } else if (hari == "Saturday") {
      hari = "Sabtu";
    } else if (hari == "Sunday") {
      hari = "Minggu";
    } else {
      hari = hari;
    }
    return hari;
  }
}

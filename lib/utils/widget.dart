// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:berlian_laundry/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class UtilsAlert {
  static showAlert(BuildContext context, value) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Center(
              child: Text(value),
            )
          ],
        ),
      ),
      actions: [okButton],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showLoadingIndicator(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: SizedBox(
              width: 50,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                        child: Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Constanst.colorPrimary,
                            ),
                            width: 35,
                            height: 35),
                        padding: EdgeInsets.only(bottom: 16)),
                    Padding(
                        child: Text(
                          'Please wait …',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.only(bottom: 4))
                  ]),
            ));
      },
    );
  }

  static showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 12);
  }

  static keluarApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Center(child: Text("Logout ?", textAlign: TextAlign.center)),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              },
            )
          ],
        );
      },
    );
  }

  static toastSukses(BuildContext context, message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static toastGagal(BuildContext context) {
    return Fluttertoast.showToast(
        msg: "Terjadi Kesalahan Harap Hubungi Admin...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static loadingContent() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
          Padding(
              child: Container(
                  child: CircularProgressIndicator(strokeWidth: 3),
                  width: 35,
                  height: 35),
              padding: EdgeInsets.only(bottom: 16)),
          Padding(
              child: Text(
                'Please wait …',
                style: TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.only(bottom: 4))
        ]));
  }

  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static shimmerOnDashboard(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                width: 100,
                height: 30,
                child: Card(child: ListTile(title: Text(''))),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Card(child: ListTile(title: Text(''))),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.only(right: 10),
                child: Card(child: ListTile(title: Text(''))),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.only(right: 10),
                child: Card(child: ListTile(title: Text(''))),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.only(right: 10),
                child: Card(child: ListTile(title: Text(''))),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.only(right: 10),
                child: Card(child: ListTile(title: Text(''))),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 13),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 100,
                            color: Colors.grey)),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 100,
                            color: Colors.grey)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

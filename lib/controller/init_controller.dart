import 'dart:convert';
import 'package:berlian_laundry/screen/admin/dashboard_admin.dart';
import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/app_data.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InitController extends GetxController {
  var status = 0.obs;

  void loadDashboard() async {
    var statusLogin = AppData.statusLogin;
    var email = AppData.email;
    if (statusLogin == false) {
      await Future.delayed(const Duration(seconds: 3));
      Get.offAll(Dashboard());
    } else {
      verifUser(email);
    }
  }

  void verifUser(email) {
    Map<String, dynamic> body = {'val': "email", 'cari': email};
    var connect = Api.connectionApi("post", body, "getOnce-users");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          if (element['status'] == 1) {
            await Future.delayed(const Duration(seconds: 3));
            Get.offAll(DashboardAdmin());
          } else {
            await Future.delayed(const Duration(seconds: 3));
            Get.offAll(Dashboard());
          }
        }
      }
    });
  }
}

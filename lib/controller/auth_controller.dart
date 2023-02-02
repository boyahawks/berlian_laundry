import 'dart:convert';
import 'dart:io';

import 'package:berlian_laundry/screen/admin/dashboard_admin.dart';
import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/screen/login.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/app_data.dart';
import 'package:berlian_laundry/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AuthController extends GetxController {
  var username = TextEditingController().obs;
  var password = TextEditingController().obs;
  var email = TextEditingController().obs;
  var nohp = TextEditingController().obs;
  var showpassword = false.obs;
  var statusValidasiEmail = false.obs;

  var emailValidasi = "".obs;

  Future<dynamic> validasiEmail() async {
    Map<String, dynamic> body = {'val': "email", 'cari': email.value.text};
    var connect = Api.connectionApi("post", body, "getOnce-users");
    var status = connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['data'].isEmpty) {
          return false;
        } else {
          return true;
        }
      }
    });
    return status;
  }

  bool validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return false;
    else
      return true;
  }

  void registrasiUser() async {
    Map<String, dynamic> body = {
      'username': username.value.text,
      'password': password.value.text,
      'email': email.value.text,
      'no_hp': nohp.value.text,
      'tanggal_daftar': "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
    };
    var connect = Api.connectionApi("post", body, "registerUser");
    var getValue = await connect;
    var valueBody = jsonDecode(getValue.body);
    if (valueBody['status'] == true) {
      username.value.text == "";
      email.value.text == "";
      nohp.value.text == "";
      password.value.text == "";
      UtilsAlert.showToast("Berhasil Registrasi");
      Get.back();
      Get.offAll(Login());
    } else {
      UtilsAlert.showToast("Gagal registrasi");
      Get.back();
    }
  }

  void validasiLogin() {
    Map<String, dynamic> body = {
      'email': email.value.text,
      'password': password.value.text
    };
    var connect = Api.connectionApi("post", body, "validasiLogin");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['status'] == true) {
          if (valueBody['password'] == false) {
            UtilsAlert.showToast("User tidak di temukan");
            Navigator.pop(Get.context!);
          } else {
            AppData.username = valueBody['data'][0]['username'];
            AppData.email = valueBody['data'][0]['email'];
            AppData.statusLogin = true;
            if (valueBody['data'][0]['status'] == 2) {
              UtilsAlert.showToast("Berhasil login");
              Get.offAll(Dashboard());
            } else if (valueBody['data'][0]['status'] == 1) {
              UtilsAlert.showToast("Berhasil login");
              Get.offAll(DashboardAdmin());
            }
          }
        } else {
          UtilsAlert.showToast("User tidak di temukan");
          Navigator.pop(Get.context!);
        }
      }
    });
  }
}

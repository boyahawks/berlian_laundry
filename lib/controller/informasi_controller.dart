import 'dart:convert';

import 'package:berlian_laundry/utils/api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class InformasiController extends GetxController {
  var informasi = [].obs;

  void onInit() async {
    getInformasi();
    super.onInit();
  }

  void getInformasi() {
    var connect = Api.connectionApi("get", {}, "informasi");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          if (element['type'] == 2) {
            informasi.value.add(element);
          }
          this.informasi.refresh();
        }
      }
    });
  }
}

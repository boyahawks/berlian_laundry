import 'dart:convert';

import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/widget.dart';
import 'package:get/get.dart';

class ApiController extends GetxController {
  Future<List> tambahDataMenu(List dataInsert) async {
    Map<String, dynamic> bodyRequest = {
      'id_kategori': dataInsert[0],
      'nama': dataInsert[1],
      'kategori': dataInsert[2],
      'harga': dataInsert[3],
    };
    var connect = Api.connectionApi("post", bodyRequest, "insert-menu");
    var getValue = await connect;
    var valueBody = jsonDecode(getValue.body);
    List dataFinal = [];
    if (valueBody['status'] == true) {
      dataFinal = [true, valueBody['status']];
    } else {
      dataFinal = [false, valueBody['status']];
    }
    return Future.value(dataFinal);
  }

  Future<List> jadikanMember(
      String idUser, int statusMember, String jumlahKg) async {
    UtilsAlert.loadingContent();
    Map<String, dynamic> bodyRequest = {
      'id_user': idUser,
      'status_member': statusMember,
      'jumlah_kg': jumlahKg,
    };
    var connect = Api.connectionApi("post", bodyRequest, "jadikan_member");
    var getValue = await connect;
    var valueBody = jsonDecode(getValue.body);
    List dataFinal = [];
    print(valueBody);
    if (valueBody['status'] == true) {
      dataFinal = [true, valueBody['message']];
    } else {
      dataFinal = [false, valueBody['message']];
    }
    Get.back();
    return Future.value(dataFinal);
  }

  Future<List> getSpesifikData(String tabelName, String valueColumn,
      String valueCari, String endpoint) async {
    Map<String, dynamic> body = {
      'stringTabel': tabelName,
      'column': valueColumn,
      'cari': valueCari,
    };
    var connect = Api.connectionApi("post", body, endpoint);
    var getValue = await connect;
    var valueBody = jsonDecode(getValue.body);
    List data = valueBody['data'];
    List dataFinal = [];
    if (data.isNotEmpty) {
      dataFinal = [true, valueBody['status'], valueBody['data']];
    } else {
      dataFinal = [false, valueBody['status']];
    }
    return Future.value(dataFinal);
  }
}

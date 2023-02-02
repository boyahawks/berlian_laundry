import 'dart:convert';

import 'package:http/http.dart';

class Api {
  static var basicAuth = 'Basic ' +
      base64Encode(utf8.encode('aplikasiLaundry:6289686113476@laundry#90@'));

  // https://laundryapp.aksaramerakinusantara.com/

  // static var basicUrl = "https://laundryapi.aksaramerakinusantara.com/";
  static var basicUrl = "https://laundryapi.aksaramerakinusantara.com/";
  static var urlAssets = basicUrl + "assets_berlian/";
  static var urlAssetsBanner = urlAssets + "banner/";
  static var urlAssetsNota = urlAssets + "nota/";
  static var urlAssetsLaporan = urlAssets + "laporan/";
  static var urlAssetsInformasi = basicUrl + "foto_informasi/";

  // node js
  // GET

  // POST

  static Future connectionApi(
      String typeConnect, valFormData, String url) async {
    var getUrl = basicUrl + url;
    Map<String, String> headers = {
      'Authorization': basicAuth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (typeConnect == "post") {
      final url = Uri.parse(getUrl);
      final response =
          await post(url, body: jsonEncode(valFormData), headers: headers);
      return response;
    } else {
      final url = Uri.parse(getUrl);
      final response = await get(url, headers: headers);
      return response;
    }
  }
}

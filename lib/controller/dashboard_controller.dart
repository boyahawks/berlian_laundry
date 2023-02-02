import 'dart:convert';
import 'dart:io';

import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/app_data.dart';
import 'package:berlian_laundry/utils/constant.dart';
import 'package:berlian_laundry/utils/widget.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardController extends GetxController {
  CarouselController corouselDashboard = CarouselController();

  var cari = TextEditingController().obs;

  var banner = [].obs;
  var riwayatLaundry = [].obs;
  var kategoriLaundry = [].obs;
  var menuLaundry = [].obs;
  var menuSelected = [].obs;

  var informasiTutup = "".obs;
  var informasiPengembangan = "".obs;
  var noWaAdmin = "".obs;

  var idKategoriSelected = 0.obs;

  var statusPencarian = false.obs;
  var statusload = false.obs;

  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  int limit = 5;

  void onInit() async {
    getBanner();
    getInformasi();
    getKategori();
    getMenu();
    getRiwayatLaundry();
    getKontak();
    super.onInit();
  }

  void getBanner() {
    var connect = Api.connectionApi("get", {}, "banner");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          if (element['kategori'] == 1) {
            banner.value.add(element['image_url']);
          }
        }
      }
    });
  }

  void getKontak() {
    var connect = Api.connectionApi("get", {}, "kontak");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          if (element['status'] == 1) {
            noWaAdmin.value = element['nohp'];
          }
        }
      }
    });
  }

  void getKategori() {
    var connect = Api.connectionApi("get", {}, "kategori");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          kategoriLaundry.value.add(element);
        }
      }
    });
  }

  void getMenu() {
    var connect = Api.connectionApi("get", {}, "menu");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          menuLaundry.value.add(element);
        }
      }
    });
  }

  void convertMenu() {
    menuSelected.value.clear();
    for (var element in menuLaundry.value) {
      if (element['id_kategori'] == idKategoriSelected.value) {
        menuSelected.value.add(element);
      }
    }
    this.menuSelected.refresh();
  }

  void getInformasi() {
    var connect = Api.connectionApi("get", {}, "informasi");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          if (element['type'] == 1) {
            if (element['status'] == 1) {
              informasiTutup.value = element['informasi'];
            } else if (element['status'] == 0) {
              informasiTutup.value =
                  "Berlian Laundry \n A Clean is Your Choice";
            }
          }
          if (element['type'] == "2") {
            informasiPengembangan.value = element['informasi'];
          }
        }
      }
    });
  }

  void closePencarian() {
    statusPencarian.value = false;
    cari.value.text = "";
    riwayatLaundry.value.clear();
  }

  void getRiwayatLaundry() {
    print("get riwayat");
    if (cari.value.text != "") {
      statusPencarian.value = true;
      riwayatLaundry.value.clear();
      loadRiwayatLaundry();
    } else {
      loadRiwayatLaundry();
    }
  }

  void loadRiwayatLaundry() {
    statusload.value = true;
    statusload.refresh();
    Map<String, dynamic> body = {
      'offset': "${riwayatLaundry.value.length}",
      'limit': "$limit",
      'cari': cari.value.text,
    };
    var connect = Api.connectionApi("post", body, "riwayatLaundry");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        print(valueBody['data'].length);
        if (valueBody['data'].length == 0) {
          UtilsAlert.showToast("Selesai load data...");
          statusload.value = false;
          statusload.refresh();
        } else {
          for (var element in valueBody['data']) {
            riwayatLaundry.value.add(element);
          }
        }
        this.riwayatLaundry.refresh();
      }
    });
  }

  void kirimPesanWa() async {
    if (AppData.username == "") {
      UtilsAlert.showToast("Harap login terlebih dahulu...");
    } else {
      var gabunganPesan =
          "Hallo Admin, saya ${AppData.username} ingin bertanya seputar laundry...";
      var notujuan = noWaAdmin.value;
      var filternohp = notujuan.substring(1);
      var kodeNegara = 62;
      var gabungNohp = "$kodeNegara$filternohp";
      print(gabunganPesan);
      print(gabungNohp);

      var whatsappURl_android =
          "whatsapp://send?phone=" + gabungNohp + "&text=" + gabunganPesan;
      var whatappURL_ios =
          "https://wa.me/$gabungNohp?text=${Uri.parse(gabunganPesan)}";

      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunch(whatappURL_ios)) {
          await launch(whatappURL_ios, forceSafariVC: false);
        } else {
          UtilsAlert.toastSukses(Get.context!, "Whatsapp no installed");
        }
      } else {
        // android , web
        if (await canLaunch(whatsappURl_android)) {
          await launch(whatsappURl_android);
        } else {
          UtilsAlert.toastSukses(Get.context!, "Whatsapp no installed");
        }
      }
    }
  }

  detilRiwayat(context, detil, harga) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          content: Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 250, 249, 249),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Detail Riwayat"),
                  ),
                  SizedBox(height: 10),
                  Text("Kode :"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${detil['kode_pesan']}"),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Nama :"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${detil['username']}"),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Jumlah :"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${detil['jumlah']} ${detil['kategori']}"),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Total :"),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "${NumberFormat.currency(locale: 'eu', symbol: 'IDR').format(int.parse(harga))}"),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Tanggal Masuk :"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${Constanst.convertDate(detil['tanggal_masuk'])}"),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Tanggal Selesai :"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${Constanst.convertDate(detil['tanggal_selesai'])}"),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Status :"),
                  SizedBox(
                    height: 5,
                  ),
                  detil['status'] == "1"
                      ? Text(
                          "Sedang Proses",
                          style: TextStyle(
                              fontSize: Constanst.sizeText,
                              color: Colors.orange),
                        )
                      : detil['status'] == "2"
                          ? Text(
                              "Selesai",
                              style: TextStyle(
                                  fontSize: Constanst.sizeText,
                                  color: Colors.blue),
                            )
                          : detil['status'] == "3"
                              ? Text(
                                  "Sudah di ambil",
                                  style: TextStyle(
                                      fontSize: Constanst.sizeText,
                                      color: Colors.green),
                                )
                              : SizedBox(),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  Text("Diambil :"),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text("${detil['diambil']}"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Tutup"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}

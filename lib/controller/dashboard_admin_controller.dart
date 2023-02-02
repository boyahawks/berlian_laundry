import 'dart:convert';
import 'dart:io';
import 'package:berlian_laundry/controller/api_controller.dart';
import 'package:berlian_laundry/controller/button_shett_controller.dart';
import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/app_data.dart';
import 'package:berlian_laundry/utils/constant.dart';
import 'package:berlian_laundry/utils/widget.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardAdminController extends GetxController {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  var cari = TextEditingController().obs;
  var idMenu = TextEditingController().obs;
  var namaMenu = TextEditingController().obs;
  var kategoriMenu = TextEditingController().obs;
  var hargaMenu = TextEditingController().obs;
  var informasi = TextEditingController().obs;
  var addInformasi = TextEditingController().obs;
  var tanggalMulai = TextEditingController().obs;
  var tanggalSampai = TextEditingController().obs;
  var kgMember = TextEditingController().obs;

  // tambah menu

  var allUser = [].obs;
  var allHistory = [].obs;
  var riwayatLaundry = [].obs;
  var kategoriLaundry = [].obs;
  var menuLaundry = [].obs;
  var menuSelected = [].obs;
  var informasiAllUser = [].obs;
  var informasiDashboard = {}.obs;

  var fotoInformasi = File("").obs;

  var username = "".obs;
  var iconMenu = "".obs;
  var iconInformasi = "".obs;
  var filePdfLaporan = "".obs;
  var base64fotoInformasi = "".obs;
  var namaFileInformasi = "".obs;
  var dropdownKategoriMenuTambah = "KILOAN".obs;

  var jumlahBulanIni = 0.obs;
  var jumlahHistoryBulanIni = 0.obs;
  var statusLaundrySelected = 0.obs;
  var idInformasiDashboard = 0.obs;
  var idInformasiAlluserSelected = 0.obs;
  var idkategoriMenuSelected = 1.obs;

  var statusCariUser = false.obs;
  var statusCariHistory = false.obs;
  var viewInformasiDashboard = false.obs;
  var viewInformasiAllUser = false.obs;
  var viewPrintLaporan = false.obs;
  var imageStatus = false.obs;

  int limit = 5;
  int penukaran = 20;

  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  void onInit() async {
    username.value = AppData.username;
    getIcon();
    getUsers();
    getTotalBulanIni();
    getKategori();
    getMenu();
    getInformasi();
    super.onInit();
  }

  void onRefresh() {
    allUser.value.clear();
    allHistory.value.clear();
    riwayatLaundry.value.clear();
    kategoriLaundry.value.clear();
    menuLaundry.value.clear();
    menuSelected.value.clear();
    informasiAllUser.value.clear();
  }

  void getIcon() {
    var connect = Api.connectionApi("get", {}, "banner");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          if (element['kategori'] == 2) {
            if (element['image_url'] == "ic_menu.png") {
              iconMenu.value = element['image_url'];
            } else if (element['image_url'] == "ic_informasi.png") {
              iconInformasi.value = element['image_url'];
            }
          }
        }
      }
    });
  }

  void getUsers() {
    var connect = Api.connectionApi("get", {}, "users");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        List tampung = [];
        for (var element in valueBody['data']) {
          tampung.add(element);
        }
        allUser.value = tampung;
        allUser.refresh();
      }
    });
  }

  void getInformasi() {
    var connect = Api.connectionApi("get", {}, "informasi");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          if (element['type'] == 1) {
            informasiDashboard.value = element;
          } else if (element['type'] == 2) {
            informasiAllUser.value.add(element);
          }
        }

        this.informasiAllUser.refresh();
      }
    });
  }

  void aksiUpdateInformasiDashboard() {
    if (informasiDashboard['status'] == 0) {
      idInformasiDashboard.value = 1;
    } else {
      idInformasiDashboard.value = 0;
    }
    Map<String, dynamic> body = {
      'val': 'id_informasi',
      'cari': "${informasiDashboard['id_informasi']}",
      'informasi': "${informasi.value.text}",
      'status': "$idInformasiDashboard",
    };
    var connect = Api.connectionApi("post", body, "editWhereOnce-informasi");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        print(valueBody['data']);
        if (valueBody['status'] == true) {
          UtilsAlert.showToast("Informasi dashboard berhasil di update");
        }
        informasiDashboard.value = {};
        informasiAllUser.value.clear();
        viewInformasiDashboard.value = false;
        getInformasi();
        Navigator.pop(Get.context!, true);
      }
    });
  }

  void deleteInformasiUser() {
    Map<String, dynamic> body = {
      'val': 'id_informasi',
      'cari': "${idInformasiAlluserSelected.value}"
    };
    var connect = Api.connectionApi("post", body, "delete-informasi");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        print(valueBody['data']);
        if (valueBody['status'] == true) {
          UtilsAlert.showToast("Informasi user berhasil di hapus");
        }
        informasiDashboard.value = {};
        informasiAllUser.value.clear();
        viewInformasiAllUser.value = false;
        getInformasi();
        Navigator.pop(Get.context!, true);
      }
    });
  }

  void getTotalBulanIni() {
    var connect = Api.connectionApi("get", {}, "totalBulanIni");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        jumlahBulanIni.value = valueBody['totalBulanIni'];
        jumlahHistoryBulanIni.value = valueBody['totalRiwayatBulanIni'];
      }
    });
  }

  void cariUser() {
    allUser.value.clear();
    Map<String, dynamic> body = {'cari': cari.value.text};
    var connect = Api.connectionApi("post", body, "cariUser");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          allUser.value.add(element);
        }
        this.allUser.refresh();
      }
    });
  }

  void deleteMenu(id) {
    Map<String, dynamic> body = {'val': 'id_menu', 'cari': '$id'};
    var connect = Api.connectionApi("post", body, "delete-menu");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['status'] == true) {
          UtilsAlert.showToast(valueBody['message']);
          menuLaundry.value.clear();
          menuSelected.value.clear();
        }
        getMenu();
        chooseMenu();
        this.menuSelected.refresh();
        Navigator.pop(Get.context!, true);
      }
    });
  }

  void cariHistoryLaundry() {
    UtilsAlert.showLoadingIndicator(Get.context!);
    riwayatLaundry.value.clear();
    Map<String, dynamic> body = {'cari': cari.value.text};
    var connect = Api.connectionApi("post", body, "cariRiwayatAdmin");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          riwayatLaundry.value.add(element);
        }
        this.riwayatLaundry.refresh();
        Navigator.pop(Get.context!, true);
      }
    });
  }

  void penukaranPoint(email) {
    UtilsAlert.showLoadingIndicator(Get.context!);
    for (var element in allUser) {
      if (element['email'] == email) {
        var convertPoint = int.parse(element['point']);
        int akumulasi = convertPoint - penukaran;
        Map<String, dynamic> body = {
          'val': 'email',
          'cari': email,
          'point': '$akumulasi'
        };
        var connect = Api.connectionApi("post", body, "editWhereOnce-users");
        connect.then((dynamic res) async {
          if (res.statusCode == 200) {
            var valueBody = jsonDecode(res.body);
            if (valueBody['status'] == true) {
              allUser.value.clear();
              getUsers();
              UtilsAlert.showToast("Penukaran berhasil...");
              Navigator.pop(Get.context!);
              Navigator.pop(Get.context!);
            }
          }
        });
      }
    }
  }

  void loadRiwayatLaundry() {
    var connect = Api.connectionApi("get", {}, "riwayatLaundryAdmin");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          if (statusLaundrySelected.value == 1) {
            if (element['status'] == "1") {
              riwayatLaundry.value.add(element);
            }
          } else if (statusLaundrySelected.value == 2) {
            if (element['status'] == "2") {
              riwayatLaundry.value.add(element);
            }
          } else if (statusLaundrySelected.value == 3) {
            if (element['status'] == "3") {
              riwayatLaundry.value.add(element);
            }
          }
        }
        this.riwayatLaundry.refresh();
      }
    });
  }

  void changeToSelesai(detil) {
    riwayatLaundry.value.clear();
    Map<String, dynamic> body = {
      'val': 'id_laundry',
      'cari': '${detil["id_laundry"]}',
      'status': '2'
    };
    aksiChangeRiwayat(body);
  }

  void aksiChangeRiwayat(body) {
    var connect =
        Api.connectionApi("post", body, "editWhereOnce-riwayat_laundry");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['status'] == true) {
          print("berhasil1");
          UtilsAlert.showToast("Data berhasil di update");
          Navigator.pop(Get.context!, true);
        } else {
          print("berhasil 2");
          UtilsAlert.showToast("Data gagal di update");
          Navigator.pop(Get.context!, true);
        }
        loadRiwayatLaundry();
        this.riwayatLaundry.refresh();
      }
    });
  }

  void changeToDiambil(detil) {
    DateTime now = DateTime.now();
    var outputDate = DateFormat('EEEE, dd-MM-yyyy hh:mm');
    var convert = outputDate.format(now);
    riwayatLaundry.value.clear();
    Map<String, dynamic> body = {
      'val': 'id_laundry',
      'cari': '${detil["id_laundry"]}',
      'status': '3',
      'pembayaran': '2',
      'diambil': '$convert'
    };
    aksiChangeRiwayat(body);
  }

  void getKategori() {
    var connect = Api.connectionApi("get", {}, "kategori");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        for (var element in valueBody['data']) {
          var data = {
            "id_kategori": element['id_kategori'],
            "nama_kategori": element['nama_kategori'],
            "is_active": false
          };
          kategoriLaundry.value.add(data);
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
      chooseMenu();
    });
  }

  void chooseMenu() {
    kategoriLaundry.value.forEach((element) {
      if (element['id_kategori'] == idkategoriMenuSelected.value) {
        element['is_active'] = true;
      } else {
        element['is_active'] = false;
      }
    });
    menuSelected.value.clear();
    menuLaundry.forEach((element) {
      if (element['id_kategori'] == idkategoriMenuSelected.value) {
        menuSelected.value.add(element);
      }
    });
    this.menuSelected.refresh();
    this.kategoriLaundry.refresh();
  }

  void updateMenu() {
    menuSelected.value.clear();
    menuLaundry.value.clear();
    Map<String, dynamic> body = {
      'val': 'id_menu',
      'cari': '${idMenu.value.text}',
      'nama': '${namaMenu.value.text}',
      'kategori': '${kategoriMenu.value.text}',
      'harga': '${hargaMenu.value.text}',
    };
    var connect = Api.connectionApi("post", body, "editWhereOnce-menu");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['status'] == true) {
          UtilsAlert.showToast("Data berhasil di update");
          Navigator.pop(Get.context!, true);
        }
        getMenu();
        this.menuSelected.refresh();
      }
    });
  }

  void aksiTambahInformasiUser() {
    UtilsAlert.showLoadingIndicator(Get.context!);
    Map<String, dynamic> body = {
      'informasi': '${addInformasi.value.text}',
      'nama_foto': namaFileInformasi.value,
      'gambar': base64fotoInformasi.value,
      'type': '2',
      'status': '1',
      'date_publish': "${DateFormat('yyyy-MM-dd').format(DateTime.now())}"
    };
    var connect = Api.connectionApi("post", body, "insert-informasi");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['status'] == true) {
          viewInformasiAllUser.value = false;
          informasiAllUser.value.clear();
          informasiDashboard.value = {};
          this.informasiAllUser.refresh();
          getInformasi();
          Get.back();
          Get.back();
          UtilsAlert.showToast("Data berhasil tambah informasi");
        }
      }
    });
  }

  void tambahDataMenu() async {
    namaMenu.value.text = "";
    hargaMenu.value.text = "";
    kategoriMenu.value.text = "";
    ButtonSheetController().validasiButtonSheet(
        "Tambah Menu", kontenTambahMenu(), "tambah_menu", () async {
      if (namaMenu.value.text == "" ||
          hargaMenu.value.text == "" ||
          kategoriMenu.value.text == "") {
        UtilsAlert.showToast("Lengkapi form terlebih dahulu");
      } else {
        UtilsAlert.loadingContent();
        var idKategoriMenu = dropdownKategoriMenuTambah.value == "KILOAN"
            ? "1"
            : dropdownKategoriMenuTambah.value == "BEDDING"
                ? "2"
                : dropdownKategoriMenuTambah.value == "SPESIAL ITEM"
                    ? "3"
                    : dropdownKategoriMenuTambah.value == "PAKET BULANAN"
                        ? "4"
                        : "0";
        int convertHarga = int.parse(hargaMenu.value.text.replaceAll(".", ""));
        List dataInsert = [
          idKategoriMenu,
          namaMenu.value.text,
          kategoriMenu.value.text,
          convertHarga
        ];
        Future<List> insertDataMenu =
            ApiController().tambahDataMenu(dataInsert);
        List hasilInsert = await insertDataMenu;
        if (hasilInsert[0]) {
          getMenu();
          chooseMenu();
          menuSelected.refresh();
          UtilsAlert.showToast("Berhasil tambah data !");
          Get.back();
        } else {
          UtilsAlert.showToast("Gagal tambah data !");
        }
      }
    });
  }

  Widget kontenTambahMenu() {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nama Menu"),
          SizedBox(
            height: 6,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: Constanst.borderStyle2,
                border: Border.all(width: 1.0, color: Colors.black)),
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: TextField(
                cursorColor: Colors.black,
                controller: namaMenu.value,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(height: 1.5, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text("Satuan"),
          SizedBox(
            height: 6,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: Constanst.borderStyle2,
                border: Border.all(width: 1.0, color: Colors.black)),
            child: TextField(
              cursorColor: Colors.black,
              controller: kategoriMenu.value,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(height: 1.5, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text("Harga"),
          SizedBox(
            height: 6,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: Constanst.borderStyle2,
                border: Border.all(width: 1.0, color: Colors.black)),
            child: TextField(
              inputFormatters: [
                CurrencyTextInputFormatter(
                  locale: 'id',
                  symbol: '',
                  decimalDigits: 0,
                )
              ],
              cursorColor: Colors.black,
              controller: hargaMenu.value,
              keyboardType: TextInputType.numberWithOptions(signed: true),
              textInputAction: TextInputAction.done,
              decoration: new InputDecoration(border: InputBorder.none),
              style: TextStyle(height: 1.5, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text("Kategori"),
          SizedBox(
            height: 6,
          ),
          Container(
            width: MediaQuery.of(Get.context!).size.width,
            height: 50,
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: Constanst.borderStyle2,
                border: Border.all(width: 1.0, color: Colors.black)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownKategoriMenuTambah.value,
                items: <String>[
                  'KILOAN',
                  'BEDDING',
                  'SPESIAL ITEM',
                  'PAKET BULANAN'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (newValue) {
                  setState(() {
                    dropdownKategoriMenuTambah.value = newValue!;
                    dropdownKategoriMenuTambah.refresh();
                  });
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  void showViewInformasiDashboard() {
    viewInformasiDashboard.value = !viewInformasiDashboard.value;
  }

  void showViewInformasiAlluser() {
    viewInformasiAllUser.value = !viewInformasiAllUser.value;
  }

  void showViewPrintLaporan() {
    viewPrintLaporan.value = !viewPrintLaporan.value;
  }

  void showPdfHistoryLaundry(kodePesan) {
    _launchURL() async =>
        await canLaunch(Api.urlAssetsNota + kodePesan + '.pdf')
            ? await launch(Api.urlAssetsNota + kodePesan + '.pdf')
            : throw UtilsAlert.showToast('Tidak dapat membuka');
    _launchURL();
  }

  void showPdfLaporanKeuangan() {
    _launchURL() async =>
        await canLaunch(Api.urlAssetsLaporan + filePdfLaporan.value)
            ? await launch(Api.urlAssetsLaporan + filePdfLaporan.value)
            : throw UtilsAlert.showToast('Tidak dapat membuka');
    _launchURL();
  }

  void printLaporanKeuangan() {
    filePdfLaporan.value = "";
    this.filePdfLaporan.refresh();
    String dateMasuk =
        Constanst.convertDateSimpanLaundry(tanggalMulai.value.text);
    String dateSelesai =
        Constanst.convertDateSimpanLaundry(tanggalSampai.value.text);
    Map<String, dynamic> body = {
      'tanggal_awal': '$dateMasuk',
      'tanggal_akhir': '$dateSelesai'
    };
    var connect = Api.connectionApi("post", body, "printLaporanKeuangan");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['status'] == true) {
          filePdfLaporan.value = valueBody['pdf'];
          UtilsAlert.showToast(valueBody['message']);
        }
        this.filePdfLaporan.refresh();
      }
    });
  }

  logout(context) {
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
                    child: Text("Logout Account...?"),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              // ignore: prefer_const_constructors
              child: Text("Logout"),
              onPressed: () {
                UtilsAlert.showToast("Success Logout Account");
                AppData.email = "";
                AppData.username = "";
                AppData.statusLogin = false;
                Get.offAll(Dashboard());
              },
            ),
          ],
        );
      },
    );
  }

  validasiInformasi(context, title, varian) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: Constanst.borderStyle2),
          content: Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 250, 249, 249),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  varian == 1
                      ? TextField(
                          controller: informasi.value,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 1,
                          style: TextStyle(
                              fontSize: 14.0, height: 2.0, color: Colors.black),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              // ignore: prefer_const_constructors
              child: Text("OK"),
              onPressed: () {
                if (varian == 1) {
                  aksiUpdateInformasiDashboard();
                } else if (varian == 2) {
                  deleteInformasiUser();
                }
              },
            ),
          ],
        );
      },
    );
  }

  addInformasiUser(context) {
    ButtonSheetController().validasiButtonSheet(
        "Tambah Informasi", contentInformasiUser(), "add_informasi_user", () {
      if (addInformasi.value.text != "") {
        aksiTambahInformasiUser();
      } else {
        UtilsAlert.showToast("Isi informasi terlebih dahulu");
      }
      ;
    });
  }

  Widget contentInformasiUser() {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 6,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: Constanst.borderStyle1,
                border: Border.all(color: Constanst.colorPrimary)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.black,
                controller: addInformasi.value,
                maxLines: null,
                maxLength: 225,
                decoration: new InputDecoration(
                    border: InputBorder.none, hintText: "Isi informasi"),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                style:
                    TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Constanst.colorPrimary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: Constanst.borderStyle2,
                  ))),
              onPressed: () {
                aksiAmbilFotoInformasi(setState);
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: !imageStatus.value
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.camera,
                              size: 20,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                "Ambil Foto",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "${namaFileInformasi.value}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      );
    });
  }

  void aksiAmbilFotoInformasi(setState) async {
    final getFoto = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 100,
        maxHeight: 350,
        maxWidth: 350);
    if (getFoto == null) {
      UtilsAlert.showToast("Gagal mengambil gambar");
    } else {
      setState(() {
        fotoInformasi.value = File(getFoto.path);
        var bytes = File(getFoto.path).readAsBytesSync();
        base64fotoInformasi.value = base64Encode(bytes);
        namaFileInformasi.value = "${getFoto.name}";
        imageStatus.value = true;
        fotoInformasi.refresh();
        base64fotoInformasi.refresh();
        namaFileInformasi.refresh();
        imageStatus.refresh();
      });
    }
  }

  detilUser(context, detil) {
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
                    child: Text("Penukaran Point"),
                  ),
                  SizedBox(height: 10),
                  Text("Username : ${detil['username']}"),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Point : ${detil['point']}"),
                  Divider(
                    height: 5,
                    color: Colors.grey,
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
            detil['status'] != 2
                ? SizedBox()
                : TextButton(
                    child: detil['member'] == 0
                        ? Text("Jadikan member")
                        : Text("Jadikan user biasa"),
                    onPressed: () {
                      detil['member'] == 0
                          ? ButtonSheetController().validasiButtonSheet(
                              "Jadikan Member ",
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, left: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: Constanst.borderStyle2,
                                        border: Border.all(
                                            width: 1.0, color: Colors.black)),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 10),
                                      child: TextField(
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        controller: kgMember.value,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "KG member"),
                                        style: TextStyle(
                                            height: 1.5, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      "Kamu yakin jadikan ${detil['username']} member berlian laundry ?")
                                ],
                              ),
                              "jadikan_member", () async {
                              int statusMember = detil['member'] == 0 ? 1 : 0;
                              if (kgMember.value.text == "") {
                                UtilsAlert.showToast(
                                    "Isi kg member terlebih dahulu");
                              } else {
                                Future<List> prosesJadikanMember =
                                    ApiController().jadikanMember(
                                        "${detil['id_user']}",
                                        statusMember,
                                        kgMember.value.text);
                                List hasilProses = await prosesJadikanMember;
                                if (hasilProses[0] == true) {
                                  UtilsAlert.showToast(hasilProses[1]);
                                  Get.back();
                                  getUsers();
                                } else {
                                  UtilsAlert.showToast(hasilProses[1]);
                                }
                              }
                            })
                          : ButtonSheetController().validasiButtonSheet(
                              "Jadikan Member Biasa",
                              Text(
                                  "Kamu yakin jadikan ${detil['username']} member biasa berlian laundry ?"),
                              "jadikan_member_biasa", () async {
                              int statusMember = detil['member'] == 0 ? 1 : 0;
                              Future<List> prosesJadikanMember = ApiController()
                                  .jadikanMember(
                                      "${detil['id_user']}", statusMember, "0");
                              List hasilProses = await prosesJadikanMember;
                              if (hasilProses[0] == true) {
                                UtilsAlert.showToast(hasilProses[1]);
                                Get.back();
                                getUsers();
                              } else {
                                UtilsAlert.showToast(hasilProses[1]);
                              }
                            });
                    },
                  ),
            TextButton(
              child: Text("Tukar"),
              onPressed: () {
                if (int.parse(detil['point']) < penukaran) {
                  UtilsAlert.showToast('Point user kurang');
                  Navigator.pop(context, true);
                } else {
                  penukaranPoint(detil['email']);
                }
              },
            ),
          ],
        );
      },
    );
  }

  hapusMenu(id) {
    showDialog(
      context: Get.context!,
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
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Yakin hapus menu...?",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
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
                deleteMenu(id);
              },
            ),
          ],
        );
      },
    );
  }

  detilMenu(context) {
    showDialog(
      barrierDismissible: false,
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
                    child: Text("Update Menu"),
                  ),
                  SizedBox(height: 10),
                  Text("Nama Menu"),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: namaMenu.value,
                    style: TextStyle(
                        fontSize: 14.0, height: 2.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Kategori"),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: kategoriMenu.value,
                    style: TextStyle(
                        fontSize: 14.0, height: 2.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Harga"),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: hargaMenu.value,
                    style: TextStyle(
                        fontSize: 14.0, height: 2.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
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
            TextButton(
              child: Text("Update"),
              onPressed: () {
                updateMenu();
              },
            ),
          ],
        );
      },
    );
  }

  gantiStatusHistory(context, detil) {
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
              child: detil['status'] == "1"
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          detil['kode_pesan'],
                          textAlign: TextAlign.center,
                        ),
                        Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "laundry sudah selesai ?",
                          textAlign: TextAlign.center,
                        ),
                        Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  : detil['status'] == "2"
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              detil['kode_pesan'],
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              height: 5,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "laundry sudah diambil ?",
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              height: 5,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              detil['kode_pesan'],
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              height: 5,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "laundry sudah diambil",
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              height: 5,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Tanggal : ${detil['diambil']}",
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              height: 5,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
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
            detil['status'] == "3"
                ? SizedBox()
                : TextButton(
                    child: Text("Submit"),
                    onPressed: () {
                      if (detil['status'] == "1") {
                        changeToSelesai(detil);
                      } else if (detil['status'] == "2") {
                        changeToDiambil(detil);
                      }
                    },
                  ),
          ],
        );
      },
    );
  }
}

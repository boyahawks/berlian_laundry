import 'dart:convert';
import 'package:berlian_laundry/screen/admin/dashboard_admin.dart';
import 'package:berlian_laundry/screen/admin/manage_laundry.dart';
import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/app_data.dart';
import 'package:berlian_laundry/utils/constant.dart';
import 'package:berlian_laundry/utils/widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LaundryController extends GetxController {
  var cari = TextEditingController().obs;

  var idUser = TextEditingController().obs;
  var username = TextEditingController().obs;
  var email = TextEditingController().obs;
  var nohp = TextEditingController().obs;
  var member = TextEditingController().obs;
  var kgUser = TextEditingController().obs;
  var pointUser = TextEditingController().obs;

  var usernameRegis = TextEditingController().obs;
  var passwordRegis = TextEditingController().obs;
  var emailRegis = TextEditingController().obs;
  var nohpRegis = TextEditingController().obs;

  var idMenu = TextEditingController().obs;
  var namaMenu = TextEditingController().obs;
  var kategoriMenu = TextEditingController().obs;
  var hargaMenu = TextEditingController().obs;
  var jumlahKg = TextEditingController().obs;
  var totalDibayar = TextEditingController().obs;
  var tanggalProses = TextEditingController().obs;
  var tanggalSelesai = TextEditingController().obs;

  var stepLaundry = [].obs;
  var userDicari = [].obs;
  var menuLaundry = [].obs;
  var menuTerpilih = [].obs;
  var menuPesanan = [].obs;
  var kategoriLaundry = [].obs;
  var dataUserPesan = [].obs;

  var kodePesanan = "".obs;
  var idNomorRiwayatLaundry = "".obs;
  var formLaundry = "".obs;
  var dropdownvalue = "BELUM LUNAS".obs;
  var namaFileNota = "".obs;
  var emailValidasi = "".obs;

  var showpassword = false.obs;

  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  List fakeDBStepLaundry = [
    {
      'title': 'STEP 1',
      'desc': 'Pilih User',
      'is_active': true,
    },
    {
      'title': 'STEP 2',
      'desc': 'Pilih Menu',
      'is_active': false,
    },
    {
      'title': 'STEP 3',
      'desc': 'Laporan',
      'is_active': false,
    }
  ];

  List itemsDropdown = [
    'BELUM LUNAS',
    'LUNAS',
  ];

  void onInit() async {
    stepLaundry.value = fakeDBStepLaundry;
    formLaundry.value = 'STEP 1';
    getMenu();
    getKategori();
  }

  void refresh() {
    cari.value.text = "";
    formLaundry.value = "STEP 1";
    formLaundry.refresh();
    dropdownvalue.value = "BELUM LUNAS";
    dropdownvalue.refresh();
    namaFileNota.value = "";
    namaFileNota.refresh();

    idUser.value.text = "";
    username.value.text = "";
    email.value.text = "";
    nohp.value.text = "";
    member.value.text = "";
    kgUser.value.text = "";
    pointUser.value.text = "";

    idMenu.value.text = "";
    namaMenu.value.text = "";
    kategoriMenu.value.text = "";
    hargaMenu.value.text = "";
    jumlahKg.value.text = "";
    totalDibayar.value.text = "";
    tanggalProses.value.text = "";
    tanggalSelesai.value.text = "";
    kodePesanan.value = "";

    userDicari.clear();
    menuLaundry.clear();
    menuTerpilih.clear();
    menuPesanan.clear();
    kategoriLaundry.clear();
    dataUserPesan.clear();
  }

  void getMenu() {
    var connect = Api.connectionApi("get", {}, "menu");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        menuLaundry.value = valueBody['data'];
      }
    });
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

  void selectMenu(detil) {
    menuTerpilih.value.clear();
    for (var element in menuLaundry.value) {
      if (element['id_kategori'] == detil['id_kategori']) {
        menuTerpilih.value.add(element);
      }
    }
    for (var element in kategoriLaundry.value) {
      if (element['id_kategori'] == detil['id_kategori']) {
        element['is_active'] = true;
      } else {
        element['is_active'] = false;
      }
    }
    menuTerpilih.refresh();
    kategoriLaundry.refresh();
  }

  void changeStep(title) {
    for (var element in stepLaundry.value) {
      if (element['title'] == title) {
        element['is_active'] = true;
        formLaundry.value = title;
      } else {
        element['is_active'] = false;
      }
    }
    stepLaundry.refresh();
  }

  void hitungAkumulasiLaundry() {
    int hasilHitung = 0;
    menuPesanan.forEach((element) {
      hasilHitung += int.parse(element['total']);
    });
    totalDibayar.value.text = '$hasilHitung';
    totalDibayar.refresh();
    UtilsAlert.showToast("Berhasil menghitung...");
    print(menuPesanan.value);
  }

  void cariUser() {
    UtilsAlert.loadingContent();
    userDicari.value.clear();
    Map<String, dynamic> body = {
      'cari': '${cari.value.text}',
    };
    var connect = Api.connectionApi("post", body, "cariUser");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['status'] == true) {
          for (var element in valueBody['data']) {
            if (element['status'] == 2) {
              userDicari.value.add(element);
            }
          }
          Get.back();
          UtilsAlert.showToast("${valueBody['message']}");
        }
        userDicari.refresh();
      }
    });
  }

  void userSelected(detil) {
    idUser.value.text = "${detil['id_user']}";
    username.value.text = detil['username'];
    email.value.text = detil['email'];
    nohp.value.text = detil['no_hp'];
    member.value.text = "${detil['member']}";
    kgUser.value.text = detil['kg'];
    pointUser.value.text = detil['point'];
    idUser.refresh();
    username.refresh();
    email.refresh();
    nohp.refresh();
    member.refresh();
    kgUser.refresh();
    pointUser.refresh();
  }

  void menuSelected(detil) {
    idMenu.value.text = "${detil['id_menu']}";
    namaMenu.value.text = detil['nama'];
    kategoriMenu.value.text = detil['kategori'];
    hargaMenu.value.text = detil['harga'];
    jumlahKg.value.text = "";
    idMenu.refresh();
    namaMenu.refresh();
    kategoriMenu.refresh();
    hargaMenu.refresh();
    jumlahKg.refresh();
  }

  Future<dynamic> validasiEmail() async {
    Map<String, dynamic> body = {'val': "email", 'cari': emailRegis.value.text};
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

  void aksiRegistrasiUser() {
    UtilsAlert.showLoadingIndicator(Get.context!);
    Map<String, dynamic> body = {
      'username': usernameRegis.value.text,
      'password': passwordRegis.value.text,
      'email': emailRegis.value.text,
      'no_hp': nohpRegis.value.text,
      'tanggal_daftar': "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
    };
    var connect = Api.connectionApi("post", body, "registerUser");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        Navigator.pop(Get.context!);
        print(res.body);
      }
    });
  }

  void changeDropdown(value) {
    dropdownvalue.value = value;
    dropdownvalue.refresh();
  }

  void viewPdfNota() {
    _launchURL() async =>
        await canLaunch(Api.urlAssetsNota + namaFileNota.value)
            ? await launch(Api.urlAssetsNota + namaFileNota.value)
            : throw UtilsAlert.showToast('Tidak dapat membuka');
    _launchURL();
  }

  void simpanLaundry() {
    int getStatus = dropdownvalue.value == "BELUM LUNAS" ? 1 : 2;
    String dateMasuk =
        Constanst.convertDateSimpanLaundry(tanggalProses.value.text);
    String dateSelesai =
        Constanst.convertDateSimpanLaundry(tanggalSelesai.value.text);
    Map<String, dynamic> body = {
      'id_user': idUser.value.text,
      'list_pesanan': menuPesanan.value,
      'total_dibayar': totalDibayar.value.text,
      'status': "$getStatus",
      'tanggal_masuk': "$dateMasuk",
      'tanggal_selesai': "$dateSelesai",
    };
    var connect = Api.connectionApi("post", body, "simpanLaundry");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['status'] == true) {
          namaFileNota.value = "${valueBody['status']}";
          namaFileNota.refresh();
          idNomorRiwayatLaundry.value = "${valueBody['id_last']}";
          dataUserPesan.value = valueBody['data_user'];
          dataUserPesan.refresh();
          kodePesanan.value = valueBody['kodepesanan'];
          kodePesanan.refresh();
          UtilsAlert.showToast(valueBody['message']);
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
        }
      }
    });
  }

  void updateDataUser(sisaKg) {
    var hitungPoint = int.parse(pointUser.value.text) + 1;
    Map<String, dynamic> body = {
      'val': 'id_user',
      'cari': idUser.value.text,
      'kg': sisaKg,
      'point': hitungPoint,
    };
    var connect = Api.connectionApi("post", body, "editWhereOnce-users");
    connect.then((dynamic res) {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['status'] == true) {
          UtilsAlert.showToast("Data user bergasil di update");
        }
      }
    });
  }

  void addMenuPesanan() {
    double converthargamenu = double.parse(hargaMenu.value.text);
    double convertjumlahkg = Constanst.validasiValueDouble(jumlahKg.value.text);
    var total = converthargamenu * convertjumlahkg;
    String convert1 = '$total';
    var convert2 = convert1.split('.');
    var hitungTotal = convert2[0];
    var data = {
      'id_menu': idMenu.value.text,
      'uraian': namaMenu.value.text,
      'kategori': kategoriMenu.value.text,
      'jumlah': convertjumlahkg,
      'harga': hargaMenu.value.text,
      'total': hitungTotal,
    };
    menuPesanan.add(data);
    idMenu.value.text = "";
    namaMenu.value.text = "";
    kategoriMenu.value.text = "";
    hargaMenu.value.text = "";
    jumlahKg.value.text = "";
    idMenu.refresh();
    namaMenu.refresh();
    kategoriMenu.refresh();
    hargaMenu.refresh();
    jumlahKg.refresh();
    UtilsAlert.showToast("Berhasil tambah menu pesanan");
  }

  void removeMenuPesanan(id) {
    menuPesanan.value.removeWhere((element) => element['id_menu'] == id);
    menuPesanan.refresh();
    UtilsAlert.showToast("Berhasil hapus menu pesanan");
  }

  void prosesSimpanLaundryForMember() {
    double hitungSisa =
        double.parse(kgUser.value.text) - double.parse(jumlahKg.value.text);
    dropdownvalue.value = "LUNAS";
    var data = {
      'id_menu': "0",
      'uraian': "Member Bulanan",
      'kategori': "KG",
      'jumlah': jumlahKg.value.text,
      'harga': "0",
      'total': "0",
    };
    menuPesanan.value.add(data);
    totalDibayar.value.text = "0";
    validasiSimpan(hitungSisa);
  }

  validasiKeluar() {
    showDialog(
      barrierDismissible: false,
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
                  Center(
                    child: Text(" Keluar Halaman...?"),
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
              child: Text("Keluar"),
              onPressed: () {
                refresh();
                Get.offAll(DashboardAdmin());
              },
            ),
          ],
        );
      },
    );
  }

  validasiClearData() {
    showDialog(
      barrierDismissible: false,
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
                  Center(
                    child: Text(" Clear data...?"),
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
              child: Text("Clear"),
              onPressed: () {
                UtilsAlert.showToast("Berhasil Clear Data...");
                refresh();
                onInit();

                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  validasiSimpan(hitungSisa) {
    showDialog(
      barrierDismissible: false,
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
                  Center(
                    child: Text("Yakin simpan data... ?"),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Tutup"),
              onPressed: () {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: Text("Submit"),
              onPressed: () {
                if (hitungSisa == 0) {
                  updateDataUser(hitungSisa);
                  simpanLaundry();
                } else {
                  updateDataUser(hitungSisa);
                  simpanLaundry();
                }
              },
            ),
          ],
        );
      },
    );
  }

  registerUser() {
    showGeneralDialog(
        context: Get.context!,
        pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
              backgroundColor: Colors.grey.shade100,
              body: WillPopScope(
                onWillPop: () async {
                  Get.offAll(ManageLaundry());
                  return true;
                },
                child: SafeArea(
                    child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text("Register User"),
                          ),
                          SizedBox(height: 10),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text("Username")),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 50,
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                                border: Border.all(
                                    width: 1.0, color: Colors.black)),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 10),
                              child: TextField(
                                controller: usernameRegis.value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                      Icons.supervised_user_circle_outlined),
                                ),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 2.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text("Password")),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 50,
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                                border: Border.all(
                                    width: 1.0, color: Colors.black)),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 10),
                              child: TextField(
                                // ignore: unnecessary_this
                                obscureText: !showpassword.value,
                                controller: passwordRegis.value,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.security),
                                    // ignore: unnecessary_this
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: showpassword.value
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() => showpassword.value =
                                            !showpassword.value);
                                      },
                                    )),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 2.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text("Email")),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 50,
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                                border: Border.all(
                                    width: 1.0, color: Colors.black)),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 10),
                              child: TextField(
                                controller: emailRegis.value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.email_rounded),
                                ),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 2.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(emailValidasi.value),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Text("No Wa")),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 50,
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                                border: Border.all(
                                    width: 1.0, color: Colors.black)),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 10),
                              child: TextField(
                                controller: nohpRegis.value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "0813xxxxxxxx",
                                  prefixIcon: const Icon(Icons.whatsapp),
                                ),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 2.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ))),
                                onPressed: () {
                                  Get.offAll(ManageLaundry());
                                },
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue.shade600),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ))),
                                onPressed: () {
                                  if (usernameRegis.value.text == "" ||
                                      emailRegis.value.text == "" ||
                                      nohpRegis.value.text == "" ||
                                      passwordRegis.value.text == "") {
                                    UtilsAlert.showToast(
                                        "Harap lengkapi form di atas");
                                  } else {
                                    var statusValidasi = validasiEmail();
                                    statusValidasi.then((value) {
                                      if (value == true) {
                                        UtilsAlert.showToast(
                                            "Email sudah terdaftar");
                                      } else {
                                        aksiRegistrasiUser();
                                        UtilsAlert.showToast(
                                            "Berhasil Registrasi");
                                        Get.back();
                                      }
                                    });
                                  }
                                },
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          )
                        ],
                      );
                    }),
                  ),
                )),
              ),
            ));
  }
}

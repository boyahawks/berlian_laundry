import 'dart:convert';
import 'dart:io';

import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/screen/profile_user.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/app_data.dart';
import 'package:berlian_laundry/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var oldPassword = TextEditingController().obs;
  var newPassword = TextEditingController().obs;

  var biodataUser = {}.obs;
  var riwayatLaundryUser = [].obs;
  var viewRiwayat = 0.obs;

  var showPasswordNew = false.obs;
  var showPasswordOld = false.obs;

  void onInit() async {
    getBiodata();
  }

  void getBiodata() {
    Map<String, dynamic> body = {'val': "email", 'cari': AppData.email};
    var connect = Api.connectionApi("post", body, "getOnce-users");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        biodataUser.value = valueBody['data'][0];
      }
      getRiwayatLaundryUser();
    });
  }

  void getRiwayatLaundryUser() {
    print("kesini");
    Map<String, dynamic> body = {
      'val': "id_user",
      'cari': "${biodataUser.value['id_user']}"
    };
    var connect = Api.connectionApi("post", body, "getOnce-riwayat_laundry");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);

        for (var element in valueBody['data']) {
          if (viewRiwayat.value == 0) {
            if (element['status'] == "1") {
              riwayatLaundryUser.value.add(element);
            }
          } else if (viewRiwayat.value == 1) {
            if (element['status'] == "2") {
              riwayatLaundryUser.value.add(element);
            }
          } else if (viewRiwayat.value == 2) {
            if (element['status'] == "3") {
              riwayatLaundryUser.value.add(element);
            }
          } else {
            print("nothing");
          }
        }
        this.riwayatLaundryUser.refresh();
      }
    });
  }

  void aksiChangePassword() {
    UtilsAlert.showLoadingIndicator(Get.context!);
    Map<String, dynamic> body = {
      'newPassword': "${newPassword.value.text}",
      'oldPassword': "${oldPassword.value.text}",
      'email': "${AppData.email}"
    };
    var connect = Api.connectionApi("post", body, "changePassword");
    connect.then((dynamic res) async {
      if (res.statusCode == 200) {
        var valueBody = jsonDecode(res.body);
        if (valueBody['status'] == true) {
          Navigator.pop(Get.context!, true);
          UtilsAlert.showToast(valueBody['message']);
          Get.offAll(ProfileUser());
        } else {
          Navigator.pop(Get.context!, true);
          UtilsAlert.showToast(valueBody['message']);
        }
      } else {
        UtilsAlert.showToast("terjadi kesalahan");
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

  changePassword(context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
              backgroundColor: Colors.grey.shade100,
              body: WillPopScope(
                onWillPop: () async {
                  Get.offAll(ProfileUser());
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
                            child: Text("Ganti Password"),
                          ),
                          SizedBox(height: 10),
                          Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text("Password Lama")),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 10, right: 10),
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
                                obscureText: !this.showPasswordOld.value,
                                controller: oldPassword.value,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.security),
                                    // ignore: unnecessary_this
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: this.showPasswordOld.value
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          this.showPasswordOld.value =
                                              !this.showPasswordOld.value;
                                        });
                                        ;
                                      },
                                    )),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 2.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text("Password Baru")),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 10, right: 10),
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
                                obscureText: !this.showPasswordNew.value,
                                controller: newPassword.value,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.security),
                                    // ignore: unnecessary_this
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: this.showPasswordNew.value
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          this.showPasswordNew.value =
                                              !this.showPasswordNew.value;
                                        });
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
                                  Get.offAll(ProfileUser());
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
                                  if (newPassword.value.text != "" &&
                                      oldPassword.value.text != "") {
                                    aksiChangePassword();
                                  } else {
                                    UtilsAlert.showToast(
                                        "Lengkapi form di atas");
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

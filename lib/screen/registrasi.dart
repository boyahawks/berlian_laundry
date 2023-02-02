// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:berlian_laundry/controller/auth_controller.dart';
import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/screen/login.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/constant.dart';
import 'package:berlian_laundry/utils/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Registrasi extends StatefulWidget {
  @override
  State<Registrasi> createState() => _RegistrasiinState();
}

class _RegistrasiinState extends State<Registrasi> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  _RegistrasiinState createState() => _RegistrasiinState();

  final controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.offAll(Login());
          return true;
        },
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: NetworkImage(Api.urlAssets + 'latar.png'),
                        fit: BoxFit.cover)),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 249, 249),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              "REGISTRASI",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 20),
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
                                controller: controller.username.value,
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
                          Container(
                              margin: const EdgeInsets.only(left: 20),
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
                                obscureText:
                                    !this.controller.showpassword.value,
                                controller: controller.password.value,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.security),
                                    // ignore: unnecessary_this
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color:
                                            this.controller.showpassword.value
                                                ? Colors.blue
                                                : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() =>
                                            this.controller.showpassword.value =
                                                !this
                                                    .controller
                                                    .showpassword
                                                    .value);
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
                                controller: controller.email.value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.email_rounded),
                                ),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 2.0,
                                    color: Colors.black),
                                onChanged: (value) {
                                  var hasil = controller.validateEmail(value);
                                  setState(() {
                                    if (!hasil) {
                                      controller.emailValidasi.value =
                                          "Email tidak valid (contoh : @gmail.com";
                                    } else {
                                      controller.emailValidasi.value = "";
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              controller.emailValidasi.value,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          controller.emailValidasi.value == ""
                              ? SizedBox()
                              : SizedBox(
                                  height: 15,
                                ),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
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
                                controller: controller.nohp.value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "contoh : 0813xxxxxxxx",
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
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: TextButton(
                                onPressed: () {
                                  UtilsAlert.showLoadingIndicator(context);
                                  if (controller.username.value.text == "" ||
                                      controller.email.value.text == "" ||
                                      controller.nohp.value.text == "" ||
                                      controller.password.value.text == "") {
                                    Navigator.pop(context);
                                    UtilsAlert.showToast(
                                        "Harap lengkapi form di atas");
                                  } else {
                                    var statusValidasi =
                                        controller.validasiEmail();
                                    statusValidasi.then((value) {
                                      if (value == true) {
                                        controller.email.value.text == "";
                                        Navigator.pop(context);
                                        UtilsAlert.showToast(
                                            "Email sudah terdaftar");
                                      } else {
                                        controller.registrasiUser();
                                      }
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 1, 11, 39)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
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

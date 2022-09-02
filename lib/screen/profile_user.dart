// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:berlian_laundry/controller/auth_controller.dart';
import 'package:berlian_laundry/controller/profile_controller.dart';
import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/app_data.dart';
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

class ProfileUser extends StatefulWidget {
  @override
  State<ProfileUser> createState() => _ProfileUserinState();
}

class _ProfileUserinState extends State<ProfileUser> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  _ProfileUserinState createState() => _ProfileUserinState();

  final controller = Get.put(ProfileController());

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
            Get.offAll(Dashboard());
            return true;
          },
          child: SafeArea(
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            image: DecorationImage(
                                alignment: Alignment.topCenter,
                                image:
                                    NetworkImage(Api.urlAssets + 'latar.png'),
                                fit: BoxFit.cover)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 70,
                              child: Center(
                                child: Text(
                                  "PROFILE",
                                  style: TextStyle(
                                      color: Constanst.colorWhite,
                                      fontSize: Constanst.sizeTitle),
                                ),
                              )),
                          Expanded(
                            flex: 30,
                            child: SizedBox(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 20,
                          child: FractionalTranslation(
                            translation: Offset(0.0, -0.40),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 135, 135, 135)
                                        .withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppData.username,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Constanst.sizeTitle),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppData.email,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Constanst.sizeTitle),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.biodataUser.value['no_hp'] ??
                                          "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Constanst.sizeTitle),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 80,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 30, right: 30),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 135, 135, 135)
                                                .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(
                                            1, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "POINT TERKUMPUL",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Constanst.sizeTitle),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Obx(
                                        () => Text(
                                          controller
                                                  .biodataUser.value['point'] ??
                                              "0",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Constanst.sizeTitle),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                StatefulBuilder(builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: TextButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                )),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        controller.viewRiwayat
                                                                    .value !=
                                                                0
                                                            ? Color.fromARGB(
                                                                255,
                                                                230,
                                                                228,
                                                                228)
                                                            : Colors.blue
                                                                .shade300)),
                                            onPressed: () {
                                              setState(() {
                                                controller.viewRiwayat.value =
                                                    0;
                                                controller
                                                    .riwayatLaundryUser.value
                                                    .clear();
                                                controller
                                                    .getRiwayatLaundryUser();
                                                controller.update();
                                              });
                                            },
                                            child: Center(
                                              child: Text(
                                                "Proses",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: TextButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                )),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        controller.viewRiwayat
                                                                    .value !=
                                                                1
                                                            ? Color.fromARGB(
                                                                255,
                                                                230,
                                                                228,
                                                                228)
                                                            : Colors.blue
                                                                .shade300)),
                                            onPressed: () {
                                              setState(() {
                                                controller.viewRiwayat.value =
                                                    1;
                                                controller
                                                    .riwayatLaundryUser.value
                                                    .clear();
                                                controller
                                                    .getRiwayatLaundryUser();
                                                controller.update();
                                              });
                                            },
                                            child: Center(
                                              child: Text(
                                                "Selesai",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: TextButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                )),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        controller.viewRiwayat
                                                                    .value !=
                                                                2
                                                            ? Color.fromARGB(
                                                                255,
                                                                230,
                                                                228,
                                                                228)
                                                            : Colors.blue
                                                                .shade300)),
                                            onPressed: () {
                                              setState(() {
                                                controller.viewRiwayat.value =
                                                    2;
                                                controller
                                                    .riwayatLaundryUser.value
                                                    .clear();
                                                controller
                                                    .getRiwayatLaundryUser();
                                                controller.update();
                                              });
                                            },
                                            child: Center(
                                              child: Text(
                                                "Diambil",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                                SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => controller
                                          .riwayatLaundryUser.value.isEmpty
                                      ? Center(
                                          child:
                                              Text("Data tidak di temukan..."),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: controller
                                              .riwayatLaundryUser.value.length,
                                          itemBuilder: (context, index) {
                                            var convertTotal = controller
                                                .riwayatLaundryUser
                                                .value[index]['total']
                                                .substring(
                                                    0,
                                                    controller
                                                            .riwayatLaundryUser
                                                            .value[index]
                                                                ['total']
                                                            .length -
                                                        2);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Kode : ${controller.riwayatLaundryUser.value[index]['kode_pesan']}",
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Jumlah : ${controller.riwayatLaundryUser.value[index]['jumlah']} KG",
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Total : ${NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: 'Rp ',
                                                      decimalDigits: 0,
                                                    ).format(int.parse(convertTotal))}",
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Diambil : ${controller.riwayatLaundryUser.value[index]['diambil']}",
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Divider(
                                                    height: 5,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: SpeedDial(
          icon: Icons.list,
          activeIcon: Icons.close,
          spacing: 3,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          elevation: 8.0,
          animationCurve: Curves.elasticInOut,
          animationDuration: const Duration(milliseconds: 200),
          children: [
            SpeedDialChild(
              child: Icon(Icons.person_sharp),
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              label: 'Ganti password',
              onTap: () => setState(() => controller.changePassword(context)),
            ),
            SpeedDialChild(
              child: Icon(Icons.logout),
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              label: 'Logout',
              onTap: () => setState(() => controller.logout(context)),
            ),
          ],
        ));
  }
}

// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:berlian_laundry/controller/dashboard_admin_controller.dart';
import 'package:berlian_laundry/screen/admin/dashboard_admin.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/constant.dart';
import 'package:berlian_laundry/utils/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ManageHistory extends StatelessWidget {
  final controller = Get.put(DashboardAdminController());

  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        Get.offAll(DashboardAdmin());
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: line1(context),
                ),
                Flexible(flex: 3, child: line2(context))
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget line1(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          "MANAGE HISTORY",
          style: TextStyle(
              fontSize: Constanst.sizeTitle,
              fontWeight: FontWeight.bold,
              color: Constanst.colorWhite),
        ),
      ),
    );
  }

  Widget line2(context) {
    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.all(Constanst.defaultMarginPadding),
                child: controller.statusCariHistory.value == false
                    ? Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                                border: Border.all(
                                    width: 1.0, color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: TextField(
                                controller: controller.cari.value,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Cari kode / username"),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (controller.cari.value.text == "") {
                                    UtilsAlert.showToast(
                                        "Isi kolom pencarian...");
                                  } else {
                                    controller.statusCariHistory.value = true;
                                    controller.cariHistoryLaundry();
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade900,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Cari",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.riwayatLaundry.value.clear();
                                controller.cari.value.text = "";
                                controller.statusCariHistory.value = false;
                                controller.loadRiwayatLaundry();
                              },
                              icon: Icon(Icons.close, size: 30)),
                        ],
                      ),
              ),
            ),
            controller.statusCariHistory.value == false
                ? Padding(
                    padding: EdgeInsets.only(
                        left: Constanst.defaultMarginPadding,
                        right: Constanst.defaultMarginPadding),
                    child: Obx(
                      () => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )),
                                    backgroundColor: MaterialStateProperty.all(
                                        controller.statusLaundrySelected
                                                    .value !=
                                                1
                                            ? Color.fromARGB(255, 230, 228, 228)
                                            : Colors.blue.shade300)),
                                onPressed: () {
                                  controller.statusLaundrySelected.value = 1;
                                  controller.riwayatLaundry.value.clear();
                                  controller.loadRiwayatLaundry();
                                  controller.update();
                                },
                                child: Center(
                                  child: Text(
                                    "Proses",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )),
                                    backgroundColor: MaterialStateProperty.all(
                                        controller.statusLaundrySelected
                                                    .value !=
                                                2
                                            ? Color.fromARGB(255, 230, 228, 228)
                                            : Colors.blue.shade300)),
                                onPressed: () {
                                  controller.statusLaundrySelected.value = 2;
                                  controller.riwayatLaundry.value.clear();
                                  controller.loadRiwayatLaundry();
                                  controller.update();
                                },
                                child: Center(
                                  child: Text(
                                    "Selesai",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )),
                                    backgroundColor: MaterialStateProperty.all(
                                        controller.statusLaundrySelected
                                                    .value !=
                                                3
                                            ? Color.fromARGB(255, 230, 228, 228)
                                            : Colors.blue.shade300)),
                                onPressed: () {
                                  controller.statusLaundrySelected.value = 3;
                                  controller.riwayatLaundry.value.clear();
                                  controller.loadRiwayatLaundry();
                                  controller.update();
                                },
                                child: Center(
                                  child: Text(
                                    "Diambil",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                : SizedBox(),
            Flexible(
              flex: 2,
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: controller.statusCariHistory.value == false
                      ? SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: false,
                          header: WaterDropHeader(),
                          onRefresh: () async {
                            await Future.delayed(const Duration(seconds: 1));
                            controller.riwayatLaundry.value.clear();
                            controller.loadRiwayatLaundry();
                            controller.refreshController.refreshCompleted();
                          },
                          controller: controller.refreshController,
                          child: controller.riwayatLaundry.value.isEmpty
                              ? Center(
                                  child: Text("Data tidak di temukan"),
                                )
                              : ListView.builder(
                                  itemCount:
                                      controller.riwayatLaundry.value.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 85,
                                          child: InkWell(
                                            onTap: () {
                                              controller.gantiStatusHistory(
                                                  context,
                                                  controller.riwayatLaundry
                                                      .value[index]);
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Username : ${controller.riwayatLaundry.value[index]['username']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Constanst.sizeText),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Kode : ${controller.riwayatLaundry.value[index]['kode_pesan']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Constanst.sizeText),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Jumlah : ${controller.riwayatLaundry.value[index]['jumlah']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Constanst.sizeText),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Total : ${NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: 'Rp ',
                                                    decimalDigits: 0,
                                                  ).format(int.parse(controller.riwayatLaundry.value[index]['total']))}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Constanst.sizeText),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Tanggal Masuk : ${Constanst.convertDate(controller.riwayatLaundry.value[index]['tanggal_masuk'])}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Constanst.sizeText),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                controller.riwayatLaundry
                                                                .value[index]
                                                            ['pembayaran'] ==
                                                        1
                                                    ? Text(
                                                        "Belum Lunas",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: Constanst
                                                                .sizeText,
                                                            color: Colors.red),
                                                      )
                                                    : Text(
                                                        "Lunas",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: Constanst
                                                                .sizeText,
                                                            color: Colors.blue),
                                                      ),
                                                SizedBox(
                                                  height: 10,
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
                                        controller.riwayatLaundry.value[index]
                                                    ['status'] ==
                                                '3'
                                            ? SizedBox()
                                            : SizedBox()
                                        // : Expanded(
                                        //     flex: 15,
                                        //     child: Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: [
                                        //         IconButton(
                                        //             onPressed: () {
                                        //               controller
                                        //                   .checkingPesananPrint(
                                        //                       controller
                                        //                           .riwayatLaundry);
                                        //             },
                                        //             icon: Icon(
                                        //               Icons.picture_as_pdf,
                                        //               color: Colors.red,
                                        //               size: 30,
                                        //             ))
                                        //       ],
                                        //     ),
                                        //   )
                                      ],
                                    );
                                  }),
                        )
                      : controller.riwayatLaundry.value.isEmpty
                          ? Center(
                              child: Text("Data tidak di temukan"),
                            )
                          : ListView.builder(
                              itemCount: controller.riwayatLaundry.value.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    controller.gantiStatusHistory(context,
                                        controller.riwayatLaundry.value[index]);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Username : ${controller.riwayatLaundry.value[index]['username']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Constanst.sizeText),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Kode : ${controller.riwayatLaundry.value[index]['kode_pesan']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Constanst.sizeText),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Jumlah : ${controller.riwayatLaundry.value[index]['jumlah']} KG",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Constanst.sizeText),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Total : ${NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0,
                                        ).format(int.parse(controller.riwayatLaundry.value[index]['total']))}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Constanst.sizeText),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Tanggal Masuk : ${Constanst.convertDate(controller.riwayatLaundry.value[index]['tanggal_masuk'])}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Constanst.sizeText),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      controller.riwayatLaundry.value[index]
                                                  ['status'] ==
                                              "1"
                                          ? Text(
                                              "Sedang Proses",
                                              style: TextStyle(
                                                  fontSize: Constanst.sizeText,
                                                  color: Colors.orange),
                                            )
                                          : controller.riwayatLaundry
                                                      .value[index]['status'] ==
                                                  "2"
                                              ? Text(
                                                  "Selesai",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Constanst.sizeText,
                                                      color: Colors.blue),
                                                )
                                              : controller.riwayatLaundry
                                                              .value[index]
                                                          ['status'] ==
                                                      "3"
                                                  ? Text(
                                                      "Sudah di ambil",
                                                      style: TextStyle(
                                                          fontSize: Constanst
                                                              .sizeText,
                                                          color: Colors.green),
                                                    )
                                                  : SizedBox(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      controller.riwayatLaundry.value[index]
                                                  ['pembayaran'] ==
                                              1
                                          ? Text(
                                              "Belum Lunas",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Constanst.sizeText,
                                                  color: Colors.red),
                                            )
                                          : Text(
                                              "Lunas",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Constanst.sizeText,
                                                  color: Colors.blue),
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
                                );
                              }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class ManageMenu extends StatelessWidget {
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
          "MANAGE MENU",
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
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                    borderRadius: Constanst.borderStyle1,
                    color: Constanst.colorPrimary),
                child: InkWell(
                  onTap: () => controller.tambahDataMenu(),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Tambah Data",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.kategoriLaundry.value.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => InkWell(
                          onTap: () {
                            controller.idkategoriMenuSelected.value = controller
                                .kategoriLaundry.value[index]['id_kategori'];
                            controller.chooseMenu();
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: controller.kategoriLaundry.value[index]
                                          ['is_active'] ==
                                      false
                                  ? Colors.white
                                  : Colors.blue.shade200,
                              borderRadius: Constanst.borderStyle2,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 135, 135, 135)
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Center(
                                child: Text(
                                  controller.kategoriLaundry.value[index]
                                      ['nama_kategori'],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 8,
              ),
              Flexible(
                  child: controller.menuSelected.value.isEmpty
                      ? Center(
                          child: Text("No selected..."),
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.menuSelected.value.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 85,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.menuSelected.value[index]
                                                ['nama'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            controller.menuSelected.value[index]
                                                ['kategori'],
                                          ),
                                          SizedBox(height: 8),
                                          Text(controller.currencyFormatter
                                              .format(int.parse(controller
                                                  .menuSelected
                                                  .value[index]['harga']))),
                                          SizedBox(height: 8),
                                          SizedBox(
                                              height: Constanst
                                                  .defaultMarginPadding),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 30,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.green),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ))),
                                              onPressed: () {
                                                controller.idMenu.value.text =
                                                    "${controller.menuSelected.value[index]['id_menu']}";
                                                controller.namaMenu.value.text =
                                                    controller.menuSelected
                                                        .value[index]['nama'];
                                                controller.kategoriMenu.value
                                                        .text =
                                                    controller.menuSelected
                                                            .value[index]
                                                        ['kategori'];
                                                controller
                                                        .hargaMenu.value.text =
                                                    controller.menuSelected
                                                        .value[index]['harga'];
                                                controller.detilMenu(context);
                                              },
                                              child: Center(
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )),
                                          TextButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(
                                                            8.0,
                                                          ),
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .red)))),
                                              onPressed: () =>
                                                  controller.hapusMenu(controller
                                                      .menuSelected
                                                      .value[index]['id_menu']),
                                              child: Center(
                                                child: Text(
                                                  "Hapus",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                  height: 5,
                                  color: Colors.grey,
                                ),
                              ],
                            );
                          },
                        ))
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:berlian_laundry/controller/dashboard_admin_controller.dart';
import 'package:berlian_laundry/controller/laundry_controller.dart';
import 'package:berlian_laundry/screen/admin/dashboard_admin.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/constant.dart';
import 'package:berlian_laundry/utils/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ManageLaundry extends StatelessWidget {
  final controller = Get.put(LaundryController());

  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        controller.validasiKeluar();
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
          "MANAGE LAUNDRY",
          style: TextStyle(
              fontSize: Constanst.sizeTitle,
              fontWeight: FontWeight.bold,
              color: Constanst.colorWhite),
        ),
      ),
    );
  }

  Widget line2(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: 30,
              ),
              tahapan(),
              SizedBox(
                height: 20,
              ),
              controller.formLaundry.value == 'STEP 1'
                  ? viewFormStep1()
                  : controller.formLaundry.value == 'STEP 2'
                      ? viewFormStep2()
                      : controller.formLaundry.value == 'STEP 3'
                          ? viewFormStep3()
                          : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget tahapan() {
    return SizedBox(
      height: 150,
      child: Obx(
        () => Padding(
          padding: EdgeInsets.only(
              left: Constanst.defaultMarginPadding,
              right: Constanst.defaultMarginPadding),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.stepLaundry.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        controller
                            .changeStep(controller.stepLaundry[index]['title']);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: controller.stepLaundry[index]
                                          ['is_active'] ==
                                      true
                                  ? Colors.blue.shade300
                                  : Color.fromARGB(255, 244, 240, 240),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                controller.stepLaundry[index]['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              controller.stepLaundry[index]['desc'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    controller.stepLaundry[index]['desc'] == "Laporan"
                        ? SizedBox()
                        : Center(
                            child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 30, left: 8, right: 8),
                            child: Text(
                              "____",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: controller.stepLaundry[index]
                                              ['is_active'] ==
                                          true
                                      ? Colors.blue.shade300
                                      : Colors.black),
                            ),
                          )),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget viewFormStep1() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
            left: Constanst.defaultMarginPadding,
            right: Constanst.defaultMarginPadding),
        child: Column(
          children: [
            Center(
              child: Text("FORM USER"),
            ),
            Center(
              child: SizedBox(
                width: 150,
                child: Divider(
                  height: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
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
                      border: Border.all(width: 1.0, color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      controller: controller.cari.value,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Cari User"),
                      style: TextStyle(
                          fontSize: 14.0, height: 1.0, color: Colors.black),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.cariUser();
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
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SizedBox(
                  height: 300,
                  child: controller.userDicari.value.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Text("No data..."),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                              border: Border(
                            right: BorderSide(color: Colors.black),
                          )),
                          child: ListView.builder(
                              itemCount: controller.userDicari.value.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: Obx(
                                    () => InkWell(
                                      onTap: () => controller.userSelected(
                                          controller.userDicari.value[index]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(controller.userDicari
                                              .value[index]['username']),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(controller.userDicari
                                              .value[index]['no_hp']),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Divider(
                                            height: 5,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            height:
                                                Constanst.defaultMarginPadding,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                )),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Constanst.defaultMarginPadding,
                            ),
                            Text("Username :"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(controller.username.value.text,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: Constanst.defaultMarginPadding,
                            ),
                            Text("Email :"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(controller.email.value.text,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: Constanst.defaultMarginPadding,
                            ),
                            Text("WA :"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(controller.nohp.value.text,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 1, 11, 39)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
                ),
                onPressed: () {
                  controller.registerUser();
                  controller.usernameRegis.value.text = "";
                  controller.emailRegis.value.text = "";
                  controller.nohpRegis.value.text = "";
                  controller.passwordRegis.value.text = "";
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text("Register User"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget viewFormStep2() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
            left: Constanst.defaultMarginPadding,
            right: Constanst.defaultMarginPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("FORM MENU"),
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              controller.member.value.text == '1'
                  ? Center(
                      child: Text(
                        "SISA KG BULAN INI : ${controller.kgUser.value.text} KG",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.kategoriLaundry.value.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor: controller
                                                  .kategoriLaundry
                                                  .value[index]['is_active'] ==
                                              true
                                          ? MaterialStateProperty.all<Color>(
                                              Colors.blue.shade200)
                                          : MaterialStateProperty.all<Color>(
                                              Color.fromARGB(
                                                  255, 228, 228, 228)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ))),
                                  onPressed: () => controller.selectMenu(
                                      controller.kategoriLaundry.value[index]),
                                  child: SizedBox(
                                    width: 60,
                                    child: Center(
                                      child: Text(
                                        controller.kategoriLaundry.value[index]
                                            ['nama_kategori'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 320,
                                child: controller.menuTerpilih.value.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 10),
                                        child: Text("No data..."),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          right:
                                              BorderSide(color: Colors.black),
                                        )),
                                        child: ListView.builder(
                                            itemCount: controller
                                                .menuTerpilih.value.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 15),
                                                child: Material(
                                                  color: Colors.white,
                                                  child: InkWell(
                                                    onTap: () => controller
                                                        .menuSelected(controller
                                                            .menuTerpilih
                                                            .value[index]),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(controller
                                                                .menuTerpilih
                                                                .value[index]
                                                            ['nama']),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(controller
                                                                .menuTerpilih
                                                                .value[index]
                                                            ['kategori']),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(controller
                                                            .currencyFormatter
                                                            .format(int.parse(controller
                                                                    .menuTerpilih
                                                                    .value[index]
                                                                ['harga']))),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Divider(
                                                          height: 5,
                                                          color: Colors.grey,
                                                        ),
                                                        SizedBox(
                                                          height: Constanst
                                                              .defaultMarginPadding,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Constanst.defaultMarginPadding,
                                      ),
                                      Text("Menu :"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(controller.namaMenu.value.text,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: Constanst.defaultMarginPadding,
                                      ),
                                      Text("Kategori :"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(controller.kategoriMenu.value.text,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: Constanst.defaultMarginPadding,
                                      ),
                                      Text("Harga :"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      controller.hargaMenu.value.text == ""
                                          ? SizedBox()
                                          : Text(
                                              controller.currencyFormatter
                                                  .format(int.parse(controller
                                                      .hargaMenu.value.text)),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: Constanst.defaultMarginPadding,
                                      ),
                                      Text("Jumlah"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextField(
                                        controller: controller.jumlahKg.value,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: "Input jumlah"),
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            height: 2.0,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .all<Color>(Color.fromARGB(
                                                        255, 11, 27, 70)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ))),
                                        onPressed: () {
                                          if (controller.jumlahKg.value.text !=
                                              "") {
                                            controller.addMenuPesanan();
                                          } else {
                                            UtilsAlert.showToast(
                                                "Isi jumlah terlebih dahulu");
                                          }
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Text(
                                              "Tambah Menu",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 5,
                color: Colors.grey,
              ),
              SizedBox(
                height: Constanst.defaultMarginPadding,
              ),
              controller.member.value.text == '1'
                  ? SizedBox()
                  : Center(
                      child: Text("Menu Terpilih"),
                    ),
              controller.member.value.text == '1'
                  ? SizedBox()
                  : Center(
                      child: SizedBox(
                        width: 150,
                        child: Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                      ),
                    ),
              SizedBox(
                height: Constanst.defaultMarginPadding,
              ),
              controller.member.value.text == '1'
                  ? Center(child: Text("Next Step..."))
                  : controller.menuPesanan.value.isEmpty
                      ? SizedBox()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.menuPesanan.value.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => controller.removeMenuPesanan(
                                  controller.menuPesanan.value[index]
                                      ['id_menu']),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "Uraian : ${controller.menuPesanan.value[index]['uraian']}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "Jumlah : ${controller.menuPesanan.value[index]['jumlah']} (${controller.menuPesanan.value[index]['kategori']})"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  controller.menuPesanan.value[index]
                                              ['harga'] ==
                                          ""
                                      ? SizedBox()
                                      : Text(
                                          "Harga : ${controller.currencyFormatter.format(int.parse(controller.menuPesanan.value[index]['harga']))}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  controller.menuPesanan.value[index]
                                              ['total'] ==
                                          ""
                                      ? SizedBox()
                                      : Text(
                                          "Total : ${controller.currencyFormatter.format(int.parse(controller.menuPesanan.value[index]['total']))}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    height: 5,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            );
                          }),
              SizedBox(
                height: Constanst.defaultMarginPadding,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget viewFormStep3() {
    return Padding(
      padding: EdgeInsets.only(
          left: Constanst.defaultMarginPadding,
          right: Constanst.defaultMarginPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("LAPORAN"),
            ),
            Center(
              child: SizedBox(
                width: 150,
                child: Divider(
                  height: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Tanggal Proses",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: DateTimeField(
                          format: DateFormat('dd-MM-yyyy'),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Press Here...'),
                          controller: controller.tanggalProses.value,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Colors.grey,
                      ),
                      controller.member.value.text == '1'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Jumlah",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                    controller: controller.jumlahKg.value,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: "Input jumlah"),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        height: 2.0,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Status",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: DropdownButton(
                                    value: controller.dropdownvalue.value,
                                    items:
                                        controller.itemsDropdown.map((items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) =>
                                        controller.changeDropdown(newValue),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Tanggal Selesai",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: DateTimeField(
                          format: DateFormat('dd-MM-yyyy'),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Press Here...'),
                          controller: controller.tanggalSelesai.value,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      controller.member.value.text == '1'
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                      SizedBox(
                        height: 5,
                      ),
                      controller.member.value.text == '1' ||
                              controller.totalDibayar.value.text == ""
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 10, top: 20),
                              child: Text(
                                  controller.currencyFormatter.format(int.parse(
                                      controller.totalDibayar.value.text)),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.member.value.text == '1'
                    ? SizedBox()
                    : Expanded(
                        child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 11, 27, 70)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))),
                        onPressed: () => controller.hitungAkumulasiLaundry(),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              "Hitung",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )),
                Expanded(
                    child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 11, 27, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  onPressed: () {
                    UtilsAlert.showLoadingIndicator(Get.context!);
                    if (controller.member.value.text == '1') {
                      if (controller.jumlahKg.value.text != "") {
                        controller.prosesSimpanLaundryForMember();
                      } else {
                        Navigator.pop(Get.context!);
                        UtilsAlert.showToast(
                            "Harap lengkapi form yang tersedia...");
                      }
                    } else {
                      if (controller.namaFileNota.value == "") {
                        if (controller.idUser.value.text == "" ||
                            controller.totalDibayar.value.text == "" ||
                            controller.tanggalProses.value.text == "" ||
                            controller.tanggalSelesai.value.text == "") {
                          Navigator.pop(Get.context!);
                          UtilsAlert.showToast(
                              "Harap lengkapi form yang tersedia...");
                        } else {
                          controller.validasiSimpan(0);
                        }
                      } else {
                        Navigator.pop(Get.context!);
                        UtilsAlert.showToast("Data ini sudah disimpan...");
                      }
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: controller.namaFileNota.value == ""
                  ? SizedBox()
                  : Column(
                      children: [
                        InkWell(
                          onTap: () => controller.viewPdfNota(),
                          child: Image.asset(
                            'assets/image_pdf.png',
                            height: 80,
                            width: 80,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          controller.namaFileNota.value,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 11, 27, 70)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ))),
                          onPressed: () {
                            controller.validasiClearData();
                          },
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Text(
                                "Clear Data",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:berlian_laundry/controller/button_shett_controller.dart';
import 'package:berlian_laundry/controller/dashboard_admin_controller.dart';
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

class ManageInformasi extends StatelessWidget {
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
          "MANAGE INFORMASI",
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
        physics: BouncingScrollPhysics(),
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: 30,
              ),
              listInformasi(context, "INFORMASI DASHBOARD"),
              SizedBox(
                height: 10,
              ),
              controller.viewInformasiDashboard.value == false
                  ? SizedBox()
                  : viewInformasiDahboard(context),
              SizedBox(
                height: 5,
              ),
              listInformasi(context, "INFORMASI ALL USER"),
              SizedBox(
                height: 10,
              ),
              controller.viewInformasiAllUser.value == false
                  ? SizedBox()
                  : viewInformasiAlluser(context),
              SizedBox(
                height: 5,
              ),
              listInformasi(context, "PRINT LAPORAN"),
              SizedBox(
                height: 10,
              ),
              controller.viewPrintLaporan.value == false
                  ? SizedBox()
                  : viewPrintLaporan()
            ],
          ),
        ),
      ),
    );
  }

  Widget listInformasi(context, title) {
    return Container(
        width: MediaQuery.of(context).size.width,
        // margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 135, 135, 135).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constanst.sizeTitle),
                ),
              ),
            ),
            title == "INFORMASI DASHBOARD"
                ? Center(
                    child: IconButton(
                    onPressed: () => controller.showViewInformasiDashboard(),
                    icon: controller.viewInformasiDashboard.value == false
                        ? Icon(
                            Icons.arrow_drop_up_sharp,
                            size: 40,
                          )
                        : Icon(
                            Icons.arrow_drop_down_sharp,
                            size: 40,
                          ),
                  ))
                : title == "INFORMASI ALL USER"
                    ? Center(
                        child: IconButton(
                        onPressed: () => controller.showViewInformasiAlluser(),
                        icon: controller.viewInformasiAllUser.value == false
                            ? Icon(
                                Icons.arrow_drop_up_sharp,
                                size: 40,
                              )
                            : Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 40,
                              ),
                      ))
                    : title == "PRINT LAPORAN"
                        ? Center(
                            child: IconButton(
                            onPressed: () => controller.showViewPrintLaporan(),
                            icon: controller.viewPrintLaporan.value == false
                                ? Icon(
                                    Icons.arrow_drop_up_sharp,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.arrow_drop_down_sharp,
                                    size: 40,
                                  ),
                          ))
                        : SizedBox(),
          ],
        ));
  }

  Widget viewInformasiDahboard(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  controller.informasiDashboard.value['informasi'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Constanst.colorPrimary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: Constanst.borderStyle2,
                          ))),
                      onPressed: () {
                        controller.informasi.value.text =
                            controller.informasiDashboard.value['informasi'];
                        controller.validasiInformasi(
                            context, "UPDATE INFORMASI DASHBOARD...?", 1);
                      },
                      child: Center(
                        child:
                            controller.informasiDashboard.value['status'] == 0
                                ? Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      "AKTIF",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text("NON AKTIF",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget viewInformasiAlluser(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, left: 40, right: 40),
          child: TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Constanst.colorPrimary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: Constanst.borderStyle2,
                ))),
            onPressed: () => controller.addInformasiUser(context),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  "Tambah Informasi",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Constanst.defaultMarginPadding,
              right: Constanst.defaultMarginPadding),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.informasiAllUser.value.length,
            itemBuilder: (context, index) {
              var id = controller.informasiAllUser.value[index]['id_informasi'];
              var informasi =
                  controller.informasiAllUser.value[index]['informasi'];
              var tanggal =
                  controller.informasiAllUser.value[index]['date_publish'];
              var gambar =
                  controller.informasiAllUser.value[index]['file_gambar'];
              return InkWell(
                onTap: () {
                  controller.idInformasiAlluserSelected.value = id;
                  controller.validasiInformasi(
                      context, "Hapus informasi ini...?", 2);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$informasi",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Constanst.sizeText),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(Constanst.convertDate(tanggal)),
                        ),
                        gambar == ""
                            ? SizedBox()
                            : Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Constanst.colorPrimary,
                                      borderRadius: Constanst.borderStyle1),
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      ButtonSheetController()
                                          .validasiButtonSheet(
                                              "Detail Foto",
                                              Center(
                                                child: Image.network(
                                                    Api.urlAssetsInformasi +
                                                        gambar),
                                              ),
                                              "lihat_foto",
                                              () {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Lihat Foto",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: Constanst.defaultMarginPadding,
                    ),
                    Divider(
                      height: 5,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget viewPrintLaporan() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Laporan Keuangan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: Constanst.defaultMarginPadding,
          ),
          SizedBox(
            height: Constanst.defaultMarginPadding,
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
                      child: Text("Dari Tanggal",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: DateTimeField(
                      format: DateFormat('dd-MM-yyyy'),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Press Here...'),
                      controller: controller.tanggalMulai.value,
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
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Sampai Tanggal",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: DateTimeField(
                      format: DateFormat('dd-MM-yyyy'),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Press Here...'),
                      controller: controller.tanggalSampai.value,
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
                ],
              ))
            ],
          ),
          SizedBox(
            height: Constanst.defaultMarginPadding,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 11, 27, 70)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ))),
              onPressed: () => controller.printLaporanKeuangan(),
              child: Center(
                child: Text(
                  "Print Laporan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Constanst.defaultMarginPadding,
          ),
          controller.filePdfLaporan.value == ""
              ? SizedBox()
              : Column(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () => controller.showPdfLaporanKeuangan(),
                        child: Image.asset(
                          'assets/image_pdf.png',
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Laporan")
                  ],
                ),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:berlian_laundry/controller/dashboard_controller.dart';
import 'package:berlian_laundry/screen/informasi.dart';
import 'package:berlian_laundry/screen/list_menu.dart';
import 'package:berlian_laundry/screen/login.dart';
import 'package:berlian_laundry/screen/profile_user.dart';
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

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardinState();
}

class _DashboardinState extends State<Dashboard> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  _DashboardinState createState() => _DashboardinState();

  final controller = Get.put(DashboardController());
  RefreshController refreshController = RefreshController(initialRefresh: true);

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
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: DoubleBackToCloseApp(
              snackBar: SnackBar(
                  backgroundColor: Colors.white,
                  content: SizedBox(
                    height: 30,
                    child: Center(
                      child: Text(
                        'Tap back again to leave',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )),
              child: Obx(
                () => Stack(
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
                        line1(),
                        SizedBox(
                          height: 10,
                        ),
                        line2()
                      ],
                    )
                  ],
                ),
              )),
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
              label: 'Profile',
              onTap: () => setState(() {
                if (AppData.statusLogin == false) {
                  Get.offAll(Login());
                } else {
                  Get.offAll(ProfileUser());
                }
              }),
            ),
            SpeedDialChild(
              child: Icon(Icons.local_convenience_store_rounded),
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              label: 'List Harga',
              onTap: () => setState(() {
                controller.idKategoriSelected.value = 1;
                controller.convertMenu();
                Get.offAll(ListMenu());
              }),
            ),
            SpeedDialChild(
              child: Icon(Icons.info_outline),
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              label: 'Informasi',
              onTap: () => setState(() {
                Get.offAll(Informasi());
              }),
            ),
            SpeedDialChild(
              child: Icon(Icons.phone),
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              label: 'Hubungi Kami',
              onTap: () => setState(() {
                controller.kirimPesanWa();
              }),
            ),
          ],
        ));
  }

  Widget line1() {
    return Padding(
      padding: EdgeInsets.only(
          left: Constanst.defaultMarginPadding,
          right: Constanst.defaultMarginPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Dashboard",
              style: TextStyle(
                  fontSize: Constanst.sizeTitle, color: Constanst.colorWhite),
            ),
          ),
          Divider(
            height: 5,
            color: Constanst.colorWhite,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Kami buka Senin sd Minggu (07.00 - 21.00)",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Constanst.colorWhite),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: controller.banner.value.isEmpty
                ? SizedBox()
                : CarouselSlider.builder(
                    carouselController: controller.corouselDashboard,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      initialPage: 1,
                    ),
                    itemCount: controller.banner.value.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  image: DecorationImage(
                                      alignment: Alignment.topCenter,
                                      image: NetworkImage(Api.urlAssetsBanner +
                                          controller.banner.value[itemIndex]),
                                      fit: BoxFit.fill)),
                            ))),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(
                    child: controller.informasiTutup.value == ""
                        ? SizedBox()
                        : Text(controller.informasiTutup.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Constanst.colorWhite,
                                fontWeight: FontWeight.bold)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget line2() {
    return Flexible(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: controller.statusPencarian == false
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
                              border:
                                  Border.all(width: 1.0, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              onTap: () {},
                              controller: controller.cari.value,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search History"),
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
                                controller.getRiwayatLaundry();
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
                              controller.closePencarian();
                              controller.getRiwayatLaundry();
                              controller.update();
                            },
                            icon: Icon(Icons.close, size: 30)),
                      ],
                    ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(
              //       child: controller.statusPencarian == false
              //           ? Stack(
              //               children: [
              //                 Container(
              //                   margin: const EdgeInsets.only(left: 10),
              //                   height: 30,
              //                   decoration: BoxDecoration(
              //                       color: Colors.white,
              //                       borderRadius: BorderRadius.only(
              //                           topLeft: Radius.circular(15),
              //                           topRight: Radius.circular(15),
              //                           bottomLeft: Radius.circular(15),
              //                           bottomRight: Radius.circular(15)),
              //                       border: Border.all(
              //                           width: 1.0, color: Colors.black)),
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(left: 8),
              //                     child: TextField(
              //                       onTap: () {},
              //                       controller: controller.cari.value,
              //                       decoration: InputDecoration(
              //                           border: InputBorder.none,
              //                           hintText: "Search History"),
              //                       style: TextStyle(
              //                           fontSize: 14.0,
              //                           height: 1.0,
              //                           color: Colors.black),
              //                     ),
              //                   ),
              //                 ),
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.end,
              //                   children: [
              //                     InkWell(
              //                       onTap: () {
              //                         controller.getRiwayatLaundry();
              //                       },
              //                       child: Container(
              //                         alignment: Alignment.centerLeft,
              //                         width: 100,
              //                         height: 30,
              //                         decoration: BoxDecoration(
              //                           color: Colors.blue.shade900,
              //                           borderRadius: BorderRadius.only(
              //                               topLeft: Radius.circular(15),
              //                               topRight: Radius.circular(15),
              //                               bottomLeft: Radius.circular(15),
              //                               bottomRight: Radius.circular(15)),
              //                         ),
              //                         child: Center(
              //                           child: Text(
              //                             "Cari",
              //                             style: TextStyle(color: Colors.white),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             )
              //           : Row(
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: [
              //                 IconButton(
              //                     onPressed: () {
              //                       controller.closePencarian();
              //                       controller.getRiwayatLaundry();
              //                       controller.update();
              //                     },
              //                     icon: Icon(Icons.close, size: 30)),
              //               ],
              //             ),
              //     )
              //   ],
              // ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Riwayat Laundry",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: controller.riwayatLaundry.value.isEmpty &&
                          controller.statusload.value
                      ? Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                              Padding(
                                  child: Container(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 3),
                                      width: 35,
                                      height: 35),
                                  padding: EdgeInsets.only(bottom: 16)),
                              Padding(
                                  child: Text(
                                    'Please wait …',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: EdgeInsets.only(bottom: 4))
                            ]))
                      : controller.riwayatLaundry.value.isEmpty &&
                              !controller.statusload.value
                          ? Center(
                              child: Text(
                                "Tidak ada riwayat laundry",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : controller.cari.value.text == ""
                              ? riwayatMain()
                              : riwayatLaundryAdaPencarian()),
            )
          ],
        ),
      ),
    );
  }

  Widget riwayatMain() {
    return SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        header: WaterDropHeader(),
        onLoading: () async {
          await Future.delayed(Duration(milliseconds: 1000));
          setState(() {
            controller.getRiwayatLaundry();
            refreshController.loadComplete();
          });
        },
        controller: refreshController,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.riwayatLaundry.value.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      var harga =
                          controller.riwayatLaundry.value[index]['total'];
                      var convert = harga.split('.');
                      var getHarga = convert[0];
                      controller.detilRiwayat(context,
                          controller.riwayatLaundry.value[index], getHarga);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kode",
                                style: TextStyle(fontSize: Constanst.sizeText),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Nama",
                                style: TextStyle(fontSize: Constanst.sizeText),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Status",
                                style: TextStyle(fontSize: Constanst.sizeText),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 85,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ": ${controller.riwayatLaundry.value[index]['kode_pesan']}",
                                style: TextStyle(fontSize: Constanst.sizeText),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                ": ${controller.riwayatLaundry.value[index]['username']}",
                                style: TextStyle(fontSize: Constanst.sizeText),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              controller.riwayatLaundry.value[index]
                                          ['status'] ==
                                      "1"
                                  ? Text(
                                      ": Sedang Proses",
                                      style: TextStyle(
                                          fontSize: Constanst.sizeText,
                                          color: Colors.orange),
                                    )
                                  : controller.riwayatLaundry.value[index]
                                              ['status'] ==
                                          "2"
                                      ? Text(
                                          ": Selesai",
                                          style: TextStyle(
                                              fontSize: Constanst.sizeText,
                                              color: Colors.blue),
                                        )
                                      : controller.riwayatLaundry.value[index]
                                                  ['status'] ==
                                              "3"
                                          ? Text(
                                              ": Sudah di ambil",
                                              style: TextStyle(
                                                  fontSize: Constanst.sizeText,
                                                  color: Colors.green),
                                            )
                                          : SizedBox(),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            }));
  }

  Widget riwayatLaundryAdaPencarian() {
    return ListView.builder(
        itemCount: controller.riwayatLaundry.value.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  var harga = controller.riwayatLaundry.value[index]['total'];
                  var convert = harga.split('.');
                  var getHarga = convert[0];
                  controller.detilRiwayat(context,
                      controller.riwayatLaundry.value[index], getHarga);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kode",
                            style: TextStyle(fontSize: Constanst.sizeText),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Nama",
                            style: TextStyle(fontSize: Constanst.sizeText),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Status",
                            style: TextStyle(fontSize: Constanst.sizeText),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ": ${controller.riwayatLaundry.value[index]['kode_pesan']}",
                            style: TextStyle(fontSize: Constanst.sizeText),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            ": ${controller.riwayatLaundry.value[index]['username']}",
                            style: TextStyle(fontSize: Constanst.sizeText),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          controller.riwayatLaundry.value[index]['status'] ==
                                  "1"
                              ? Text(
                                  ": Sedang Proses",
                                  style: TextStyle(
                                      fontSize: Constanst.sizeText,
                                      color: Colors.orange),
                                )
                              : controller.riwayatLaundry.value[index]
                                          ['status'] ==
                                      "2"
                                  ? Text(
                                      ": Selesai",
                                      style: TextStyle(
                                          fontSize: Constanst.sizeText,
                                          color: Colors.blue),
                                    )
                                  : controller.riwayatLaundry.value[index]
                                              ['status'] ==
                                          "3"
                                      ? Text(
                                          ": Sudah di ambil",
                                          style: TextStyle(
                                              fontSize: Constanst.sizeText,
                                              color: Colors.green),
                                        )
                                      : SizedBox(),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 5,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }
}

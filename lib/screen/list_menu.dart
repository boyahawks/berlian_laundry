// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:berlian_laundry/controller/dashboard_controller.dart';
import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:berlian_laundry/utils/app_data.dart';
import 'package:berlian_laundry/utils/constant.dart';
import 'package:berlian_laundry/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListMenu extends StatelessWidget {
  final controller = Get.put(DashboardController());

  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.offAll(Dashboard());
          return true;
        },
        child: SafeArea(
          child: Obx(
            () => Column(
              children: [
                Flexible(
                    flex: 25,
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
                            SizedBox(
                              height: 16,
                            ),
                            Center(
                              child: Text(
                                "List Menu",
                                style: TextStyle(
                                    color: Constanst.colorWhite,
                                    fontSize: Constanst.sizeTitle),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      controller.kategoriLaundry.value.length,
                                  itemBuilder: (context, index) {
                                    return Obx(
                                      () => InkWell(
                                        onTap: () {
                                          controller.idKategoriSelected.value =
                                              controller.kategoriLaundry
                                                  .value[index]['id_kategori'];
                                          print(controller
                                              .idKategoriSelected.value);
                                          controller.convertMenu();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 8, right: 8),
                                          decoration: BoxDecoration(
                                            color: controller.idKategoriSelected
                                                        .value ==
                                                    controller.kategoriLaundry
                                                            .value[index]
                                                        ['id_kategori']
                                                ? Colors.blue.shade200
                                                : Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                                bottomLeft: Radius.circular(6),
                                                bottomRight:
                                                    Radius.circular(6)),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                controller.kategoriLaundry
                                                        .value[index]
                                                    ['nama_kategori'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ],
                    )),
                Flexible(
                    flex: 75,
                    child: FractionalTranslation(
                        translation: Offset(0.0, -0.15),
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 135, 135, 135)
                                    .withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Obx(
                            () => Container(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                    itemCount:
                                        controller.menuSelected.value.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(controller.menuSelected
                                              .value[index]['nama']),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(controller.menuSelected
                                              .value[index]['kategori']),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(controller.currencyFormatter
                                              .format(int.parse(controller
                                                  .menuSelected
                                                  .value[index]['harga']))),
                                          Divider(
                                            height: 5,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      );
                                    })),
                          ),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

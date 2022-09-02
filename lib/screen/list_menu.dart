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
                              image: NetworkImage(Api.urlAssets + 'latar.png'),
                              fit: BoxFit.cover)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 20,
                            child: Center(
                              child: Text(
                                "List Menu",
                                style: TextStyle(
                                    color: Constanst.colorWhite,
                                    fontSize: Constanst.sizeTitle),
                              ),
                            )),
                        Expanded(
                          flex: 80,
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: GridView.builder(
                                itemCount:
                                    controller.kategoriLaundry.value.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 2,
                                  mainAxisSpacing: 10.0,
                                ),
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
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          color: controller.idKategoriSelected
                                                      .value ==
                                                  controller.kategoriLaundry
                                                          .value[index]
                                                      ['id_kategori']
                                              ? Colors.blue.shade200
                                              : Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.kategoriLaundry
                                                .value[index]['nama_kategori'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Flexible(
                  flex: 3,
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
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: MediaQuery.of(context).size.height,
                            child: GridView.builder(
                              itemCount: controller.menuSelected.value.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 3,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(controller.menuSelected.value[index]
                                        ['nama']),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(controller.menuSelected.value[index]
                                        ['kategori']),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(controller.currencyFormatter.format(
                                        int.parse(controller.menuSelected
                                            .value[index]['harga']))),
                                    Divider(
                                      height: 5,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

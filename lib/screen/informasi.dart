import 'package:berlian_laundry/controller/informasi_controller.dart';
import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Informasi extends StatelessWidget {
  final controller = Get.put(InformasiController());

  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            Get.offAll(Dashboard());
            return true;
          },
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Constanst.defaultMarginPadding,
                ),
                Center(
                  child: Text(
                    "Informasi",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constanst.sizeTitle),
                  ),
                ),
                SizedBox(
                  height: Constanst.defaultMarginPadding,
                ),
                Flexible(
                  flex: 3,
                  child: Obx(
                    () => Padding(
                      padding: EdgeInsets.only(
                          left: Constanst.defaultMarginPadding,
                          right: Constanst.defaultMarginPadding),
                      child: ListView.builder(
                          itemCount: controller.informasi.value.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(controller.informasi.value[index]
                                    ['informasi']),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Publish : ${Constanst.convertDate(controller.informasi.value[index]['date_publish'])}"),
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
                            );
                          }),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

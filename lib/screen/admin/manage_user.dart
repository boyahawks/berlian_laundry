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

class ManageUser extends StatelessWidget {
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
          "MANAGE USER",
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
              child: controller.statusCariUser.value == false
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
                              controller: controller.cari.value,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Cari User"),
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
                                controller.statusCariUser.value = true;
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
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.allUser.value.clear();
                              controller.cari.value.text = "";
                              controller.statusCariUser.value = false;
                              controller.getUsers();
                            },
                            icon: Icon(Icons.close, size: 30)),
                      ],
                    ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Obx(
              () => Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropHeader(),
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    controller.allUser.value.clear();
                    controller.getUsers();
                    controller.refreshController.refreshCompleted();
                  },
                  controller: controller.refreshController,
                  child: ListView.builder(
                      itemCount: controller.allUser.value.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.detilUser(
                                context, controller.allUser.value[index]);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Username : ${controller.allUser.value[index]['username']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constanst.sizeText),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Email : ${controller.allUser.value[index]['email']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constanst.sizeText),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "NoHp : ${controller.allUser.value[index]['no_hp']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constanst.sizeText),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Point : ${controller.allUser.value[index]['point']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constanst.sizeText),
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
                        );
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

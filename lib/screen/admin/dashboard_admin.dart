// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:berlian_laundry/controller/dashboard_admin_controller.dart';
import 'package:berlian_laundry/controller/laundry_controller.dart';
import 'package:berlian_laundry/screen/admin/manage_history.dart';
import 'package:berlian_laundry/screen/admin/manage_informasi.dart';
import 'package:berlian_laundry/screen/admin/manage_laundry.dart';
import 'package:berlian_laundry/screen/admin/manage_menu.dart';
import 'package:berlian_laundry/screen/admin/manage_user.dart';
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

class DashboardAdmin extends StatelessWidget {
  final controller = Get.put(DashboardAdminController());
  final controllerLaundry = Get.put(LaundryController());
  RefreshController refreshController = RefreshController(initialRefresh: true);

  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
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
                  Expanded(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: line1(context),
                      )),
                  Expanded(flex: 90, child: line2(context))
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 2, 23, 82),
        onPressed: () {
          controllerLaundry.onInit();
          Get.offAll(ManageLaundry(), transition: Transition.zoom);
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Icon(Icons.shopping_bag_rounded),
          ),
        ),
      ),
    );
  }

  Widget line1(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Selamat Datang",
                style: TextStyle(
                    fontSize: Constanst.sizeTitle, color: Constanst.colorWhite),
              ),
              Text(
                controller.username.value,
                style: TextStyle(
                    fontSize: Constanst.sizeTitle, color: Constanst.colorWhite),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => controller.logout(context),
              icon: Icon(
                Icons.logout,
                size: 25,
                color: Constanst.colorWhite,
              ),
            ),
          ),
        )
      ],
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
      child: Padding(
        padding: EdgeInsets.only(
            left: Constanst.defaultMarginPadding,
            right: Constanst.defaultMarginPadding),
        child: Obx(
          () => SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              controller.onRefresh();
              controller.onInit();
              refreshController.refreshCompleted();
            },
            controller: refreshController,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  listDashboard(context, Color.fromARGB(255, 17, 90, 138),
                      "JUMLAH USER", controller.allUser.value.length),
                  SizedBox(height: Constanst.defaultMarginPadding),
                  listDashboard(
                      context,
                      Color.fromARGB(255, 15, 116, 167),
                      "HISTORY LAUNDRY",
                      controller.jumlahHistoryBulanIni.value),
                  SizedBox(height: Constanst.defaultMarginPadding),
                  listDashboard(
                      context,
                      Color.fromARGB(255, 18, 158, 165),
                      "PENDAPATAN BULAN INI",
                      controller.currencyFormatter
                          .format(controller.jumlahBulanIni.value)),
                  SizedBox(height: Constanst.defaultMarginPadding),
                  SizedBox(height: Constanst.defaultMarginPadding),
                  Center(
                    child: Text(
                      "MANAGE",
                      style: TextStyle(
                          fontSize: Constanst.sizeTitle,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: Constanst.defaultMarginPadding),
                  SizedBox(height: Constanst.defaultMarginPadding),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      menuSetting(controller.iconMenu.value, "Menu"),
                      menuSetting(controller.iconInformasi.value, "Informasi"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget menuSetting(url, title) {
    return InkWell(
      onTap: () {
        title == "Menu"
            ? Get.offAll(ManageMenu())
            : title == "Informasi"
                ? Get.offAll(ManageInformasi())
                : print("blank");
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(194, 135, 135, 135).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  Api.urlAssetsBanner + url,
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 5),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listDashboard(context, color, title, value) {
    return InkWell(
      onTap: () {
        controller.statusLaundrySelected.value = 1;
        title == "JUMLAH USER"
            ? Get.offAll(ManageUser())
            : title == "HISTORY LAUNDRY"
                ? Get.offAll(ManageHistory())
                : "blank";
      },
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Constanst.colorWhite, fontSize: Constanst.sizeTitle),
            ),
            SizedBox(
              height: Constanst.defaultMarginPadding,
            ),
            Text(
              "$value",
              style: TextStyle(
                  color: Constanst.colorWhite, fontSize: Constanst.sizeTitle),
            ),
          ],
        ),
      ),
    );
  }
}

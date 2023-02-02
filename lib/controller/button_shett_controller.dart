import 'package:berlian_laundry/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ButtonSheetController extends GetxController {
  void validasiButtonSheet(
      String pesan1, Widget content, String type, Function() onTap) {
    showModalBottomSheet(
      context: Get.context!,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 90,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$pesan1",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 10,
                        child: InkWell(
                          onTap: () => Navigator.pop(Get.context!),
                          child: Icon(
                            Iconsax.close_circle,
                            color: Colors.red,
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(),
                SizedBox(
                  height: 16,
                ),
                content,
                SizedBox(
                  height: 16,
                ),
                type == "lihat_foto"
                    ? SizedBox()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: Container(
                                  margin: EdgeInsets.only(left: 8, right: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: Constanst.borderStyle1,
                                      border: Border.all(
                                          color: Constanst.colorPrimary)),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 12),
                                      child: Text(
                                        "Urungkan",
                                        style: TextStyle(
                                            color: Constanst.colorPrimary),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 8, right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: Constanst.borderStyle1,
                                  color: Constanst.colorPrimary),
                              child: InkWell(
                                onTap: () {
                                  if (onTap != null) onTap();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                    child: Text(
                                      "Simpan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          );
        });
      },
    );
  }
}

import 'dart:io';

import 'package:berlian_laundry/utils/constant.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class PrintStrukController extends GetxController {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: '',
    decimalDigits: 2,
  );

  void prosesPrintStruk(
      List dataUserPesan,
      List listPemesanan,
      String kodePesanan,
      String idNomorRiwayatLaundry,
      String tanggalMulai,
      String tanggalSelesai,
      String totalKeseluruhan,
      String statusPesanan) async {
    final pdf = pw.Document();

    final font = await rootBundle.load("assets/fonts/tnr.ttf");
    final fontstyle = pw.Font.ttf(font);

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll57,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.SizedBox(
              height: 4,
            ),

            // HEADER

            pw.Center(
                child: pw.Text(
              "Berlian Laundry",
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                font: fontstyle,
                fontWeight: pw.FontWeight.bold,
                fontSize: 10,
              ),
            )),
            pw.SizedBox(
              height: 6,
            ),
            pw.Center(
                child: pw.Text(
              "Laundry and Dry CLeaning Shop",
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                font: fontstyle,
                fontSize: 10,
              ),
            )),
            pw.SizedBox(
              height: 10,
            ),

            // END HEADER

            // DETAIL CONTENT

            pw.Row(
              children: [
                pw.Expanded(
                  flex: 35,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Nomor",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        "Kode",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        "Nama",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        "Nomor",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        "Tgl Terima",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        "Tgl Selesai",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                    ],
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                    ],
                  ),
                ),
                pw.Expanded(
                    flex: 63,
                    child: pw.Padding(
                        padding: pw.EdgeInsets.only(left: 3),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              "$idNomorRiwayatLaundry",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                            pw.SizedBox(
                              height: 6,
                            ),
                            pw.Text(
                              "$kodePesanan",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                            pw.SizedBox(
                              height: 6,
                            ),
                            pw.Text(
                              "${dataUserPesan[0]['username']}",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                            pw.SizedBox(
                              height: 6,
                            ),
                            pw.Text(
                              "${dataUserPesan[0]['no_hp']}",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                            pw.SizedBox(
                              height: 6,
                            ),
                            pw.Text(
                              "${Constanst.convertPrintStruk(tanggalMulai)}",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                            pw.SizedBox(
                              height: 6,
                            ),
                            pw.Text(
                              "${Constanst.convertPrintStruk(tanggalSelesai)}",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                          ],
                        )))
              ],
            ),
            pw.SizedBox(
              height: 3,
            ),
            pw.Divider(),
            pw.SizedBox(
              height: 6,
            ),
            pw.ListView.builder(
                itemCount: listPemesanan.length,
                itemBuilder: (context, index) {
                  var uraian = listPemesanan[index]['uraian'];
                  var kategori = listPemesanan[index]['kategori'];
                  var jumlah = listPemesanan[index]['jumlah'];
                  var harga = listPemesanan[index]['harga'];
                  var total = listPemesanan[index]['total'];

                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "$uraian - $kategori",
                                  style: pw.TextStyle(
                                      font: fontstyle,
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 8),
                                ),
                                pw.SizedBox(
                                  height: 4,
                                ),
                                pw.Container(
                                    child: pw.Row(children: [
                                  pw.Expanded(
                                    flex: 60,
                                    child: pw.Text(
                                      "${currencyFormatter.format(jumlah)} x ${currencyFormatter.format(Constanst.convertStringRpToDouble(harga))}",
                                      style: pw.TextStyle(
                                          font: fontstyle, fontSize: 9),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 40,
                                    child: pw.Text(
                                        "${currencyFormatter.format(Constanst.convertStringRpToDouble(total))}",
                                        textAlign: pw.TextAlign.right,
                                        style: pw.TextStyle(
                                            font: fontstyle, fontSize: 9)),
                                  ),
                                ])),
                                pw.SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                    flex: 20,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Total",
                            style: pw.TextStyle(
                                font: fontstyle,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 10),
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Text(
                            "Status",
                            style: pw.TextStyle(
                                font: fontstyle,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 10),
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                        ])),
                pw.Expanded(
                    flex: 2,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            ":",
                            style: pw.TextStyle(
                                font: fontstyle,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 10),
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Text(
                            ":",
                            style: pw.TextStyle(
                                font: fontstyle,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 10),
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                        ])),
                pw.Expanded(
                    flex: 78,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            "${currencyFormatter.format(Constanst.convertStringRpToDouble(totalKeseluruhan))}",
                            style: pw.TextStyle(
                                font: fontstyle,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 10),
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Text(
                            "$statusPesanan",
                            style: pw.TextStyle(
                                font: fontstyle,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 10),
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                        ]))
              ],
            ),
            pw.SizedBox(
              height: 3,
            ),
            pw.Divider(),
            pw.SizedBox(
              height: 6,
            ),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 35,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Kode",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        "Nama",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        "Nomor",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        "Tgl Terima",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        "Tgl Selesai",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                    ],
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                            font: fontstyle,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8),
                      ),
                    ],
                  ),
                ),
                pw.Expanded(
                    flex: 63,
                    child: pw.Padding(
                        padding: pw.EdgeInsets.only(left: 3),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              "$kodePesanan",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                            pw.SizedBox(
                              height: 6,
                            ),
                            pw.Text(
                              "${dataUserPesan[0]['username']}",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                            pw.SizedBox(
                              height: 6,
                            ),
                            pw.Text(
                              "${dataUserPesan[0]['no_hp']}",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                            pw.SizedBox(
                              height: 6,
                            ),
                            pw.Text(
                              "${Constanst.convertPrintStruk(tanggalMulai)}",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                            pw.SizedBox(
                              height: 6,
                            ),
                            pw.Text(
                              "${Constanst.convertPrintStruk(tanggalSelesai)}",
                              style: pw.TextStyle(
                                  font: fontstyle,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8),
                            ),
                          ],
                        )))
              ],
            ),
            pw.SizedBox(
              height: 3,
            ),
            pw.Divider(),
            pw.SizedBox(
              height: 6,
            ),
            pw.ListView.builder(
                itemCount: listPemesanan.length,
                itemBuilder: (context, index) {
                  var uraian = listPemesanan[index]['uraian'];
                  var kategori = listPemesanan[index]['kategori'];
                  var jumlah = listPemesanan[index]['jumlah'];
                  var harga = listPemesanan[index]['harga'];
                  var total = listPemesanan[index]['total'];

                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "$uraian - $kategori",
                                  style: pw.TextStyle(
                                      font: fontstyle,
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 8),
                                ),
                                pw.SizedBox(
                                  height: 4,
                                ),
                                pw.Container(
                                    child: pw.Row(children: [
                                  pw.Expanded(
                                    flex: 60,
                                    child: pw.Text(
                                      "${currencyFormatter.format(jumlah)} x ${currencyFormatter.format(Constanst.convertStringRpToDouble(harga))}",
                                      style: pw.TextStyle(
                                          font: fontstyle, fontSize: 9),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 40,
                                    child: pw.Text(
                                        "${currencyFormatter.format(Constanst.convertStringRpToDouble(total))}",
                                        textAlign: pw.TextAlign.right,
                                        style: pw.TextStyle(
                                            font: fontstyle, fontSize: 9)),
                                  ),
                                ])),
                                pw.SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
            pw.SizedBox(
              height: 3,
            ),
            pw.Divider(),
            pw.SizedBox(
              height: 6,
            ),
          ]); // Center
        })); // Page
    final tempDir = await getTemporaryDirectory();
    final file = File(
        "${tempDir.path}/${DateTime.now()}_${dataUserPesan[0]['username']}.pdf");
    await file.writeAsBytes(await pdf.save());
    print(file.path);
    OpenFile.open(file.path);
    // if (type == 2 || type == 3) {

    // } else {
    //   final box = Get.context!.findRenderObject() as RenderBox?;
    //   await Share.shareFiles([file.path],
    //       text: "Detail Struk",
    //       subject: "Pembelian ${dashboardCt.nomorFaktur.value}",
    //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    // }
  }
}

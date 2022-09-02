// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:berlian_laundry/controller/init_controller.dart';
import 'package:berlian_laundry/screen/dashboard.dart';
import 'package:berlian_laundry/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:berlian_laundry/utils/Local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.prefs = await SharedPreferences.getInstance();
  await Permission.camera.request();
  await Geolocator.checkPermission();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Aplikasi Berlian Laundry',
        theme: ThemeData(fontFamily: 'OpenSans'),
        debugShowCheckedModeBanner: false,
        // builder: EasyLoading.init(),
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.put(InitController());

  @override
  void initState() {
    super.initState();
    controller.loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: NetworkImage(Api.urlAssets + 'latar.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Expanded(flex: 40, child: SizedBox()),
                  Expanded(
                      flex: 60,
                      child: Column(
                        children: [
                          // Center(
                          //   child: Container(
                          //     height: 100,
                          //     decoration: BoxDecoration(
                          //         image: DecorationImage(
                          //       alignment: Alignment.center,
                          //       image: NetworkImage(Api.urlAssets + "logo.png"),
                          //     )),
                          //   ),
                          // ),
                          SizedBox(height: 10),
                          Center(
                            child: Text("Berlian Laundry",
                                style: GoogleFonts.allerta(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 5,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          )),
                        ],
                      )),
                ],
              ))
        ],
      ),
    );
  }
}

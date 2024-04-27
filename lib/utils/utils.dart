// ignore_for_file: prefer_const_declarations, prefer_const_constructors, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:inventary_go/routes/app_routes.dart';

final colorPrincipal = HexColor("#E8751A");
final colorSecundario = HexColor("#EEEEEE");
final colorTercero = HexColor("#04ADE4");
final colorTextoApp = Colors.white;
final storage = GetStorage();

barraBusqueda(texto, funcionBusqueda, controllerBusqueda, [lista]) {
  return Flexible(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: controllerBusqueda,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: colorSecundario),
            hintText: "$texto",
            hoverColor: colorSecundario,
            fillColor: colorPrincipal,
            filled: true,
            suffixIcon: IconButton(
                onPressed: () {
                  controllerBusqueda.text = "";
                  lista.clear();
                },
                icon: Icon(Icons.close, color: colorSecundario)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: colorSecundario,
              ),
            )),
        onChanged: funcionBusqueda,
      ),
    ),
  );
}

String formatDate(String dateString) {
  // Parse the input string into DateTime object
  DateTime dateTime = DateTime.parse(dateString);

  // Create a DateFormat object with the desired format and locale
  DateFormat formatter = DateFormat('E dd yyyy');

  // Format the DateTime object using the formatter
  String formattedDate = formatter.format(dateTime);

  return formattedDate;
}

Future<String> escanear() async {
  String barcode;
  try {
    barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    if (barcode != "") {
      print(barcode);
      return barcode;
    }
    if (barcode == "-1") {
      // Get.back();
    }
  } catch (e) {
    print(e);
  }
  return "";
}

alertaCerrarSesion() {
  return Get.defaultDialog(
    backgroundColor: Colors.black,
    titleStyle: const TextStyle(color: Colors.white),
    content: Column(
      children: [
        // BounceInDown(
        //     child: Image.asset(
        //   'assets/img/logo.png',
        //   height: 120,
        // )),
        Text(
          "¿Estás seguro de cerrar sesión?".tr,
          style: const TextStyle(color: Colors.white),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "No",
                  style: TextStyle(color: colorSecundario),
                )),
            ElevatedButton(
                onPressed: () {
                  storage.remove("token");
                  storage.remove("tokenAtlas");
                  Get.offAllNamed(AppRoutes.LOGIN);
                },
                child: Text(
                  "Si",
                  style: TextStyle(color: colorSecundario),
                )),
          ],
        )
      ],
    ),
  );
}

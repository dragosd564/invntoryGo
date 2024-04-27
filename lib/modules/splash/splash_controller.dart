// ignore_for_file: empty_catches, unnecessary_overrides

import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/services/api.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  final storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      irTabs();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  irTabs() {
    final token = storage.read("token");
    actualizarTokenNuevo();
    Timer(const Duration(seconds: 3), () async {
      if (token != null) {
        Get.offAllNamed(AppRoutes.TABS);
      } else {
        Get.offAllNamed(AppRoutes.LOGIN);
      }
    });
  }

  actualizarTokenNuevo() async {
    if (storage.read("user") == null && storage.read("pass") == null) {
      await API.instance.cerrarSesion();
    } else {
      String username = storage.read("user");
      String password = storage.read("pass");
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      await API.instance.postLogin(basicAuth).then((value) {
        storage.write("token", value["result"]["token"]);
        storage.write("nombreUser", value["result"]["nombre"]);
      });
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inventary_go/core/global/alertas.dart';
import 'package:inventary_go/routes/app_routes.dart';

import '../../core/services/api.dart';
import '../../utils/utils.dart';

class LoginController extends GetxController {
  TextEditingController usuarioController = TextEditingController();
  TextEditingController claveController = TextEditingController();

  var verClave = true.obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      existeToken();
    });
  }

  loginEnviar() async {
    loading.value = true;
    String username = usuarioController.text;
    String password = claveController.text;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    storage.write("user", usuarioController.text);
    storage.write("pass", claveController.text);

    if (usuarioController.text.isNotEmpty || claveController.text.isNotEmpty) {
      await API.instance.postLogin(basicAuth).then((value) {
        if (value['success']) {
          loading.value = false;
          storage.write("token", value["result"]["token"]);
          storage.write("nombreUser", value["result"]["nombre"]);
          Get.toNamed(AppRoutes.BODEGA);
        } else {
          loading.value = false;
          alertaError(value['message']);
        }
      });
    } else {
      loading.value = false;
      alertaWarning("Ingrese su usuario y clave para continuar");
    }
  }

  existeToken() {
    var token = storage.read("token");
    if (token != null) {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}

// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_overrides

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inventary_go/core/global/alertas.dart';

import '../../../core/services/api.dart';

class CrearVehiculoController extends GetxController {
  var isloading = false.obs;

  TextEditingController placa = TextEditingController();
  TextEditingController marca = TextEditingController();
  TextEditingController modelo = TextEditingController();
  TextEditingController observacionController = TextEditingController();

  obtenerPlaca(placaNumero) async {
    API.instance.getPlaca(placaNumero).then((value) {
      inspect(value);

      marca.text = value["result"]["marca"];
      modelo.text = value["result"]["modelo"];
    });
  }

  crearVehiculo() async {
    var body = json.encode({
      "placa": placa.text,
      "marca": marca.text,
      "modelo": modelo.text,
      "observacion": observacionController.text,
      "idEstado": true,
    });
    try {
      isloading.value = true;
      await API.instance.postVehiculo(body).then((value) {
        if (value["success"]) {
          isloading.value = false;
          placa.text = "";
          marca.text = "";
          modelo.text = "";
          observacionController.text = "";
          alertaExito("Se ha creado el vehiculo exitosamente", onConfirm: () {
            Get.back();
          });
        } else {
          alertaError(value["message"]);
          isloading.value = false;
        }
      });
    } catch (e) {
      isloading.value = false;
      alertaError("Ocurrió un error al crear el vehiculo ");
    }
  }
}

// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:inventary_go/core/global/alertas.dart';
import 'package:inventary_go/core/models/catalogo.dart';

import '../../../core/models/producto.dart';
import '../../../core/services/api.dart';
import '../../../utils/utils.dart';

class ListaVehiculoController extends GetxController {
  int page = 1;

  RxList<Vehiculo> vehiculos = <Vehiculo>[].obs;
  ScrollController scrollController = ScrollController();
  TextEditingController termino = TextEditingController();

  final isLoading = false.obs;
  var moreData = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> cargarVehiculos() async {
    isLoading.value = true;
    moreData.value = true;
    await API.instance
        .getVehiculos(termino: termino.text, page: page)
        .then((value) {
      page++;
      vehiculos.addAll(value);
      if (value.isEmpty || vehiculos.length < 10) {
        moreData.value = false;
      }
      moreData.value = false;
      isLoading.value = false;
    });
  }

  eliminarProducto(producto) async {
    var usuario = storage.read("usuario");
    final body = {
      "Id": producto.id,
      "UsuarioModificacion": usuario,
      "IpModificacion": "1.1.1"
    };
    var data = json.encode(body);
    try {
      // final productosData = await API.instance.deleteProducto(data);
      // Get.back();
      // alertaExito("Se ha eliminado correctamente el producto");
      // productos.clear();
      // cargarProductos();
    } catch (e) {
      Get.back();
      alertaError("Ocurrió un error al eliminar el producto");
    }
  }
}

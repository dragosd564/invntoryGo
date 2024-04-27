import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/models/cliente.dart';
import '../../../core/services/api.dart';

class ClienteController extends GetxController {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  RxList<Clientes> clientes = <Clientes>[].obs;
  TextEditingController busquedaController = TextEditingController();

  DateTime diaActual = DateTime.now();
  DateTime diaSeleccionado = DateTime(2021);

  int page = 1;
  var isLoading = false.obs;
  var moreData = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCatalogo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  loadCatalogo() async {
    await API.instance.postAltasTokenn();
  }

  cargarClientes() async {
    isLoading.value = true;
    moreData.value = true;
    await API.instance
        .getClientes(termino: busquedaController.text, page: page)
        .then((value) {
      page++;
      clientes.addAll(value);
      if (value.isEmpty || clientes.length < 10) {
        moreData.value = false;
      }
      moreData.value = false;
      isLoading.value = false;
    });
  }
}

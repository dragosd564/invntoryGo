// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/api.dart';

class InicioController extends GetxController
    with SingleGetTickerProviderMixin {
  // VARIABLES
  RxString nombreLocal = "".obs;
  String observacion = "";

  var argumentos = Get.arguments;
  var idFactura = "";

  // LISTAS
  ScrollController scrollController = ScrollController();
  TextEditingController busquedaController = TextEditingController();
  int page = 1;
  RxList rutasCreadas = [].obs;
  var isLoading = false.obs;
  var moreData = true.obs;

  // VARIABLES ESPECIALES
  TabController? tabController;

  //filtros por messes
  var date = DateTime.now();
  DateTimeRange? rangoFecha;

  @override
  void onInit() {
    super.onInit();
    rangoFecha = DateTimeRange(
        start: DateTime(date.year, date.month - 1, date.day),
        end: DateTime.now());
    getRutas();
    // getFacturasUsuarios(rangoFecha?.start, rangoFecha?.end);
  }

  Future<void> getRutas() async {
    isLoading.value = true;
    moreData.value = true;
    await API.instance
        .getRutas(termino: busquedaController.text, page: page)
        .then((value) {
      page++;
      rutasCreadas.addAll(value["result"]);
      if (value.isEmpty || rutasCreadas.length < 10) {
        moreData.value = false;
      }
      moreData.value = false;
      isLoading.value = false;
    });
  }

  getFacturasUsuarios([fechaInicio, fechaFin]) async {
    // rutasCreadas.value = [];
    // await API.instance
    //     .getDocumentosGenerales(local, fechaInicio, fechaFin, 'Facturada')
    //     .then((value) => {
    //           if (value.length > 0)
    //             {
    //               rutasCreadas.value = value,
    //               Timer(const Duration(milliseconds: 800), () async {
    //                 Get.back();
    //               }),
    //             }
    //           else
    //             {
    //               rutasCreadas.value = value,
    //               Timer(const Duration(milliseconds: 800), () async {
    //                 Get.back();
    //               }),
    //             }
    //         });
  }

  buscarFactura(String query) {
    if (query != '') {
      final resultado = rutasCreadas.where((documenosFacturas) {
        final nombreCliente =
            documenosFacturas.cliente?.razonSocial!.toLowerCase();
        final input = query.toLowerCase();
        return nombreCliente.contains(input);
      }).toList();
      rutasCreadas.value = resultado;
    } else {
      getFacturasUsuarios(rangoFecha?.start, rangoFecha?.end);
    }
  }

  estados(estadoActual) {
    switch (estadoActual) {
      case 'Entregado':
        return Colors.green;
    }
  }
}

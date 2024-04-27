// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:inventary_go/core/global/alertas.dart';

import '../../../core/models/catalogo.dart';
import '../../../core/models/producto.dart';
import '../../../core/services/api.dart';
import '../../../utils/utils.dart';

class ProductoController extends GetxController {
  int page = 1;

  RxList productos = [].obs;
  ScrollController scrollController = ScrollController();
  TextEditingController termino = TextEditingController();
  //editar
  TextEditingController codInternoText = TextEditingController();
  TextEditingController codProveedorText = TextEditingController();
  TextEditingController codBarraText = TextEditingController();
  TextEditingController nombreText = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  var formKey1 = GlobalKey<FormState>();

  RxList<Marca> listaMarcas = RxList();
  RxList<Division> listaDivisiones = RxList();
  RxList<Linea> listaLineas = RxList();
  var marca = "".obs;
  var idMarca = 0.obs;
  var division = "".obs;
  var idDivision = 0.obs;
  var linea = "".obs;
  var idLinea = 0.obs;

  final isLoading = false.obs;
  var moreData = true.obs;

  @override
  void onInit() {
    // cargarProductos();
    super.onInit();
  }

  Future<void> cargarProductos() async {
    isLoading.value = true;
    moreData.value = true;
    await API.instance
        .getProductos(termino: termino.text, page: page)
        .then((value) {
      page++;
      productos.addAll(value);
      if (value.isEmpty || productos.length < 10) {
        moreData.value = false;
      }
      moreData.value = false;
      isLoading.value = false;
    });
  }

  alertaEliminarProducto(producto) {
    return Get.defaultDialog(
      backgroundColor: colorPrincipal,
      title: "",
      titleStyle: const TextStyle(color: Colors.white),
      content: Column(
        children: [
          Center(
            child: Text(
              "¿Estás seguro de eliminar este producto?".tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "No".tr,
                    style: TextStyle(color: colorSecundario),
                  )),
              TextButton(
                  onPressed: () async {
                    Get.back();
                    eliminarProducto(producto);
                  },
                  child: Text(
                    "Si".tr,
                    style: TextStyle(color: colorSecundario),
                  )),
            ],
          )
        ],
      ),
    );
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

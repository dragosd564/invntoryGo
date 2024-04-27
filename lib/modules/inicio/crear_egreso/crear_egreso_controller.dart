// ignore_for_file: invalid_use_of_protected_member, unused_local_variable, prefer_typing_uninitialized_variables, argument_type_not_assignable_to_error_handler

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:inventary_go/core/global/alertas.dart';
import 'package:inventary_go/core/models/producto.dart';
import 'package:inventary_go/utils/utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/models/catalogo.dart';
import '../../../core/models/cliente.dart';
import '../../../core/services/api.dart';

class CrearEgresoController extends GetxController {
  DateRangePickerController datePickerController = DateRangePickerController();
  DateTime? date;

  var expander = true.obs;

  RxList listaProductos = [].obs;
  RxList<Clientes> clientes = <Clientes>[].obs;
  RxList productos = [].obs;

  RxList<Vehiculo> vehiculos = <Vehiculo>[].obs;
  RxList<Clientes> conductores = <Clientes>[].obs;

  // Vehiculo? selectedVehicle;
  // Clientes? selectedClient;

  var selectedVehicle = Rx<Vehiculo?>(null);
  var selectedClient = Rx<Clientes?>(null);

  List<TextEditingController>? precioControllers = [];
  List<TextEditingController>? cantidadControllers = [];

  TextEditingController observacionController = TextEditingController();

  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();

  TextEditingController busquedaCliente = TextEditingController();
  TextEditingController busquedaProducto = TextEditingController();

  TextEditingController direccion = TextEditingController();
  TextEditingController latitud = TextEditingController();
  TextEditingController longitud = TextEditingController();

  String selectedDate = '';
  String dateCount = '';

  var range = ''.obs;
  String rangeCount = '';

  int page = 1;
  var isLoading = false.obs;
  var moreData = false.obs;

  var cliente = Clientes().obs;
  var producto = Productos().obs;

  var idEntidadChofer = 0.obs;
  var idVehiculo = 0.obs;

  DateTime? fecha;
  DateTime? startDate;
  DateTime? endDate;

  var isLoadingEgreso = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fecha = DateTime.now();
      startDate = DateTime.now();
      cargarVehiculos(term: "");
      cargarConductor(term: "");
    });
  }

  modificarProducto(index) {
    listaProductos[index].cantidad =
        double.parse(cantidadControllers![index].text);
  }

  eliminarProducto(index, idProducto) {
    var eliminarElemento =
        listaProductos.firstWhere((element) => element["id"] == idProducto);
    listaProductos.remove(eliminarElemento);
    listaProductos.refresh();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate = args.value.startDate;
      fechaInicioController.text = DateFormat('dd/MM/yyyy').format(startDate!);

      endDate = startDate?.add(const Duration(days: 6));
      fechaFinController.text = DateFormat('dd/MM/yyyy').format(endDate!);

      datePickerController.selectedRange = PickerDateRange(startDate, endDate);

      refresh();
      update();
    } else if (args.value is DateTime) {
      selectedDate = args.value.toString();
    } else if (args.value is List<DateTime>) {
      dateCount = args.value.length.toString();
    } else {
      rangeCount = args.value.length.toString();
    }
  }

  cargarClientes() async {
    isLoading.value = true;
    moreData.value = true;
    await API.instance
        .getClientes(termino: busquedaCliente.text, page: page)
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

  cargarProductos() async {
    isLoading.value = true;
    moreData.value = true;
    await API.instance
        .getProductos(termino: busquedaProducto.text, page: page)
        .then((value) {
      print(value);
      page++;
      productos.addAll(value);
      if (value.isEmpty || productos.length < 10) {
        moreData.value = false;
      }
      moreData.value = false;
      isLoading.value = false;
    });
  }

  Future<void> cargarVehiculos({term}) async {
    isLoading.value = true;
    await API.instance.getVehiculos(termino: term).then((value) {
      vehiculos.value = value;
      isLoading.value = false;
    });
  }

  Future<void> cargarConductor({term}) async {
    isLoading.value = true;
    await API.instance.getConductor(termino: term).then((value) {
      conductores.value = value;
      isLoading.value = false;
    });
    String direccion = '';
  }

  agregarProducto(id) async {
    API.instance.getProductoStock(id).then((value) {
      if (value["success"]) {
        listaProductos.add(value["result"]);
        listaProductos.refresh();
      } else {
        alertaError("El producto no tiene stock");
      }
    });
  }

  crearTransferencia() {
    var pedidoDetalle = [];
    for (var producto in listaProductos) {
      var dataPedido = {
        "idProducto": producto["id"],
        "cantidad": producto["cantidad"],
        "idTipoUnidad": producto["idTipoUnidad"],
        "precio": producto["precio"],
        "estado": 1
      };
      pedidoDetalle.add(dataPedido);
    }
    var envio = jsonEncode({
      "idLocalOrigen": storage.read("local"),
      "idLocalDestino": cliente.value.idLocalBodega,
      "idVendedor": storage.read("user").toString().trim(),
      "fecha": fecha!.toIso8601String(),
      "estadoActual": "EMPAQUETADA",
      "observaciones": "",
      "usuarioIngreso": storage.read("user").toString().trim(),
      "fechaIngreso": fecha!.toIso8601String(),
      "guia": {
        "idEntidadChofer": idEntidadChofer.value,
        "idVehiculo": idVehiculo.value,
        "fechaInicio": startDate?.toIso8601String(),
        "fechaFin": endDate?.toIso8601String(),
        "direccionEntrega": direccion.text,
        "latitud": latitud.text ?? "-2.167060",
        "longitud": longitud.text ?? "-79.896493",
        "estado": "ENVIADO",
        // "fotoUrl": ""
      },
      "detalle": pedidoDetalle,
    });
    print(envio);

    validaciones(envio);
  }

  validaciones(dato) {
    if (cliente.value.id != null) {
      validarStock(dato);
    } else {
      alertaWarning("Debe seleccionar un cliente");
    }
  }

  validarStock(dato) {
    if (listaProductos.isNotEmpty) {
      // Verificar que no haya cantidades mayores al stock
      var productosExcedentes = [];
      for (var producto in listaProductos) {
        if (producto["cantidad"] > producto["stock"]) {
          productosExcedentes.add(producto);
        }
      }

      if (productosExcedentes.isNotEmpty) {
        String mensaje =
            "Los siguientes productos tienen cantidades mayores al stock disponible:\n";
        for (var producto in productosExcedentes) {
          mensaje += "- ${producto["producto"]}\n";
        }
        alertaWarning(mensaje);
      } else {
        validarRuta(dato);
      }
    } else {
      alertaWarning("Debe agregar productos");
    }
  }

  validarRuta(dato) {
    if (fechaInicioController.text.isNotEmpty &&
        fechaFinController.text.isNotEmpty) {
      if (idEntidadChofer.value != 0 && idVehiculo.value != 0) {
        if (direccion.text.isNotEmpty &&
            latitud.text.isNotEmpty &&
            longitud.text.isNotEmpty) {
          postTransferencia(dato);
        } else {
          alertaWarning("Complete la informacion de direccion");
        }
      } else {
        alertaWarning("Complete la informacion del coductor");
      }
    } else {
      alertaWarning("Debe selecionar la fecha de inicio y la fecha de fin");
    }
  }

  postTransferencia(dato) async {
    isLoadingEgreso.value = true;
    API.instance.postTransfer(dato).then((value) {
      if (value["success"]) {
        postRuta(value["result"]["idSalida"], value["result"]["idEntrada"]);
      } else {
        isLoadingEgreso.value = false;
        alertaError(value["message"]);
      }
    });
  }

  postRuta(idSalida, idaEntrada) async {
    var ruta = jsonEncode({
      "idEntidad": cliente.value.id, //cliente de la bodega
      "fecha": fecha!.toIso8601String(),
      "descripcion": "Ruta de transferencia",
      "estado": "ENVIADO",
      "rutaDetalle": [
        {
          "idEmpresa": storage.read("local"), //empresa yo
          "idSalidaEntrada": idSalida,
          "fecha": fecha!.toIso8601String()
        },
        {
          "idEmpresa": storage.read("local"),
          "idSalidaEntrada": idaEntrada,
          "fecha": fecha!.toIso8601String()
        }
      ]
    });
    print(ruta);
    await API.instance.postRuta(ruta).then((value) {
      isLoadingEgreso.value = false;
      if (value["success"]) {
        alertaExito("Transferencia creada exitosamente", onConfirm: () {
          Get.back();
        });
      } else {
        alertaError(value["message"]);
      }
    });
  }
}

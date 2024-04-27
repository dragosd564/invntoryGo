// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_overrides

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:inventary_go/core/global/alertas.dart';
import 'package:inventary_go/routes/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/models/catalogo.dart';
import '../../../core/services/api.dart';

class CrearClienteController extends GetxController {
  final picker = ImagePicker();
  var pickedFile;
  final storage = GetStorage();
  var opcionTipoIdentificacion = "C".obs;
  Uint8List? imagen;
  File? file;
  RxList<Pais> paises = <Pais>[].obs;
  RxList<Provincia> provincias = <Provincia>[].obs;
  RxList<Ciudad> ciudades = <Ciudad>[].obs;
  RxList<Sector> sectores = <Sector>[].obs;
  RxList<Chofer> conductores = <Chofer>[].obs;

  var selectedChofer = Rx<Chofer?>(null);

  RxList<dynamic> tiposIdentificacion = <dynamic>[
    {"key": "C", "valor": "Cédula"},
    {"key": "R", "valor": "Ruc"},
    {"key": "P", "valor": "Pasaporte"}
  ].obs;

  TextEditingController razonsocialController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController observacionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController identificacionController = TextEditingController();
  TextEditingController fechaNacimientoController = TextEditingController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime diaActual = DateTime.now();
  DateTime diaSeleccionado = DateTime(2021);

  String imagen64 = "";

  var esPedido = false;
  var isloading = false.obs;
  var isloadingChofer = false.obs;
  var esChofer = false.obs;
  var maximo = 10.obs;

  var opcionPais = Pais().obs;
  var opcionProvincia = Provincia().obs;
  var opcionCiudad = Ciudad().obs;
  var opcionSector = Sector().obs;

  String? codigoPais;

  String inisionSesion = "";

  ///VARIABLES TUTORIAL

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      codigoPais = "+593";
      cargarConductores("");
      opcionPais.value.nacionalidad = "";
      opcionProvincia.value.nombre = "";
      opcionCiudad.value.nombre = "";
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  cargarPaises() async {
    paises.value = await API.instance.getPaises();
    opcionPais.value = paises.firstWhere((element) => element.codigo == "EC");
    opcionPais.value.id =
        paises.firstWhere((element) => element.codigo == "EC").id;
    opcionPais.refresh();
    cargarProvincias(paises.firstWhere((element) => element.codigo == "EC").id);
  }

  cargarProvincias(idPais) async {
    provincias.value = await API.instance.getProvinciasByIdPais(idPais);
  }

  cargarCiudades(idProvinncia) async {
    ciudades.value = await API.instance.getCiudadByIdProvincia(idProvinncia);
  }

  Future<void> cargarConductores(term) async {
    isloadingChofer.value = true;
    await API.instance.getUsurio(termino: term).then((value) {
      conductores.value = value;
      isloadingChofer.value = false;
    });
  }

  tomarFoto() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Permission.camera.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
    if (status.isGranted) {
      pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 10);
      if (pickedFile != null) {
        file = File(pickedFile.path);
        imagen = file!.readAsBytesSync();
        imagen64 = base64Encode(imagen!);
        alertaExito("Se ha cargado la imagen");
      } else {
        alertaWarning("No has tomado foto");
      }
    }
  }

  tomarUbicacion() async {
    Get.toNamed(AppRoutes.MAPA);
  }

  crearCliente() async {
    var latitud = storage.read("latitud");
    var longitud = storage.read("longitud");

    var body = json.encode({
      "tipoEntidad": "PERSONA",
      "tipoIdentificacion": opcionTipoIdentificacion.value,
      "razonSocial": razonsocialController.text,
      "identificacion": identificacionController.text,
      "idPais": opcionPais.value.id,
      "idProvincia": opcionProvincia.value.id,
      "idCiudad": opcionCiudad.value.id,
      "direccion": direccionController.text,
      "telefono":
          telefonoController.text.isNotEmpty ? telefonoController.text : null,
      "celular": codigoPais! + celularController.text,
      "correo": correoController.text,
      "observaciones": observacionController.text.isNotEmpty
          ? observacionController.text
          : null,
      "esCliente": true,
      "esProveedor": false,
      "latitud": latitud.toString(),
      "longitud": longitud.toString(),
      "fechaNacimiento": diaActual.toIso8601String(),
      "esConsumidorFinal": false,
      "ipIngreso": "",
      "usuarioIngreso": storage.read("user"),
      "fechaIngreso": diaActual.toIso8601String(),
      "idEstado": 1,
      "chofer": inisionSesion.isNotEmpty ? inisionSesion : null,
      "crearBodega": esChofer.value ? false : true,
    });
    try {
      isloading.value = true;
      await API.instance.postCliente(body).then((value) {
        if (value["success"]) {
          isloading.value = false;
          razonsocialController.text = "";
          identificacionController.text = "";
          telefonoController.text = "";
          direccionController.text = "";
          celularController.text = "";
          correoController.text = "";
          fechaNacimientoController.text = "";
          alertaExito("Se ha creado el cliente exitosamente", onConfirm: () {
            Get.back();
          });
        } else {
          alertaError(value["message"]);
          isloading.value = false;
        }
      });
    } catch (e) {
      isloading.value = false;
      alertaError("Ocurrió un error al crear el cliente ");
    }
  }
}

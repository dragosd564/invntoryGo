// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventary_go/core/global/alertas.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/models/catalogo.dart';
import '../../../core/services/api.dart';
import '../../../utils/utils.dart';

class CrearProductoController extends GetxController {
  var tipo;
  var mostrar = false.obs;
  var isloading = false.obs;

  var nombrepage = 'Producto';
  var currentStep = 0.obs;
  StepperType stepperType = StepperType.vertical;
  var cantidadMinimaText = 1.0;
  RxBool seleccionarIva = false.obs;
  RxBool seleccionarActivo = false.obs;
  RxList<Marca> listaMarcas = RxList();
  RxList<Division> listaDivisiones = RxList();
  RxList<Linea> listaLineas = RxList();
  RxList listaTarifas = [].obs;

  var listaUnidadMedida = ["UNIDAD"].obs;
  DateTime diaActual = DateTime.now();
  var pickedFile;
  File? file;
  Uint8List? imagen;
  final picker = ImagePicker();
  String imagen64 = "";
  var productoPadre = "".obs;
  var tipoProducto = "".obs;
  var marca = "".obs;
  var idMarca = 0.obs;
  var division = "".obs;
  var idDivision = 0.obs;
  var categoria = "".obs;
  var idCategoria = 0.obs;
  var linea = "".obs;
  var idLinea = 0.obs;
  var unidadMedida = "".obs;
  List listaTiposProducto = ["SERVICIO", "PRODUCTO"].obs;
  List listaProductosPadre = ["SERVICIO", "PRODUCTO"].obs;

  var formKey1 = GlobalKey<FormState>();

  var formKey2 = GlobalKey<FormState>();

  var formKey3 = GlobalKey<FormState>();

  TextEditingController codInternoText = TextEditingController();
  TextEditingController codProveedorText = TextEditingController();
  TextEditingController codBarraText = TextEditingController();
  TextEditingController nombreText = TextEditingController();
  TextEditingController descripcionText = TextEditingController();
  TextEditingController costoText = TextEditingController();
  TextEditingController registroSanitarioText = TextEditingController();
  TextEditingController pesoText = TextEditingController();
  TextEditingController volumenText = TextEditingController();

  var cambiarFoto = false.obs;

  RxString selectedPosition = "".obs;
  RxString selectedPositionString = "".obs;
  RxInt idPosition = 0.obs;
  RxInt porcentajeIva = 0.obs;

  @override
  void onInit() {
    super.onInit();
    cargarMarca();
    cargarDivisiones();
  }

  cargarMarca() async {
    try {
      listaMarcas.value = await API.instance.getMarcas();
    } catch (e) {
      alertaError("Ocurrió un error interno al traer las marcas");
    }
  }

  cargarDivisiones() async {
    try {
      listaDivisiones.value = await API.instance.getDivisiones();
    } catch (e) {
      alertaError("Ocurrió un error interno al traer las divisiones");
    }
  }

  cargarLineas(idDivision) async {
    try {
      listaLineas.value = await API.instance.getLineaByIdDivision(idDivision);
    } catch (e) {
      alertaError("Ocurrió un error interno al traer las líneas");
    }
  }

  tomarFoto() async {
    cambiarFoto.value = false;
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Permission.camera.request();
    }
    if (status.isGranted) {
      pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 10);
      if (pickedFile != null) {
        file = File(pickedFile.path);
        imagen = file!.readAsBytesSync();
        imagen64 = base64Encode(imagen!);
        Get.back();
        alertaExito("Se ha cargado la imagen");
        cambiarFoto.value = true;
      } else {
        alertaWarning("No has tomado foto");
      }
    }
  }

  seleccionarFoto() async {
    cambiarFoto.value = false;
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Permission.camera.request();
    }
    if (status.isGranted) {
      pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
      if (pickedFile != null) {
        file = File(pickedFile.path);
        imagen = file!.readAsBytesSync();
        imagen64 = base64Encode(imagen!);
        Get.back();
        alertaExito("Se ha cargado la imagen");
        cambiarFoto.value = true;
      } else {
        alertaWarning("No has tomado foto");
      }
    }
  }

  alertaFoto() {
    return Get.defaultDialog(
      backgroundColor: colorPrincipal,
      title: "",
      titleStyle: TextStyle(color: Colors.white),
      content: Column(
        children: [
          // Image.asset(
          //   'assets/img/logo.png',
          //   height: 120,
          // ),
          Text(
            "¿Qué deseas realizar?".tr,
            style: TextStyle(color: Colors.white),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(colorSecundario)),
                    onPressed: () {
                      tomarFoto();
                    },
                    child: Icon(FontAwesomeIcons.camera, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(colorSecundario)),
                    onPressed: () async {
                      seleccionarFoto();
                    },
                    child: Icon(Icons.photo_library, color: Colors.black)),
              ),
            ],
          )
        ],
      ),
    );
  }

  guardar() async {
    final body = {
      "codigoInterno": codInternoText.text,
      "codigoBarra": codProveedorText.text,
      "producto": nombreText.text,
      "descripcion": descripcionText.text,
      "stock": 0,
      "stockMinimo": cantidadMinimaText.toInt(),
      "idEstado": seleccionarActivo.value == true ? 1 : 0,
      "codigoProductoPadre": "",
      "pathArchivo": "",
      "marca": marca.value,
      "idMarca": idMarca.value,
      "division": division.value,
      "idDivision": idDivision.value,
      "linea": linea.value,
      "idLinea": idLinea.value,
      "categoria": "",
      "idCategoria": 0,
      "productoPadre": 0,
      "idEmpresa": 0,
      "photoUrl": "",
      "cobraIva": false,
      "tipoProducto": "PRODUCTO",
      "descuento": 0,
      "codigoProveedor": codProveedorText.text,
      "descipcionBusqueda": "",
      "costo": 0,
      "unidadMedida": 1,
      "peso": 0,
      "volumen": 0,
      "registroSanitario": "",
      "ipIngreso": "",
      "usuarioIngreso": storage.read("user"),
      "fechaIngreso": diaActual.toIso8601String(),
      "ipModificacion": "",
      "usuarioModificacion": "",
      "fechaModificacion": diaActual.toIso8601String(),
      "hasFotoChanges": true,
      "foto": imagen64,
      "idLocal": storage.read("local"),
      "idTarifaImpuesto": 0,
      "porcentajeTarifaImpuesto": 0,
      "tipoUnidadDefecto": true
    };
    var enviarProducto = json.encode(body);
    try {
      isloading.value = true;
      await API.instance.postProducto(enviarProducto).then((value) {
        if (value["success"]) {
          isloading.value = false;
          alertaExito("Se ha creado el producto exitosamente", onConfirm: () {
            Get.back();
          });
        } else {
          alertaError(value["message"]);
          isloading.value = false;
        }
      });
    } catch (e) {
      isloading.value = false;
      alertaError("Ocurrió un error al crear el producto");
    }
  }
}

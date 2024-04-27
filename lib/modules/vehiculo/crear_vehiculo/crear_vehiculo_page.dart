// ignore_for_file: invalid_use_of_protected_member

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventary_go/core/global/alertas.dart';
import '../../../core/models/catalogo.dart';
import '../../../utils/utils.dart';
import 'crear_vehiculo_controller.dart';

class CrearVehiculoPage extends GetWidget<CrearVehiculoController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  CrearVehiculoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              "Vehiculo",
              style:
                  TextStyle(fontSize: Get.width * 0.06, color: colorTextoApp),
            ),
            backgroundColor: colorPrincipal,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                children: [
                  CupertinoFormSection(
                    children: [
                      textPlaca(),
                      textMarca(),
                      textModelo(),
                      textObservaciones(),
                      // _botones()
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            width: Get.width * 0.1,
            height: Get.height * 0.06,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrincipal,
                    shape: const RoundedRectangleBorder()),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    alertaWarning(
                        "Complete los campos restantes para continuar");
                  } else {
                    controller.crearVehiculo();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.save, color: colorTextoApp),
                    ),
                    const Text(
                      "Crear vehiculo",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
          ),
        ),
        Obx(() => controller.isloading.value
            ? Container(
                width: Get.width * 1,
                height: Get.height * 1,
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: CircularProgressIndicator(color: colorSecundario),
                ),
              )
            : Container())
      ],
    );
  }

  Widget textPlaca() {
    return CupertinoTextFormFieldRow(
      keyboardType: TextInputType.text,
      prefix: Text(
        'Placa : '.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      validator: (value) {
        // Expresión regular para validar una placa de vehículo en formato PDN7569
        RegExp regex = RegExp(r'^[A-Z]{3}\d{4}$');
        if (value!.isEmpty) {
          return "Placa es requerido";
        } else if (!regex.hasMatch(value)) {
          return "Placa no válida";
        }
        controller.obtenerPlaca(value);
        return null;
      },
      placeholder: "PDN7569",
      controller: controller.placa,
    );
  }

  Widget textMarca() {
    return CupertinoTextFormFieldRow(
      prefix: Text(
        'Marca: '.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Marca es requerido";
        }
        return null;
      },
      placeholder: "Chevrolet",
      controller: controller.marca,
    );
  }

  Widget textModelo() {
    return CupertinoTextFormFieldRow(
      prefix: Text(
        'Modelo:'.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Modelo es requerido";
        }
        return null;
      },
      placeholder: "",
      controller: controller.modelo,
    );
  }

  Widget textObservaciones() {
    return CupertinoTextFormFieldRow(
      prefix: Text(
        'Observaciones: '.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      placeholder: "Ingrese observación",
      controller: controller.observacionController,
    );
  }
}

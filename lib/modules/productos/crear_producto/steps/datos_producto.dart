import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';
import '../crear_producto_controller.dart';

class DatosProducto extends GetWidget<CrearProductoController> {
  const DatosProducto({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.formKey1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            CupertinoFormSection(children: [
              codigoProveedor(),
              codigoInterno(),
              producto(),
              descripcion(),
              stockMinimo(),
            ]),
            activo()
          ],
        ));
  }

  Widget codigoProveedor() {
    return CupertinoFormRow(
      prefix: Text("Cod. Proveedor".tr,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      child: CupertinoTextFormFieldRow(
        validator: (value) {
          if (value!.isEmpty) {
            return "Código es requerido".tr;
          }
          return null;
        },
        controller: controller.codProveedorText,
        placeholder: "Ingresa un código",
      ),
    );
  }

  Widget codigoInterno() {
    return CupertinoFormRow(
      prefix: Text("Cod. Interno".tr,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      child: CupertinoTextFormFieldRow(
        validator: (value) {
          if (value!.isEmpty) {
            return "Código es requerido";
          }
          return null;
        },
        controller: controller.codInternoText,
        placeholder: "Ingresa un código",
      ),
    );
  }

  Widget codigoBarra() {
    return CupertinoFormRow(
      prefix: Text("Cod. Barra".tr,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      child: CupertinoTextFormFieldRow(
        controller: controller.codBarraText,
        placeholder: "Ingresa un código",
      ),
    );
  }

  Widget producto() {
    return CupertinoFormRow(
      prefix: Text("Nombre".tr,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      child: CupertinoTextFormFieldRow(
        validator: (value) {
          if (value!.isEmpty) {
            return "Nombre es requerido";
          }
          return null;
        },
        controller: controller.nombreText,
        placeholder: "Ingresa un nombre",
      ),
    );
  }

  Widget stockMinimo() {
    return CupertinoFormRow(
        prefix: Row(
          children: [
            const Text("Stock. Min",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              width: Get.width * 0.44,
              child: CupertinoSpinBox(
                min: 1,
                max: 100000,
                value: controller.cantidadMinimaText.toDouble(),
                // onChanged: ((cambio) {
                //   controller.cambioCantidad(index, cambio);
                // }),
              ),
            ),
          ],
        ),
        child: CupertinoTextFormFieldRow(placeholder: "Ingrese un stock"));
  }

  descripcion() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormField(
          decoration: InputDecoration.collapsed(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              hintText: "Ingresa una descripción".tr),
          validator: (value) {
            if (value!.isEmpty) {
              return "Descripción es requerido";
            }
            return null;
          },
          controller: controller.descripcionText,
          maxLines: 3,
          onChanged: (descripcion) {},
        ));
  }

  Widget activo() {
    return Obx(() => CheckboxListTile(
          title: Text("Activo".tr),
          value: controller.seleccionarActivo.value,
          activeColor: colorPrincipal,
          onChanged: (value) {
            controller.seleccionarActivo.value = value!;
            if (value == true) {}
          },
        ));
  }
}

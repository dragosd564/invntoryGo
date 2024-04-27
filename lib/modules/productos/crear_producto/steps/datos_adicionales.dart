// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/catalogo.dart';
import '../../../../utils/utils.dart';
import '../crear_producto_controller.dart';

class DatosAdicionales extends GetWidget<CrearProductoController> {
  const DatosAdicionales({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        CupertinoFormSection(children: [
          seleccionarMarca(),
          seleccionarDivision(),
          seleccionarLinea(),
        ])
      ],
    );
  }

  seleccionarMarca() {
    return CupertinoFormRow(
      prefix: Container(
          width: Get.width * 0.65,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: ListTile(
            title: Obx(
              () => DropdownButton(
                  hint: Obx(() => controller.marca.value != ""
                      ? Text(controller.marca.value,
                          style: const TextStyle(fontWeight: FontWeight.bold))
                      : const Text("Marca",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  isExpanded: true,
                  underline: Container(),
                  dropdownColor: colorPrincipal,
                  icon: Icon(Icons.arrow_drop_down_circle_sharp,
                      color: colorSecundario),
                  items: controller.listaMarcas.map((type) {
                    return DropdownMenuItem<Marca>(
                      value: type,
                      child: Text(
                        type.marca.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (Marca? opt) {
                    controller.marca.value = opt!.marca!;

                    controller.idMarca.value = opt.id!;

                    controller.refresh();
                  }),
            ),
          )),
      child: CupertinoTextFormFieldRow(
        placeholder: "",
      ),
    );
  }

  seleccionarDivision() {
    return CupertinoFormRow(
      prefix: Container(
          width: Get.width * 0.65,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: ListTile(
            title: Obx(
              () => DropdownButton(
                  hint: Obx(() => controller.division.value != ""
                      ? Text(controller.division.value,
                          style: const TextStyle(fontWeight: FontWeight.bold))
                      : const Text("División",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  isExpanded: true,
                  underline: Container(),
                  dropdownColor: colorPrincipal,
                  icon: Icon(Icons.arrow_drop_down_circle_sharp,
                      color: colorSecundario),
                  items: controller.listaDivisiones.map((type) {
                    return DropdownMenuItem<Division>(
                      value: type,
                      child: Text(
                        type.division.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (Division? opt) {
                    controller.division.value = opt!.division!;
                    controller.idDivision.value = opt.id!;
                    controller.cargarLineas(opt.id!);

                    controller.refresh();
                  }),
            ),
          )),
      child: CupertinoTextFormFieldRow(
        placeholder: "",
      ),
    );
  }

  seleccionarLinea() {
    return CupertinoFormRow(
      prefix: Container(
          width: Get.width * 0.65,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: ListTile(
            title: Obx(
              () => DropdownButton(
                  hint: Obx(() => controller.linea.value != ""
                      ? Text(controller.linea.value,
                          style: const TextStyle(fontWeight: FontWeight.bold))
                      : const Text("Línea",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  isExpanded: true,
                  underline: Container(),
                  dropdownColor: colorPrincipal,
                  icon: Icon(Icons.arrow_drop_down_circle_sharp,
                      color: colorSecundario),
                  items: controller.listaLineas.map((type) {
                    return DropdownMenuItem<Linea>(
                      value: type,
                      child: Text(
                        type.linea.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (Linea? opt) {
                    controller.linea.value = opt!.linea!;
                    controller.idLinea.value = opt.id!;

                    controller.refresh();
                  }),
            ),
          )),
      child: CupertinoTextFormFieldRow(
        placeholder: "",
      ),
    );
  }

  dopSelect() {
    return DropdownButton(
        hint: Obx(() => controller.marca.value != ""
            ? Text(controller.marca.value,
                style: const TextStyle(fontWeight: FontWeight.bold))
            : const Text("Marca",
                style: TextStyle(fontWeight: FontWeight.bold))),
        isExpanded: true,
        underline: Container(),
        dropdownColor: colorPrincipal,
        icon: Icon(Icons.arrow_drop_down_circle_sharp, color: colorSecundario),
        items: controller.listaMarcas.map((type) {
          return DropdownMenuItem<Marca>(
            value: type,
            child: Text(
              type.marca.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
        onChanged: (Marca? opt) {
          controller.marca.value = opt!.marca!;
          controller.idMarca.value = opt.id!;

          controller.refresh();
        });
  }
}

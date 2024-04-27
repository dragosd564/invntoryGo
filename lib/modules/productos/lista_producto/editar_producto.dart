import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/models/catalogo.dart';
import '../../../core/models/producto.dart';
import '../../../core/services/api.dart';
import '../../../utils/utils.dart';
import 'producto_controller.dart';

class EditarProductoPage extends StatefulWidget {
  final Productos? producto;

  const EditarProductoPage({Key? key, this.producto}) : super(key: key);

  @override
  State<EditarProductoPage> createState() => _EditarProductoPageState();
}

class _EditarProductoPageState extends State<EditarProductoPage> {
  final productoController = Get.find<ProductoController>();

  @override
  void initState() {
    productoController.codInternoText.text = widget.producto!.codigoInterno!;
    productoController.codProveedorText.text =
        widget.producto!.codigoProveedor!;
    productoController.codBarraText.text = widget.producto!.codigoBarra!;
    productoController.nombreText.text = widget.producto!.producto!;
    productoController.descripcion.text = widget.producto!.descripcion!;

    super.initState();
  }

  cargarMarca() async {
    await API.instance.getMarcas().then((value) {
      inspect(value);
      // productoController.listaMarcas.value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: productoController.formKey1,
        child: ListView(shrinkWrap: true, children: [
          SizedBox(
            height: 330,
            child: Stack(
              children: [
                Positioned(
                    top: 30,
                    left: 24,
                    right: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: colorPrincipal,
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: widget.producto!.pathArchivo!.isNotEmpty
                      ? Image.network(
                          widget.producto!.pathArchivo!,
                          width: 250,
                          height: 225,
                        ).animate().fade().scale(
                            duration: 800.ms,
                            curve: Curves.fastOutSlowIn,
                          )
                      : CircleAvatar(
                          radius: Get.width * 0.2,
                          child: Icon(
                            Icons.description,
                            size: Get.width * 0.2,
                          ).animate().fade().scale(
                                duration: 800.ms,
                                curve: Curves.fastOutSlowIn,
                              ),
                        ),
                ),
              ],
            ),
          ),
          8.verticalSpace,
          codigos(),
          8.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: const Text("Nombre del producto",
                    style: TextStyle(fontWeight: FontWeight.bold))
                .animate()
                .fade()
                .slideX(
                  duration: 300.ms,
                  begin: -1,
                  curve: Curves.easeInSine,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: colorPrincipal),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration.collapsed(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Ingresa el nombre del producto".tr),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Descripción es requerido";
                      }
                      return null;
                    },
                    controller: productoController.nombreText,
                  )),
            ),
          ).animate().fade().slideX(
                duration: 300.ms,
                begin: -1,
                curve: Curves.easeInSine,
              ),
          8.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: const Text("Descripcion",
                    style: TextStyle(fontWeight: FontWeight.bold))
                .animate()
                .fade()
                .slideX(
                  duration: 300.ms,
                  begin: -1,
                  curve: Curves.easeInSine,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: colorPrincipal),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration.collapsed(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Ingresa una descripción".tr),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Descripción es requerido";
                      }
                      return null;
                    },
                    controller: productoController.descripcion,
                    maxLines: 3,
                  )),
            ),
          ).animate().fade().slideX(
                duration: 300.ms,
                begin: -1,
                curve: Curves.easeInSine,
              ),
          // 8.verticalSpace,
          // tipos()
        ]),
      ),
    );
  }

  Widget codigos() {
    return SizedBox(
      width: Get.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Cod.Proveedor",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: colorPrincipal),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Ingresa el codigo proveedor".tr),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "codigo proveedor es requerido";
                          }
                          return null;
                        },
                        controller: productoController.codProveedorText,
                      )),
                ),
              ),
            ],
          ).animate().fade().slideX(
                duration: 300.ms,
                begin: -1,
                curve: Curves.easeInSine,
              ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Cod.Interno",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: colorPrincipal),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Ingresa el codigo Interno".tr),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "codigo Interno es requerido";
                          }
                          return null;
                        },
                        controller: productoController.codInternoText,
                      )),
                ),
              ),
            ],
          ).animate().fade().slideX(
                duration: 300.ms,
                begin: -1,
                curve: Curves.easeInSine,
              ),
        ],
      ),
    );
  }

  Widget tipos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child:
              const Text("Marca", style: TextStyle(fontWeight: FontWeight.bold))
                  .animate()
                  .fade()
                  .slideX(
                    duration: 300.ms,
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: colorPrincipal),
                borderRadius: BorderRadius.circular(10)),
            child: Obx(
              () => DropdownButton(
                  hint: Obx(() => productoController.marca.value != ""
                      ? Text(productoController.marca.value,
                          style: const TextStyle(fontWeight: FontWeight.bold))
                      : const Text("Marca",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  isExpanded: true,
                  underline: Container(),
                  dropdownColor: colorPrincipal,
                  icon: Icon(Icons.arrow_drop_down_circle_sharp,
                      color: colorSecundario),
                  items: productoController.listaMarcas.map((type) {
                    return DropdownMenuItem<Marca>(
                      value: type,
                      child: Text(
                        type.marca.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (Marca? opt) {
                    productoController.marca.value = opt!.marca!;

                    productoController.idMarca.value = opt.id!;

                    productoController.refresh();
                  }),
            ),
          ),
        ).animate().fade().slideX(
              duration: 300.ms,
              begin: -1,
              curve: Curves.easeInSine,
            ),
        8.verticalSpace,
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: const Text("Descripcion",
                  style: TextStyle(fontWeight: FontWeight.bold))
              .animate()
              .fade()
              .slideX(
                duration: 300.ms,
                begin: -1,
                curve: Curves.easeInSine,
              ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: colorPrincipal),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration.collapsed(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Ingresa una descripción".tr),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Descripción es requerido";
                    }
                    return null;
                  },
                  controller: productoController.descripcion,
                  maxLines: 3,
                )),
          ),
        ).animate().fade().slideX(
              duration: 300.ms,
              begin: -1,
              curve: Curves.easeInSine,
            ),
      ],
    );
  }
}

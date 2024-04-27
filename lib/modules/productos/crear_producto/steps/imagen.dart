import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';
import '../crear_producto_controller.dart';

class Imagen extends GetWidget<CrearProductoController> {
  const Imagen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: () {
        controller.alertaFoto();
      },
      child: Obx(() => controller.cambiarFoto.value == false
          ? Container(
              height: Get.height * 0.35,
              width: Get.width * 0.9,
              decoration: BoxDecoration(
                  color: colorSecundario,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Icon(FontAwesomeIcons.camera,
                  color: Colors.white, size: Get.width * 0.15))
          : Stack(
              children: [
                Container(
                    height: Get.height * 0.35,
                    width: Get.width * 0.9,
                    decoration: controller.imagen != null
                        ? BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(controller.imagen!),
                                fit: BoxFit.cover),
                            color: colorSecundario,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)))
                        : const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/img/sin-producto.png"))),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            width: Get.width * 1,
                            height: Get.height * 0.06,
                            decoration: BoxDecoration(color: colorSecundario),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(FontAwesomeIcons.camera,
                                  color: Colors.black),
                            )))),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        width: Get.width * 0.1,
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(color: colorSecundario),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child:
                              Icon(FontAwesomeIcons.close, color: Colors.black),
                        )))
              ],
            )),
    ));
  }
}

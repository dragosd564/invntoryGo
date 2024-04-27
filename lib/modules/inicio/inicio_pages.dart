import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventary_go/core/global/custom_inputs.dart';
import 'package:inventary_go/core/global/paginateList.dart';
import 'package:inventary_go/routes/app_routes.dart';

import '../../utils/utils.dart';
import 'inicio_controller.dart';

final formatCurrency = NumberFormat.simpleCurrency();

class InicioPage extends GetWidget<InicioController> {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrincipal,
          title: GestureDetector(
            onTap: () {
              storage.remove("token");
              Get.offAllNamed(AppRoutes.LOGIN);
            },
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  title: const Text(
                    'Bienvenid@',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    storage.read("nombreUser") ?? 'NombreUsuario',
                    style: const TextStyle(color: Colors.white),
                  ),
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundColor: colorSecundario,
                    child: const ClipOval(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        // child: Image.asset(Constants.avatar),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                iconSize: context.isPhone ? Get.width * 0.06 : Get.width * 0.04,
                icon: Icon(Icons.qr_code_scanner_outlined,
                    color: colorSecundario),
                onPressed: () {
                  escanear();
                }),
          ],
        ),
        body: ListView(
          children: [
            cuadroBusqueda(
                controller.busquedaController, "Buscar transferencia",
                onChage: (value) {
              if (value.length >= 3) {
                controller.page = 1;
                controller.rutasCreadas.clear();
                controller.getRutas();
              } else if (value.isEmpty) {
                controller.page = 1;
                controller.rutasCreadas.clear();
                controller.getRutas();
              }
            }, onTapOutside: (p0) {
              if (controller.busquedaController.text.length >= 3) {
                controller.page = 1;
                controller.rutasCreadas.clear();
                controller.getRutas();
              } else if (controller.busquedaController.text.isEmpty) {
                controller.page = 1;
                controller.rutasCreadas.clear();
                controller.getRutas();
              }
            }),
            Obx(() => controller.rutasCreadas.isNotEmpty
                ? listaDocumentos()
                : controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: colorPrincipal,
                        ),
                      )
                    : const Center(
                        child: Text("No tiene transferencias creadas"),
                      ))
          ],
        ),
        floatingActionButton: addInpunts(
            tooltip: 'Crear Egreso',
            ruta: () {
              Get.toNamed(AppRoutes.CREAR_EGRESO);
            }));
  }

  Widget listaDocumentos() {
    return SizedBox(
        height: Get.height * 0.7,
        child: PaginatedListView(
            lista: controller.rutasCreadas,
            ajuste: true,
            pageSize: 10,
            padding: 0,
            margin: 0,
            hasMore: controller.moreData,
            itemBuilder: (context, index) {
              var formatFecha = (String date) {
                var fecha = DateTime.parse(date);
                return DateFormat('dd/MM/yyyy HH:mm').format(fecha);
              };
              var ruta = controller.rutasCreadas[index];
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      // SlidableAction(
                      //   flex: 1,
                      //   onPressed: (BuildContext context) {},
                      //   backgroundColor: colorTercero,
                      //   foregroundColor: Colors.white,
                      //   borderRadius: BorderRadius.circular(4),
                      //   icon: FontAwesomeIcons.ellipsis,
                      //   label: 'Recrear',
                      // ),
                      SlidableAction(
                        flex: 1,
                        onPressed: (BuildContext context) {},
                        backgroundColor: colorPrincipal,
                        foregroundColor: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        icon: FontAwesomeIcons.clone,
                        label: 'Entregar',
                      ),
                    ],
                  ),
                  child: Card(
                    shadowColor: colorTercero,
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: colorSecundario,
                            radius: 25,
                            child: Icon(Icons.local_shipping,
                                color: colorPrincipal),
                          ),
                          Flexible(
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ruta["razonSocial"] ?? 'Nombre cliente',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ruta["ciudad"] ?? "Ciudad",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    maxLines: 3,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Text.rich(TextSpan(
                                      text: "Bodega :",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${ruta["local"] ?? "nombre bodega"}",
                                          style: const TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                      ])),
                                  Text(formatFecha(ruta["fecha"] ?? "fecha"),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            loadNotifications: () {
              controller.getRutas();
            }));
  }
}

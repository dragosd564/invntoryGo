// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventary_go/routes/app_routes.dart';

import '../../../core/global/custom_inputs.dart';
import '../../../core/global/paginateList.dart';
import '../../../utils/utils.dart';
import 'lista_cliente_controller.dart';

class ClientePage extends GetWidget<ClienteController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final clienteController = Get.put(ClienteController());
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  ClientePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorPrincipal,
            title: Text(
              "Clientes".tr,
              style: TextStyle(
                  fontSize:
                      context.isPhone ? Get.width * 0.06 : Get.width * 0.04,
                  color: colorTextoApp),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.busquedaController.text = "";
                    // controller.productos.length = 0;
                  },
                  icon:
                      Icon(Icons.restart_alt_outlined, color: colorSecundario)),
            ],
          ),
          body: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              cuadroBusqueda(
                controller.busquedaController,
                "Busca al cliente",
                onChage: (value) {
                  if (value.length >= 3) {
                    controller.page = 1;
                    controller.clientes.clear();
                    controller.cargarClientes();
                  } else if (value.isEmpty) {
                    controller.page = 1;
                    controller.clientes.clear();
                    controller.cargarClientes();
                  }
                },
                onTapOutside: (p0) {
                  if (controller.busquedaController.text.length >= 3) {
                    controller.page = 1;
                    controller.clientes.clear();
                    controller.cargarClientes();
                  } else if (controller.busquedaController.text.isEmpty) {
                    controller.page = 1;
                    controller.clientes.clear();
                    controller.cargarClientes();
                  }
                },
              ),
              Obx(() => controller.clientes.isNotEmpty
                  ? listaClientes()
                  : controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: colorPrincipal,
                          ),
                        )
                      : Center(
                          child: Text(
                            "No hay clientes",
                            style: TextStyle(color: colorPrincipal),
                          ),
                        ))
            ],
          ),
          floatingActionButton: addInpunts(
              tooltip: 'Crear cliente',
              ruta: () {
                controller.loadCatalogo();
                Get.toNamed(AppRoutes.CREAR_CLIENTE);
              })),
    );
  }

  listaClientes() {
    return SizedBox(
      height: Get.height * 0.7,
      child: PaginatedListView(
        lista: controller.clientes,
        ajuste: true,
        pageSize: 10,
        padding: 0,
        margin: 0,
        hasMore: controller.moreData,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shadowColor: colorTercero,
              surfaceTintColor: Colors.white,
              child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  leading: CircleAvatar(
                    radius: 30,
                    child: ClipOval(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: controller.clientes[index].foto!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: controller.clientes[index].foto!)
                            : Container(),
                      ),
                    ),
                  ),
                  title: Text(
                    controller.clientes[index].razonSocial!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Identificacion : ${controller.clientes[index].identificacion!.toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        'Correo : ${controller.clientes[index].correo!.toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  )),
            ),
          );
        },
        loadNotifications: () {
          controller.cargarClientes();
        },
      ),
    );
  }

  // clientes(index) {
  //   return GestureDetector(
  //     child: FadeIn(
  //       duration: const Duration(milliseconds: 1000),
  //       child: Slidable(
  //         endActionPane: ActionPane(
  //           motion: const ScrollMotion(),
  //           children: [
  //             SlidableAction(
  //               flex: 1,
  //               onPressed: (BuildContext context) {
  //                 Get.toNamed("/editar_cliente",
  //                     arguments: controller.clientes[index].id);
  //               },
  //               backgroundColor: colorPrincipal,
  //               foregroundColor: Colors.white,
  //               borderRadius: BorderRadius.circular(4),
  //               icon: Icons.edit,
  //               label: 'Editar',
  //             ),
  //             SlidableAction(
  //               flex: 1,
  //               onPressed: (BuildContext context) {
  //                 controller.idCliente = controller.clientes[index].id!;
  //                 var datos = {
  //                   "idCliente": controller.idCliente,
  //                   "pageUsed": "clientes",
  //                 };
  //                 // Get.toNamed(Routes.NUEVA_FACTURA, arguments: datos);
  //               },
  //               backgroundColor: colorSecundario,
  //               foregroundColor: Colors.white,
  //               borderRadius: BorderRadius.circular(4),
  //               icon: FontAwesomeIcons.fileInvoice,
  //               label: 'Facturar',
  //             ),
  //           ],
  //         ),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             border: Border.all(color: colorPrincipal),
  //             borderRadius: const BorderRadius.all(Radius.circular(5.0)),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               children: [
  //                 controller.clientes[index].foto != ""
  //                     ? controller.clientes[index].foto != null
  //                         ? CircleAvatar(
  //                             radius: 30.0,
  //                             backgroundColor: Colors.transparent,
  //                             backgroundImage: NetworkImage(
  //                                 controller.clientes[index].foto!),
  //                           )
  //                         : Image.asset("assets/img/usuario.png")
  //                     : Image.asset(
  //                         "assets/img/usuario.png",
  //                         width: 50,
  //                       ),
  //                 Flexible(
  //                   child: ListTile(
  //                     title: Row(
  //                       children: [
  //                         Expanded(
  //                           child: Text(
  //                             controller.clientes[index].razonSocial!,
  //                             style: const TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.black,
  //                                 fontSize: 12),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     subtitle: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             const Text("Identificación: ",
  //                                 style: TextStyle(color: Colors.black)),
  //                             Expanded(
  //                               child: Text(
  //                                   controller.clientes[index].identificacion!,
  //                                   style: const TextStyle(
  //                                       color: Colors.black, fontSize: 12)),
  //                             ),
  //                           ],
  //                         ),
  //                         Row(
  //                           children: [
  //                             const Text("Correo: ",
  //                                 style: TextStyle(color: Colors.black)),
  //                             Expanded(
  //                               child: Text(controller.clientes[index].correo!,
  //                                   style: const TextStyle(
  //                                       color: Colors.black, fontSize: 12)),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  cabezado() {
    return Container(
      width: Get.width * 1,
      height: Get.height * 0.05,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Center(
        child: Text(
          "Opciones".tr,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: colorSecundario,
              fontWeight: FontWeight.bold,
              fontSize: Get.width * 0.04),
        ),
      ),
    );
  }

  // cuerpo() {
  //   return Container(
  //       color: Colors.white,
  //       child: ListView.separated(
  //           shrinkWrap: true,
  //           physics: const ClampingScrollPhysics(),
  //           itemBuilder: (_, int posicion) {
  //             return ListTile(
  //               title: Center(
  //                 child: Text(
  //                   controller.opciones[posicion]["descripcion"].toString(),
  //                   style: TextStyle(
  //                       color: Colors.black54, fontSize: Get.width * 0.04),
  //                 ),
  //               ),
  //               onTap: () {
  //                 switch (controller.opciones[posicion]["id"]) {
  //                   case 2:
  //                     Get.toNamed("/editar_cliente",
  //                         arguments: controller.idCliente);
  //                     break;
  //                   case 3:
  //                     var datos = {
  //                       "idCliente": controller.idCliente,
  //                       "pageUsed": "clientes",
  //                     };
  //                     // Get.toNamed(Routes.NUEVA_FACTURA, arguments: datos);
  //                     break;
  //                 }
  //               },
  //             );
  //           },
  //           separatorBuilder: (_, index) => const Divider(
  //                 color: Colors.black12,
  //               ),
  //           itemCount: controller.opciones.length));
  // }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventary_go/routes/app_routes.dart';
import '../../../core/global/custom_inputs.dart';
import '../../../core/global/paginateList.dart';
import '../../../utils/utils.dart';
import 'lista_vehiculo_controller.dart';

class ListaVehiculoPage extends GetWidget<ListaVehiculoController> {
  const ListaVehiculoPage({super.key});

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
              "Vehiculo".tr,
              style: TextStyle(
                  fontSize:
                      context.isPhone ? Get.width * 0.06 : Get.width * 0.04,
                  color: colorTextoApp),
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              cuadroBusqueda(
                controller.termino,
                "Busca el vehiculo",
                onChage: (value) {
                  if (value.length >= 3) {
                    controller.page = 1;
                    controller.vehiculos.clear();
                    controller.cargarVehiculos();
                  } else if (value.isEmpty) {
                    controller.page = 1;
                    controller.vehiculos.clear();
                    controller.cargarVehiculos();
                  }
                },
                onTapOutside: (p0) {
                  if (controller.termino.text.length >= 3) {
                    controller.page = 1;
                    controller.vehiculos.clear();
                    controller.cargarVehiculos();
                  } else if (controller.termino.text.isEmpty) {
                    controller.page = 1;
                    controller.vehiculos.clear();
                    controller.cargarVehiculos();
                  }
                },
              ),
              Obx(() => controller.vehiculos.isNotEmpty
                  ? listaVehiculos()
                  : controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: colorPrincipal,
                          ),
                        )
                      : Center(
                          child: Text(
                            "No hay vehiculos",
                            style: TextStyle(color: colorPrincipal),
                          ),
                        ))
            ],
          ),
          floatingActionButton: addInpunts(
              tooltip: 'Crear Vehiculo',
              ruta: () {
                Get.toNamed(AppRoutes.CREAR_VEHICULO);
              })),
    );
  }

  listaVehiculos() {
    return SizedBox(
      height: Get.height * 0.7,
      child: PaginatedListView(
        lista: controller.vehiculos,
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
                leading:
                    CircleAvatar(radius: 30, child: Icon(Icons.directions_car)),
                title: Text(
                  controller.vehiculos[index].placa!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis),
                ),
                subtitle: Text(
                  controller.vehiculos[index].modelo!.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          );
        },
        loadNotifications: () {
          controller.cargarVehiculos();
        },
      ),
    );
  }
}

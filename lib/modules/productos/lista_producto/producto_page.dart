import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventary_go/modules/productos/lista_producto/editar_producto.dart';
import 'package:inventary_go/routes/app_routes.dart';
import '../../../core/global/custom_inputs.dart';
import '../../../core/global/paginateList.dart';
import '../../../utils/utils.dart';
import 'producto_controller.dart';

class ProductoPage extends GetWidget<ProductoController> {
  const ProductoPage({super.key});

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
              "Producto".tr,
              style: TextStyle(
                  fontSize:
                      context.isPhone ? Get.width * 0.06 : Get.width * 0.04,
                  color: colorTextoApp),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.termino.text = "";
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
                controller.termino,
                "Busca el producto",
                onChage: (value) {
                  if (value.length >= 3) {
                    controller.page = 1;
                    controller.productos.clear();
                    controller.cargarProductos();
                  } else if (value.isEmpty) {
                    controller.page = 1;
                    controller.productos.clear();
                    controller.cargarProductos();
                  }
                },
                onTapOutside: (p0) {
                  if (controller.termino.text.length >= 3) {
                    controller.page = 1;
                    controller.productos.clear();
                    controller.cargarProductos();
                  } else if (controller.termino.text.isEmpty) {
                    controller.page = 1;
                    controller.productos.clear();
                    controller.cargarProductos();
                  }
                },
              ),
              Obx(() => controller.productos.isNotEmpty
                  ? listaProductos()
                  : controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: colorPrincipal,
                          ),
                        )
                      : Center(
                          child: Text(
                            "No hay productos",
                            style: TextStyle(color: colorPrincipal),
                          ),
                        ))
            ],
          ),
          floatingActionButton: addInpunts(
              tooltip: 'Crear producto',
              ruta: () {
                Get.toNamed(AppRoutes.CREAR_PRODUCTO);
              })),
    );
  }

  botonBuscarProducto() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorSecundario,
          shape: BoxShape.circle,
        ),
        child: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // controller.productos.clear();
              // controller.cargarProductos();
            }),
      ),
    );
  }

  listaProductos() {
    return SizedBox(
      height: Get.height * 0.7,
      child: PaginatedListView(
        lista: controller.productos,
        ajuste: true,
        pageSize: 10,
        padding: 0,
        margin: 0,
        hasMore: controller.moreData,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () async {
                await Get.bottomSheet(
                    EditarProductoPage(
                      producto: controller.productos[index],
                    ),
                    isScrollControlled: true);
              },
              child: Card(
                shadowColor: colorTercero,
                surfaceTintColor: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  leading: CircleAvatar(
                    radius: 30,
                    child: ClipOval(
                      child: Align(
                        alignment: Alignment.center,
                        child: controller
                                .productos[index].pathArchivo!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl:
                                    controller.productos[index].pathArchivo!)
                            : Icon(Icons.description),
                      ),
                    ),
                  ),
                  title: Text(
                    controller.productos[index].producto!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis),
                  ),
                  subtitle: Text(
                    controller.productos[index].descripcion!.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis),
                  ),
                  trailing: Column(
                    children: [
                      const Text(
                        'Stock',
                        style: TextStyle(
                            fontSize: 14, overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        controller.productos[index].stock!.toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
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
          controller.cargarProductos();
        },
      ),
    );
  }
}

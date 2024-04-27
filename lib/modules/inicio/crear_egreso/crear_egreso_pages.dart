// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventary_go/core/global/alertas.dart';
import 'package:inventary_go/core/global/custom_inputs.dart';
import 'package:inventary_go/core/models/catalogo.dart';
import 'package:inventary_go/core/models/cliente.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../core/global/paginateList.dart';
import '../../../utils/utils.dart';
import 'crear_egreso_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final formatCurrency = NumberFormat.simpleCurrency();

class CrearEgresoPage extends GetWidget<CrearEgresoController> {
  const CrearEgresoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: colorPrincipal,
            centerTitle: true,
            title: Text(
              "Crear transferencia",
              style: TextStyle(
                  color: Colors.white,
                  fontSize:
                      context.isPhone ? Get.width * 0.06 : Get.width * 0.04),
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 10),
                titulo("Información del cliente"),
                datosCliente(),
                listaDesplegable('Producto', productos()),
                listaDesplegable('Motivo', inputObservacion()),
                listaDesplegable('Informacion del conductor', formTransporte()),
                listaDesplegable('Fecha de transporte', fechasIngreso()),
                listaDesplegable('Dirección del destino', direccionDestino()),
                totalFacturaYcotizacion(),
              ],
            ),
          ),
          bottomNavigationBar: cargarDatosFlotantes(),
        ),
        Obx(() => controller.isLoadingEgreso.value ? cargando() : Container())
      ],
    );
  }

  cargando() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.black.withOpacity(0.9),
        width: Get.width * 1,
        height: Get.height * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/logoinventarygo.png',
              height: 120,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Creando la factura, espere un momento".tr,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              backgroundColor: colorPrincipal,
              color: colorSecundario,
            )
          ],
        ),
      ),
    );
  }

  formTransporte() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Logístico:'),
        Obx(() => controller.conductores.isNotEmpty
            ? CustomDropDown<Clientes>(
                options: controller.conductores,
                selectedOption: controller.selectedClient,
                onChanged: (newValue) {
                  controller.selectedClient.value = newValue;
                  controller.idEntidadChofer.value = newValue!.id!;
                },
                displayText: (client) => client.razonSocial.toString(),
              )
            : SizedBox(
                width: Get.width * 0.8,
                height: 50,
              )),
        const SizedBox(height: 20),
        const Text('Vehiculo'),
        Obx(() => controller.vehiculos.isNotEmpty
            ? CustomDropDown<Vehiculo>(
                options: controller.vehiculos,
                selectedOption: controller.selectedVehicle,
                onChanged: (newValue) {
                  controller.selectedVehicle.value = newValue;

                  controller.idVehiculo.value = newValue!.id!;
                },
                displayText: (vehicle) => vehicle.placa.toString(),
              )
            : SizedBox(
                width: Get.width * 0.8,
                height: 50,
              )),
      ],
    );
  }

  productos() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Agregar producto".tr,
            style: TextStyle(
                fontSize: Get.width * 0.04, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: Get.width * 0.3),
          botonAgregarProducto(),
        ],
      ),
      infoProducto()
      // tablaProducto()
    ]);
  }

  titulo(texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 20),
      child: Text(
        '$texto'.tr,
        textAlign: TextAlign.left,
        style:
            TextStyle(fontSize: Get.width * 0.05, fontWeight: FontWeight.bold),
      ),
    );
  }

  datosCliente() {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            clientePrueba(),
            SizedBox(height: Get.height * 0.02),
          ],
        ));
  }

  clientePrueba() {
    return Card(
      color: colorPrincipal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            controller.page = 1;
            controller.busquedaCliente.text = "";
            controller.clientes.clear();
            controller.cargarClientes();
            Get.bottomSheet(buscarCliente(), isScrollControlled: true)
                .then((value) {
              controller.cliente.value = value;
              controller.direccion.text =
                  controller.cliente.value.direccion! ?? "";
            });
          },
          child: ListTile(
            trailing: controller.cliente.value.foto != ""
                ? controller.cliente.value.foto != null
                    ? CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            NetworkImage(controller.cliente.value.foto!),
                      )
                    : CircleAvatar(
                        radius: 30.0,
                        backgroundColor: colorSecundario,
                        child: Icon(
                          Icons.person,
                          color: colorPrincipal,
                        ),
                      )
                : CircleAvatar(
                    radius: 30.0,
                    backgroundColor: colorSecundario,
                    child: Icon(
                      Icons.person,
                      color: colorPrincipal,
                    ),
                  ),
            title: Row(
              children: [
                Expanded(
                    child: Obx(
                  () => Text(
                    controller.cliente.value.razonSocial != null
                        ? controller.cliente.value.razonSocial!
                        : 'Sin cliente',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ))
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Identificación: ",
                    style: TextStyle(color: Colors.white)),
                Obx(() => controller.cliente.value.identificacion != null
                    ? Text(controller.cliente.value.identificacion!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(color: Colors.white))
                    : const Text('9999999999',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white)))
              ],
            ),
          ),
        ),
      ),
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
            child: GestureDetector(
              onTap: () {
                Get.back(result: controller.clientes[index]);
              },
              child: Card(
                shadowColor: colorTercero,
                surfaceTintColor: Colors.white,
                child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
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
            ),
          );
        },
        loadNotifications: () {
          controller.cargarClientes();
        },
      ),
    );
  }

  fechasIngreso() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width * 0.4,
            child: Column(
              children: [
                const Text(
                  "Fecha Entrega",
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  readOnly: true,
                  onTap: () {
                    if (controller.fechaInicioController.text.isNotEmpty &&
                        controller.fechaFinController.text.isNotEmpty) {
                      DateTime fechaInicio = DateFormat('dd/MM/yyyy')
                          .parse(controller.fechaInicioController.text);
                      DateTime fechaFin = DateFormat('dd/MM/yyyy')
                          .parse(controller.fechaFinController.text);
                      controller.datePickerController.selectedRange =
                          PickerDateRange(fechaInicio, fechaFin);
                    }
                    Get.bottomSheet(fechaRango());
                  },
                  controller: controller.fechaInicioController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: colorPrincipal,
                    ),
                    hintText: 'dd/mm/yyyy',
                  ),
                ),
              ],
            ),
          ),
          Text(
            "-",
            style: TextStyle(color: colorPrincipal, fontSize: 14),
          ),
          SizedBox(
            width: Get.width * 0.4,
            child: Column(
              children: [
                const Text(
                  "Fecha Retiro",
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  readOnly: true,
                  onTap: () {
                    if (controller.fechaInicioController.text.isNotEmpty &&
                        controller.fechaFinController.text.isNotEmpty) {
                      DateTime fechaInicio = DateFormat('dd/MM/yyyy')
                          .parse(controller.fechaInicioController.text);
                      DateTime fechaFin = DateFormat('dd/MM/yyyy')
                          .parse(controller.fechaFinController.text);
                      controller.datePickerController.selectedRange =
                          PickerDateRange(fechaInicio, fechaFin);
                    }
                    Get.bottomSheet(fechaRango());
                  },
                  controller: controller.fechaFinController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: colorPrincipal,
                    ),
                    hintText: 'dd/mm/yyyy',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buscarCliente() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      height: Get.height * 0.8,
      child: ListView(
        shrinkWrap: true,
        children: [
          cuadroBusqueda(
            controller.busquedaCliente,
            "Busque al cliente",
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
              if (controller.busquedaCliente.text.length >= 3) {
                controller.page = 1;
                controller.clientes.clear();
                controller.cargarClientes();
              } else if (controller.busquedaCliente.text.isEmpty) {
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
    );
  }

  listaDesplegable(texto, Widget components) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ExpansionTile(
                      shape: Border.all(color: Colors.transparent),
                      initiallyExpanded: controller.expander.value,
                      iconColor: colorPrincipal,
                      collapsedIconColor: colorTercero,
                      collapsedTextColor: Colors.black,
                      textColor: Colors.black,
                      title: Text(texto,
                          style: TextStyle(
                              fontSize: Get.width * 0.04,
                              fontWeight: FontWeight.bold)),
                      children: [
                        components,
                      ],
                    ))
              ])),
        ));
  }

  inputObservacion() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 20, right: 10),
      child: TextField(
        controller: controller.observacionController,
        maxLines: 3,
        decoration:
            const InputDecoration.collapsed(hintText: "Ingresa algun motivo"),
      ),
    );
  }

  selecionarDireccion() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: Get.width * 1,
              child: inputsApp(
                  controller.direccion, "Ingrese la direccion de entrega"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.4,
                  child: inputsApp(controller.latitud, "Latitud"),
                ),
                SizedBox(
                  width: Get.width * 0.4,
                  child: inputsApp(controller.longitud, "Longitud"),
                )
              ],
            )
          ],
        ));
  }

  //Dirección del destino
  direccionDestino() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller.direccion,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorPrincipal, width: 2),
              ),
              hintText: "Ingrese la dirección del destino",
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.latitud,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorPrincipal, width: 2),
                    ),
                    hintText: "Latitud",
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: controller.longitud,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorPrincipal, width: 2),
                    ),
                    hintText: "Longitud",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget googleMapsComponent(double latitude, double longitude) {
    return SizedBox(
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('marker'),
            position: LatLng(latitude, longitude),
          ),
        },
      ),
    );
  }

  infoProducto() {
    var titulo = const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold);
    var texto = const TextStyle(color: Color.fromARGB(255, 255, 255, 255));
    return Obx(() => controller.listaProductos.isNotEmpty
        ? Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('Producto')),
                  DataColumn(label: Text('Cant.')),
                  DataColumn(label: Text('Stock')),
                  DataColumn(label: Text('')),
                ],
                rows: List.generate(controller.listaProductos.length, (index) {
                  final producto = controller.listaProductos[index];
                  return DataRow(cells: [
                    DataCell(SizedBox(
                        width: 50,
                        height: 100,
                        child: CachedNetworkImage(
                            imageUrl: producto["pathArchivo"]))),
                    DataCell(
                      SizedBox(
                        width: Get.width * 0.2,
                        child: Text(
                          producto["producto"],
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    DataCell(
                      TextFormField(
                        initialValue: producto["cantidad"].toString(),
                        onChanged: (newValue) {
                          controller.listaProductos[index]["cantidad"] =
                              int.parse(newValue);
                          if (int.parse(newValue) > producto["stock"]) {
                            alertaWarning(
                                "La cantidad a enviar no puede ser mayor al stock");
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    DataCell(Text(producto["stock"].toString())),
                    DataCell(IconButton(
                        onPressed: () {
                          controller.eliminarProducto(index, producto["id"]);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))),
                  ]);
                }),
              ),
            ),
          )
        : Container());
  }

  botonAgregarProducto() {
    return Container(
      height: Get.height * 0.12,
      width: Get.width * 0.12,
      decoration: BoxDecoration(
        color: colorPrincipal,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              controller.page = 1;
              controller.busquedaProducto.text = "";
              controller.productos.clear();
              controller.cargarProductos();
              Get.bottomSheet(buscarProducto(), isScrollControlled: true)
                  .then((value) {
                if (value != null) {
                  controller.agregarProducto(value);
                }
              });
            }),
      ),
    );
  }

  buscarProducto() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      height: Get.height * 0.8,
      child: ListView(
        shrinkWrap: true,
        children: [
          cuadroBusqueda(
            controller.busquedaProducto,
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
              if (controller.busquedaProducto.text.length >= 3) {
                controller.page = 1;
                controller.productos.clear();
                controller.cargarProductos();
              } else if (controller.busquedaProducto.text.isEmpty) {
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
    );
  }

  botonAgregarProductoQR() {
    return Container(
      height: Get.height * 0.12,
      width: Get.width * 0.12,
      decoration: BoxDecoration(
        color: colorSecundario,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
            icon: const Icon(Icons.qr_code, color: Colors.white),
            onPressed: () async {
              // controller.escanear();
            }),
      ),
    );
  }

  cargarDatosFlotantes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [botonEnviar()],
    );
  }

  Widget botonEnviar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorPrincipal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      onPressed: () {
        controller.crearTransferencia();
      },
      child: SizedBox(
          width: Get.width * 0.3,
          child: Text(
            "Emitir ".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }

  totalFacturaYcotizacion() {
    return Container();
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(20),
    //   child: Card(
    //       child: SizedBox(
    //     width: Get.width * 0.1,
    //     // height: Get.height * 0.25,
    //     child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Column(
    //         children: [
    //           const SizedBox(height: 20),
    //           Obx(
    //             () => controller.subtotal01.value != 0
    //                 ? resumenTexto('Subtotal Base 0%',
    //                     controller.subtotal01.value, Get.width * 0.04)
    //                 : resumenTexto('Subtotal Base 0%', 0, Get.width * 0.04),
    //           ),
    //           Divider(height: 20, color: colorPrincipal),
    //           Obx(() => controller.subtotal121.value != 0
    //               ? resumenTexto('Subtotal Base IVA', controller.subtotal12,
    //                   Get.width * 0.04)
    //               : resumenTexto('Subtotal Base IVA', 0, Get.width * 0.04)),
    //           Divider(height: 20, color: colorPrincipal),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text('IVA',
    //                   style: TextStyle(
    //                       fontSize: Get.width * 0.04,
    //                       fontWeight: FontWeight.bold)),
    //               Obx(() => controller.iva121.value != 0
    //                   ? Text(controller.iva12.toStringAsFixed(2),
    //                       style: TextStyle(
    //                           color: const Color.fromARGB(255, 0, 0, 0),
    //                           fontSize: Get.width * 0.04,
    //                           fontWeight: FontWeight.bold))
    //                   : Text('%0.00',
    //                       style: TextStyle(
    //                           color: const Color.fromARGB(255, 0, 0, 0),
    //                           fontSize: Get.width * 0.04,
    //                           fontWeight: FontWeight.bold))),
    //             ],
    //           ),
    //           Divider(height: 20, color: colorPrincipal),
    //           Obx(() => controller.sumaCantidadTotalFinal.value != 0
    //               ? resumenTexto('Total', controller.valorTotalCarrito?.value,
    //                   Get.width * 0.06)
    //               : resumenTexto('Total', 0, Get.width * 0.05)),
    //         ],
    //       ),
    //     ),
    //   )),
    // );
  }

  resumenTexto(texto, valor, tamanio) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$texto',
            style: TextStyle(fontSize: tamanio, fontWeight: FontWeight.bold)),
        Text(formatCurrency.format(valor),
            style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: tamanio,
                fontWeight: FontWeight.bold)),
      ],
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
              onTap: () {
                Get.back(result: controller.productos[index]["id"]);
              },
              child: Card(
                shadowColor: colorTercero,
                surfaceTintColor: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: CachedNetworkImage(
                        imageUrl: controller.productos[index]["pathArchivo"]),
                  ),
                  title: Text(
                    controller.productos[index]["producto"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis),
                  ),
                  subtitle: Text(
                    controller.productos[index]["descripcion"].toString(),
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
                        controller.productos[index]["stockInventario"]
                            .toString(),
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

  Widget fechaRango() {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white,
        ),
        height: Get.height * 0.8,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Seleccione el rango de fecha',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colorPrincipal)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: SfDateRangePicker(
                  onSelectionChanged: controller.onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  controller: controller.datePickerController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                  onPressed: () {
                    if (controller.fechaFinController.text.isNotEmpty) {
                      Get.back();
                    } else {
                      alertaWarning(
                          "No ha seleccionado la fecha final de entrega");
                    }
                  },
                  icon: Icon(Icons.calendar_month, color: colorPrincipal),
                  label: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Seleccionar fecha"),
                  )),
            )
          ],
        ));
  }
}

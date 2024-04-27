// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventary_go/modules/clientes/lista_cliente/lista_cliente_controller.dart';
import 'package:inventary_go/modules/clientes/lista_cliente/lista_cliente_page.dart';
import 'package:inventary_go/modules/inicio/inicio_controller.dart';
import 'package:inventary_go/modules/inicio/inicio_pages.dart';
import 'package:inventary_go/modules/productos/lista_producto/producto_controller.dart';
import 'package:inventary_go/modules/productos/lista_producto/producto_page.dart';
import 'package:inventary_go/modules/vehiculo/lista_vehiculo/lista_vehiculo_controller.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../utils/utils.dart';

import '../vehiculo/lista_vehiculo/lista_vehiculo_page.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  late TabController _tabController;
  var currentIndex = 0;
  var selectedItem = 0.obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController, // Asignar el TabController al TabBarView
        children: [
          const InicioPage(),
          ClientePage(),
          const ListaVehiculoPage(),
          const ProductoPage(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        unselectedItemColor: colorSecundario,
        backgroundColor: colorPrincipal,
        selectedItemColor: colorTercero,
        selectedColorOpacity: 0.5,
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          currentIndex = i;
          _tabController.animateTo(i);
          if (currentIndex == 3) {
            var productoController = Get.find<ProductoController>();
            productoController.page = 1;
            productoController.productos.clear();
            productoController.cargarProductos();
          }
          if (currentIndex == 2) {
            var vehiculoController = Get.find<ListaVehiculoController>();
            vehiculoController.page = 1;
            vehiculoController.vehiculos.clear();
            vehiculoController.cargarVehiculos();
          }
          if (currentIndex == 1) {
            var clienteController = Get.find<ClienteController>();
            clienteController.page = 1;
            clienteController.clientes.clear();
            clienteController.cargarClientes();
          }
          if (currentIndex == 0) {
            var homeController = Get.find<InicioController>();
            homeController.page = 1;
            homeController.rutasCreadas.clear();
            homeController.getRutas();
          }
        }),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.local_shipping_outlined),
            title: const Text("Transferencias",
                style: TextStyle(color: Colors.white)),
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_2_outlined),
            title:
                const Text("Clientes", style: TextStyle(color: Colors.white)),
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.front_loader),
            title:
                const Text("Vehiculo", style: TextStyle(color: Colors.white)),
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.inventory_2_outlined),
            title:
                const Text("Productos", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

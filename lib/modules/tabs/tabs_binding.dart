import 'package:get/get.dart';
import 'package:inventary_go/modules/clientes/lista_cliente/lista_cliente_controller.dart';
import 'package:inventary_go/modules/productos/lista_producto/producto_controller.dart';
import 'package:inventary_go/modules/vehiculo/lista_vehiculo/lista_vehiculo_controller.dart';
import '../inicio/inicio_controller.dart';
import 'tabs_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabsController());
    Get.lazyPut(() => InicioController());
    Get.lazyPut(() => ClienteController());
    Get.lazyPut(() => ProductoController());
    Get.lazyPut(() => ListaVehiculoController());
  }
}

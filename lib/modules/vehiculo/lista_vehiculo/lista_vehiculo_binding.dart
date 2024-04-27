import 'package:get/get.dart';
import 'lista_vehiculo_controller.dart';

class ProductoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListaVehiculoController());
  }
}

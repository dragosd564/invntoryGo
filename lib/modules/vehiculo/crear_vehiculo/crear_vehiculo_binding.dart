import 'package:get/get.dart';

import 'crear_vehiculo_controller.dart';

class CrearVehiculoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrearVehiculoController>(() => CrearVehiculoController(),
        fenix: true);
  }
}

import 'package:get/get.dart';

import 'crear_egreso_controller.dart';

class CrearEgresoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrearEgresoController>(() => CrearEgresoController());
  }
}

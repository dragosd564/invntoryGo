import 'package:get/get.dart';

import 'crear_cliente_controller.dart';

class CrearClienteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrearClienteController>(() => CrearClienteController(),
        fenix: true);
  }
}

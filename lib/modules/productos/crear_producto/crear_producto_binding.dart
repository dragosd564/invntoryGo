import 'package:get/get.dart';
import 'crear_producto_controller.dart';

class CrearProductoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CrearProductoController());
  }
}

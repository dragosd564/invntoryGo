import 'package:get/get.dart';
import 'producto_controller.dart';

class ProductoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductoController());
  }
}

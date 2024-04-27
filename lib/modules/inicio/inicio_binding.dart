import 'package:get/get.dart';

import 'inicio_controller.dart';

class InicioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InicioController());
  }
}

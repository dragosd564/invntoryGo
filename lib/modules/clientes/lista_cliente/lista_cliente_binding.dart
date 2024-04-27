import 'package:get/get.dart';

import 'lista_cliente_controller.dart';

class ClienteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClienteController>(() => ClienteController(), fenix: true);
  }
}

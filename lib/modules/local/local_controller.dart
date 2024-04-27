import 'package:get/get.dart';
import 'package:inventary_go/core/models/catalogo.dart';
import 'package:inventary_go/routes/app_routes.dart';

import '../../core/services/api.dart';
import '../../utils/utils.dart';

class LocalController extends GetxController {
  RxList<Bodega> locales = <Bodega>[].obs;

  @override
  void onInit() {
    super.onInit();
    cargarLocales();
  }

  cargarLocales() async {
    locales.value = await API.instance.getLocales();
  }

  guardarLocal(idLocal) async {
    storage.write("local", idLocal.toString());

    Get.offAllNamed(AppRoutes.TABS);
  }
}

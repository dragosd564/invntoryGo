import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventary_go/core/global/mapa_pick.dart';
import 'package:inventary_go/modules/clientes/crear_cliente/crear_cliente_binding.dart';
import 'package:inventary_go/modules/clientes/crear_cliente/crear_cliente_page.dart';
import 'package:inventary_go/modules/inicio/crear_egreso/crear_egreso_binding.dart';
import 'package:inventary_go/modules/inicio/crear_egreso/crear_egreso_pages.dart';
import 'package:inventary_go/modules/inicio/inicio_binding.dart';
import 'package:inventary_go/modules/inicio/inicio_pages.dart';
import 'package:inventary_go/modules/local/local_binding.dart';
import 'package:inventary_go/modules/local/local_page.dart';
import 'package:inventary_go/modules/login/login_binding.dart';
import 'package:inventary_go/modules/login/login_page.dart';
import 'package:inventary_go/modules/productos/crear_producto/crear_producto_binding.dart';
import 'package:inventary_go/modules/productos/crear_producto/crear_producto_page.dart';
import 'package:inventary_go/modules/tabs/tabs_binding.dart';
import 'package:inventary_go/modules/vehiculo/crear_vehiculo/crear_vehiculo_binding.dart';
import 'package:inventary_go/modules/vehiculo/crear_vehiculo/crear_vehiculo_page.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_page.dart';
import '../modules/tabs/tabs.dart';
import 'app_routes.dart';

final box = GetStorage();

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: AppRoutes.LOGIN,
        page: () => const LoginPage(),
        binding: LoginBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: AppRoutes.BODEGA,
        page: () => const LocalPage(),
        binding: LocalBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: AppRoutes.TABS,
        page: () => const Tabs(),
        binding: TabsBinding(),
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: AppRoutes.HOME,
        page: () => const InicioPage(),
        binding: InicioBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: AppRoutes.CREAR_EGRESO,
        page: () => const CrearEgresoPage(),
        binding: CrearEgresoBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: AppRoutes.CREAR_CLIENTE,
        page: () => CrearClientePage(),
        binding: CrearClienteBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: AppRoutes.CREAR_PRODUCTO,
        page: () => const CrearProductoPage(),
        binding: CrearProductoBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: AppRoutes.CREAR_VEHICULO,
        page: () => CrearVehiculoPage(),
        binding: CrearVehiculoBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: AppRoutes.MAPA,
        page: () => MapaPick(),
        // binding: MapaBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
  ];
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import 'fondo_login.dart';
import 'login_controller.dart';

class LoginPage extends GetWidget<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[FondoLogin(), _loginForm()],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    // final bloc = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 198.0),
      child: SingleChildScrollView(
        child: Container(
          width: Get.width * 1,
          height: Get.height * 1,
          padding: EdgeInsets.symmetric(vertical: 50.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(55.0),
                  topRight: Radius.circular(55.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1.0,
                    offset: Offset(0.0, 1.0),
                    spreadRadius: 1.0)
              ]),
          child: Column(
            children: [
              Text(
                "INICIAR SESIÓN".tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Get.height * 0.02),
              ),
              SizedBox(
                height: 30.0,
              ),
              _usuario(),
              _password(),
              _crearBoton(),
              SizedBox(
                height: Get.height * 0.2,
              ),
              derechos()
            ],
          ),
        ),
      ),
    );
  }
}

Widget _usuario() {
  final controller = Get.put(LoginController());

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          icon: Icon(Icons.person, color: colorPrincipal),
          labelText: 'Usuario'.tr),
      controller: controller.usuarioController,
    ),
  );
}

Widget _password() {
  final controller = Get.put(LoginController());

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Obx(() => TextField(
          obscureText: controller.verClave.value,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  if (controller.verClave.value) {
                    controller.verClave.value = false;
                  } else {
                    controller.verClave.value = true;
                  }
                },
                child: Icon(controller.verClave.value
                    ? Icons.visibility_off
                    : Icons.visibility),
              ),
              icon: Icon(Icons.lock_outline, color: colorPrincipal),
              labelText: 'Clave'.tr),
          controller: controller.claveController,
        )),
  );
}

Widget _crearBoton() {
  final controller = Get.put(LoginController());
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 38.0),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: colorPrincipal),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 120.0, vertical: 15.0),
            child: Obx(() => controller.loading.value
                ? CircularProgressIndicator(
                    color: colorSecundario,
                  )
                : Text(
                    'Ingresar'.tr,
                    style: TextStyle(color: Colors.white),
                  ))),
        onPressed: () {
          controller.loginEnviar();
        }),
  );
}

Widget derechos() {
  return Center(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Text(
      //   "Desarrollado por".tr,
      //   style: TextStyle(color: Colors.grey),
      // ),
      // SizedBox(width: Get.width * 0.02),
      Image.asset(
        'lib/assets/powerBy.png',
        width: Get.width * 0.3,
        height: Get.height * 0.13,
      )
    ],
  ));
}

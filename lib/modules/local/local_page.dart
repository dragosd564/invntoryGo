// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../login/fondo_login.dart';
import 'local_controller.dart';

class LocalPage extends GetWidget<LocalController> {
  const LocalPage({super.key});

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
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 100.0,
          )),
          Container(
            width: Get.width * 1,
            height: Get.height * 1,
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            decoration: const BoxDecoration(
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
                  "SELECCIONA UNA BODEGA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: Get.width * 0.04),
                ),
                const SizedBox(height: 10),
                Divider(color: colorPrincipal, thickness: 2),
                locales()
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget locales() {
  final controller = Get.put(LocalController());
  return Obx(() => ListView.separated(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              controller.guardarLocal(controller.locales[index].id);
            },
            leading: Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            title: Text(
              controller.locales[index].local!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: Get.height * 0.02),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
            ),
          );
        },
        itemCount: controller.locales.length,
      ));
}

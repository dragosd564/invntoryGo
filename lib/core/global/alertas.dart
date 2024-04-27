import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventary_go/utils/utils.dart';

alertaExito(mensaje, {VoidCallback? onConfirm}) {
  CoolAlert.show(
      title: "Éxito",
      context: Get.context!,
      type: CoolAlertType.success,
      text: mensaje,
      backgroundColor: colorPrincipal,
      confirmBtnColor: colorTercero,
      onConfirmBtnTap: onConfirm);
}

alertaWarning(mensaje, {usarBack = true}) {
  CoolAlert.show(
      title: "Alerta",
      context: Get.context!,
      type: CoolAlertType.info,
      text: mensaje,
      backgroundColor: colorPrincipal,
      confirmBtnColor: colorTercero);
}

alertaError(mensaje) {
  CoolAlert.show(
      title: "Error",
      context: Get.context!,
      type: CoolAlertType.error,
      text: mensaje,
      backgroundColor: colorPrincipal,
      confirmBtnColor: colorTercero);
}

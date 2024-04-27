// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import 'crear_producto_controller.dart';
import 'steps/datos_adicionales.dart';
import 'steps/datos_producto.dart';
import 'steps/imagen.dart';

class CrearProductoPage extends GetWidget<CrearProductoController> {
  const CrearProductoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrincipal,
          iconTheme: IconThemeData(color: colorTextoApp),
          title: Text(
            "Crear ${controller.nombrepage}".tr,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: Get.width * 0.06, color: colorTextoApp),
          ),
        ),
        body: Stack(
          children: [
            Obx(() => Stepper(
                  type: controller.stepperType,
                  physics: const AlwaysScrollableScrollPhysics(),
                  currentStep: controller.currentStep.value,
                  onStepTapped: (step) {
                    tapped(step);
                    cambioStep(step);
                  },
                  onStepCancel: () {
                    cancel();
                    cambioStep(controller.currentStep.value);
                  },
                  onStepContinue: () {
                    continued();
                    cambioStep(controller.currentStep.value);
                  },
                  controlsBuilder:
                      (BuildContext context, ControlsDetails? controls) {
                    if (controller.currentStep.value == 2) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorPrincipal,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: colorPrincipal),
                                child: Text("Atrás".tr,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                onPressed: controls!.onStepCancel,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorPrincipal,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: colorPrincipal),
                                child: Text(
                                  "Enviar".tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  controller.guardar();
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (controller.currentStep.value == 1) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorPrincipal,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: colorPrincipal),
                                  child: Text(
                                    "Atrás".tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onPressed: controls!.onStepCancel),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorPrincipal,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: colorPrincipal),
                                child: Text(
                                  "Siguiente".tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  controls.onStepContinue!();
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorPrincipal,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: colorPrincipal),
                            child: Text(
                              "Siguiente".tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (!controller.formKey1.currentState!
                                  .validate()) {
                                print("dfkjkjf");
                              } else {
                                controls?.onStepContinue!();
                              }
                            },
                          ),
                        ),
                      );
                    }
                  },
                  steps: <Step>[
                    Step(
                      title: Text('Datos Producto'.tr),
                      content: const DatosProducto(),
                      isActive: controller.currentStep.value >= 0,
                      state: controller.currentStep.value >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text('Datos adicionales'.tr),
                      content: const DatosAdicionales(),
                      isActive: controller.currentStep.value >= 0,
                      state: controller.currentStep.value >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text('Seleccionar imagen'.tr),
                      content: const Imagen(),
                      isActive: controller.currentStep.value >= 0,
                      state: controller.currentStep.value >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                )),
            Obx(() => controller.isloading.value
                ? Container(
                    width: Get.width * 1,
                    height: Get.height * 1,
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                      child: CircularProgressIndicator(color: colorSecundario),
                    ),
                  )
                : Container())
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    controller.currentStep.value = step;
  }

  continued() {
    controller.currentStep.value < 2 ? controller.currentStep.value += 1 : null;
  }

  cancel() {
    controller.currentStep.value > 0 ? controller.currentStep.value -= 1 : null;
  }

  cambioStep(step) {
    switch (step) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
    }
  }
}

// ignore_for_file: invalid_use_of_protected_member

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventary_go/core/global/alertas.dart';
import '../../../core/global/custom_inputs.dart';
import '../../../core/models/catalogo.dart';
import '../../../utils/utils.dart';
import 'crear_cliente_controller.dart';

class CrearClientePage extends GetWidget<CrearClienteController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  CrearClientePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              "Entidad",
              // textAlign: TextAlign.start,
              style:
                  TextStyle(fontSize: Get.width * 0.06, color: colorTextoApp),
            ),
            backgroundColor: colorPrincipal,
          ),
          body: FutureBuilder(
            initialData: controller.cargarPaises(),
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: colorSecundario),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: ListView(
                      children: [
                        CupertinoFormSection(
                          children: [
                            selectTipoIdentificacion(),
                            textIdentificacion(),
                            textRazonSocial(),
                            selectPais(),
                            selectProvincia(),
                            selectCiudad(),
                            textDireccion(),
                            textTelefono(),
                            textCelular(),
                            textCorreo(),
                            textObservaciones(),
                            eschofer(),
                            Obx(() => controller.esChofer.value
                                ? selectInputVehiculo("Seleccione el chofer")
                                : Container()),
                            _botones()
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            future: null,
          ),
          bottomNavigationBar: SizedBox(
            width: Get.width * 0.1,
            height: Get.height * 0.06,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrincipal,
                    shape: const RoundedRectangleBorder()),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    alertaWarning(
                        "Complete los campos restantes para continuar");
                  } else {
                    controller.crearCliente();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.save, color: colorTextoApp),
                    ),
                    const Text(
                      "Crear Cliente",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
          ),
        ),
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
    );
  }

  Widget textRazonSocial() {
    return CupertinoTextFormFieldRow(
      prefix: Text(
        'Razón social *: '.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Razón social es requerido";
        }
        return null;
      },
      placeholder: "CONSUMIDOR FINAL",
      controller: controller.razonsocialController,
    );
  }

  Widget textIdentificacion() {
    return CupertinoTextFormFieldRow(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      prefix: Text(
        'Identificación *: '.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Identificación es requerido";
        }
        return null;
      },
      maxLength: controller.maximo.value,
      onChanged: (value) async {
        if (value.length == 10) {
          try {
            // await API.instance.getUsuarioByIdentificacion(value).then((value) {
            //   controller.razonsocialController.text = value["RazonSocial"];
            //   controller.direccionController.text = value["Direccion"];
            //   controller.telefonoController.text = value["Telefono"];
            //   controller.celularController.text = value["Celular"];
            //   controller.correoController.text = value["Correo"];
            //   String fecha =
            //       formatter.format(DateTime.parse(value["FechaNacimiento"]));
            //   controller.fechaNacimientoController.text = fecha;
            // });
          } catch (e) {}
        }
        if (value.length == 13) {
          try {
            // await API.instance.getUsuarioByIdentificacion(value).then((value) {
            //   controller.razonsocialController.text = value["RazonSocial"];
            //   controller.direccionController.text = value["Direccion"];
            //   controller.telefonoController.text = value["Telefono"];
            //   controller.celularController.text = value["Celular"];
            //   controller.correoController.text = value["Correo"];
            //   String fecha =
            //       formatter.format(DateTime.parse(value["FechaNacimiento"]));
            //   controller.fechaNacimientoController.text = fecha;
            // });
          } catch (e) {}
        }
      },
      placeholder: "9999999999",
      controller: controller.identificacionController,
    );
  }

  Widget textDireccion() {
    return CupertinoTextFormFieldRow(
      prefix: Text(
        'Dirección *: '.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Dirección es requerido";
        }
        return null;
      },
      placeholder: "Dirección",
      controller: controller.direccionController,
    );
  }

  Widget textObservaciones() {
    return CupertinoTextFormFieldRow(
      prefix: Text(
        'Observaciones: '.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      placeholder: "Ingrese observación",
      controller: controller.observacionController,
    );
  }

  Widget textTelefono() {
    return CupertinoTextFormFieldRow(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      prefix: Text(
        'Teléfono: '.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      placeholder: "Teléfono",
      controller: controller.telefonoController,
    );
  }

  Widget textCelular() {
    return Row(
      children: [
        Flexible(
          child: CountryCodePicker(
            onChanged: (codigoPais) {
              controller.codigoPais = codigoPais.toString();
            }, // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: 'EC',
            // optional. Shows only country name and flag
            showCountryOnly: false,
            // optional. Shows only country name and flag when popup is closed.
            showOnlyCountryWhenClosed: false,
            // optional. aligns the flag and the Text left
            alignLeft: false,
          ),
        ),
        Flexible(
          child: CupertinoTextFormFieldRow(
            validator: (value) {
              if (value!.isEmpty) {
                return "Celular es requerido";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            maxLength: 10,
            placeholder: "Celular",
            controller: controller.celularController,
          ),
        )
      ],
    );
  }

  Widget textCorreo() {
    return CupertinoTextFormFieldRow(
      keyboardType: TextInputType.emailAddress,
      prefix: Text(
        'Correo *: '.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      validator: (value) {
        final bool isValid = EmailValidator.validate(value!);
        if (value.isEmpty) {
          return "Correo es requerido";
        } else {
          if (!isValid) {
            return "Debes ingresar un correo válido";
          }
        }
        return null;
      },
      placeholder: "ejemplo@gmail.com",
      controller: controller.correoController,
    );
  }

  Widget textSector() {
    return CupertinoTextField(
      placeholder: "Sector".tr,
      controller: controller.correoController,
    );
  }

  Widget botonCrearCliente() {
    return ElevatedButton(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Crear cliente'.tr),
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        // elevation: 0.0,
        // color: colorSecundario,
        // textColor: Colors.white,
        onPressed: () => {});
  }

  pais() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "País".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        selectPais()
      ],
    );
  }

  selectPais() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selecciona un pais".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () => DropdownSearch<Pais>(
                  selectedItem: controller.opcionPais.value,
                  validator: (value) {
                    if (value.isBlank!) {
                      return "Pais es requerido";
                    }
                    return null;
                  },
                  items: controller.paises,
                  itemAsString: (Pais u) => u.nacionalidad.toString(),
                  onChanged: (Pais? data) {
                    // controller.opcionPais.value.id = data!.id;
                    // controller.cargarProvincias(data.id);
                  },
                ),
              ))
        ],
      ),
    );
  }

  provincia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Provincias".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        selectProvincia()
      ],
    );
  }

  selectProvincia() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selecciona una provincia".tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownSearch<Provincia>(
                selectedItem: controller.opcionProvincia.value,
                validator: (value) {
                  if (value.isBlank!) {
                    return "Nacionalidad es requerido";
                  }
                  return null;
                },
                items: controller.provincias,
                itemAsString: (Provincia u) => u.nombre.toString(),
                onChanged: (Provincia? data) {
                  controller.opcionProvincia.value.id = data!.id;
                  controller.cargarCiudades(data.id);
                },
              ),
            )
          ],
        ));
  }

  ciudad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ciudades".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        selectCiudad()
      ],
    );
  }

  selectCiudad() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selecciona una ciudad".tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownSearch<Ciudad>(
              selectedItem: controller.opcionCiudad.value,
              validator: (value) {
                if (value.isBlank!) {
                  return "Nacionalidad es requerido";
                }
                return null;
              },
              items: controller.ciudades,
              itemAsString: (Ciudad u) => u.nombre.toString(),
              onChanged: (Ciudad? data) {
                controller.opcionCiudad.value.id = data!.id;
              },
            )
          ],
        ));
  }

  sector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sector".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        selectSector()
      ],
    );
  }

  selectSector() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selecciona un sector".tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownSearch<dynamic>(
              selectedItem: controller.opcionSector.value,
              validator: (value) {
                if (value.isBlank!) {
                  return "Nacionalidad es requerido";
                }
                return null;
              },
              // dropdownButtonSplashRadius: 20,
              // mode: Mode.BOTTOM_SHEET,
              // dropdownSearchDecoration: InputDecoration(
              //   contentPadding:
              //       EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
              //   border: InputBorder.none,
              //   fillColor: colorPrincipal,
              // ),
              // isFilteredOnline: true,
              // showSearchBox: true,
              items: controller.sectores,
              itemAsString: (dynamic u) => u!.sector.toString(),
              onChanged: (dynamic data) {
                controller.opcionSector.value.id = data!.id;
              },
            )
          ],
        ));
  }

  tipoIdentificacion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tipo de identificación".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        selectTipoIdentificacion()
      ],
    );
  }

  selectTipoIdentificacion() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Selecciona un tipo de identificación'.tr),
            value: controller.opcionTipoIdentificacion.value,
            items: controller.tiposIdentificacion.map((accountType) {
              return DropdownMenuItem(
                value: accountType["key"],
                child: Text(accountType["valor"]),
              );
            }).toList(),
            onChanged: (dynamic opt) {
              controller.opcionTipoIdentificacion.value = opt;
              switch (opt) {
                case 'R':
                  controller.maximo.value = 13;
                  controller.refresh();
                  break;

                default:
                  controller.maximo.value = 10;
                  controller.refresh();
              }
            },
          ),
        ));
  }

  fecha() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: CupertinoTextFormFieldRow(
        readOnly: true,
        prefix: Text(
          "Fecha de nacimiento: ".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        placeholder: "27/02/1998",
        controller: controller.fechaNacimientoController,
        onTap: () {
          FocusScope.of(Get.context!).requestFocus(FocusNode());
          seleccionarFecha();
        },
      ),
    );
  }

  seleccionarFecha() async {
    DateTime? picked = await showDatePicker(
        context: Get.context!,
        locale: const Locale('es', 'ES'),
        initialDate: DateTime(1900),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030));

    if (picked != null) {
      controller.diaSeleccionado = picked;
      final String formatted = controller.formatter.format(picked);
      controller.fechaNacimientoController.text = formatted;
    }
  }

  _botones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [botonTomarFoto(), botonMapa()],
    );
  }

  botonTomarFoto() {
    return OutlinedButton(
        child: SizedBox(
          width: Get.width * 0.35,
          child: Icon(
            FontAwesomeIcons.camera,
            color: colorPrincipal,
          ),
        ),
        onPressed: () {
          controller.tomarFoto();
        });
  }

  botonMapa() {
    return OutlinedButton(
        child: SizedBox(
          width: Get.width * 0.35,
          child: Icon(
            FontAwesomeIcons.searchLocation,
            color: colorPrincipal,
          ),
        ),
        onPressed: () {
          // controller.tomarUbicacion();
        });
  }

  Widget eschofer() {
    return Obx(() => CheckboxListTile(
          title: const Text(
            "Es logístico",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          value: controller.esChofer.value,
          activeColor: colorPrincipal,
          onChanged: (value) {
            controller.esChofer.value = value!;
          },
        ));
  }

  selectInputVehiculo(texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            texto,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Obx(() => controller.conductores.isNotEmpty
              ? CustomDropDown<Chofer>(
                  options: controller.conductores,
                  selectedOption: controller.selectedChofer,
                  onChanged: (newValue) {
                    controller.selectedChofer.value = newValue;

                    controller.inisionSesion = newValue!.inicioSesion!;
                  },
                  displayText: (client) => client.inicioSesion.toString(),
                )
              : SizedBox(
                  width: Get.width * 0.8,
                  height: 50,
                )),
        ],
      ),
    );
  }
}

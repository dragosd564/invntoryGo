import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

cuadroBusqueda(
  TextEditingController termino,
  String hintText, {
  Function(String)? onChage,
  Function(PointerDownEvent)? onTapOutside,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: TextFormField(
      controller: termino,
      onFieldSubmitted: onChage,
      onTapOutside: onTapOutside,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: colorPrincipal),
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.search, color: colorPrincipal),
          suffixIcon: IconButton(
              onPressed: () {
                termino.text = "";
              },
              icon: Icon(Icons.close, color: colorPrincipal)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: colorTercero,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 2,
              color: colorTercero,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: colorPrincipal,
            ),
          )),
    ),
  );
}

inputsApp(
  TextEditingController termino,
  String hintText,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: TextFormField(
      controller: termino,
      decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black),
          hintText: hintText,
          fillColor: Colors.transparent,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: colorPrincipal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 2,
              color: colorPrincipal,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: colorPrincipal,
            ),
          )),
    ),
  );
}

FloatingActionButton addInpunts({tooltip, VoidCallback? ruta}) {
  return FloatingActionButton(
      tooltip: tooltip,
      onPressed: ruta,
      backgroundColor: colorTercero,
      child: Icon(
        Icons.add,
        color: colorSecundario,
      ));
}

class CustomDropDown<T> extends StatelessWidget {
  final RxList<T> options;
  final Rx<T?>? selectedOption;
  final ValueChanged<T?> onChanged;
  final String Function(T) displayText;

  const CustomDropDown({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    required this.displayText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: Row(
        children: [
          Expanded(
              child: Obx(
            () => DropdownButton<T>(
              value: selectedOption!.value,
              onChanged: onChanged,
              isExpanded: true,
              iconEnabledColor: colorPrincipal,
              items: options.map<DropdownMenuItem<T>>((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(displayText(value)),
                );
              }).toList(),
            ),
          )),
        ],
      ),
    );
  }
}

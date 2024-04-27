import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../utils/uber_map_theme.dart';
import '../../../utils/utils.dart';
import 'mapa_controller.dart';

class MapaPage extends GetWidget<MapaController> {
  const MapaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrincipal,
        iconTheme: IconThemeData(color: colorTextoApp),
        title: Text(
          "Selecciona la ubicación",
          style: TextStyle(color: colorTextoApp),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.permisos(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child:
                  CircularProgressIndicator(backgroundColor: colorSecundario),
            );
          } else {
            return mapa();
          }
        },
      ),
    );
  }

  Widget mapa() {
    return GoogleMap(
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        controller.setMapStyle(jsonEncode(uberMapTheme));
      },
      markers: {
        Marker(
            markerId: const MarkerId('currentLocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(controller.locationData!.latitude!,
                controller.locationData!.longitude!)),
      },
      initialCameraPosition: CameraPosition(
          target: LatLng(controller.locationData!.latitude!,
              controller.locationData!.longitude!),
          zoom: 13),
      onTap: (LatLng latLng) {
        // Cuando se toca en el mapa, muestra la latitud y longitud
        print('Latitud: ${latLng.latitude}, Longitud: ${latLng.longitude}');
      },
    );
    // return Obx(() => GoogleMap(
    //       myLocationButtonEnabled: false,
    //       zoomControlsEnabled: false,
    //       mapType: MapType.normal,
    //       zoomGesturesEnabled: true,
    //       onMapCreated: (GoogleMapController controller) {
    //         controller.setMapStyle(jsonEncode(uberMapTheme));
    //       },
    //       markers: Set<Marker>.of(controller.markers!),
    //       initialCameraPosition: CameraPosition(
    //           target: LatLng(controller.locationData!.latitude!,
    //               controller.locationData!.longitude!),
    //           zoom: 17),
    //       // onCameraMove: _.mover_camara,
    //     ));
  }
}

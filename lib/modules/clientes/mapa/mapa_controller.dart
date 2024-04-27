import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapaController extends GetxController {
  // ignore: deprecated_member_use
  RxList<Marker>? markers;
  var storage = GetStorage();
  MarkerId markerId = const MarkerId("1");
  Location location = Location();
  LocationData? locationData;
  PermissionStatus? _permissionGranted;
  @override
  void onInit() {
    super.onInit();
    permisos();
  }

  permisos() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return actualizarPosicion();
      }
    }
    locationData = await location.getLocation();
    storage.write("latitud", locationData!.latitude);
    storage.write("longitud", locationData!.longitude);
    storage.write("latitudEditar", locationData!.latitude);
    storage.write("longitudEditar", locationData!.longitude);
    actualizarPosicion();
  }

  actualizarPosicion() {
    markers!.add(Marker(
        draggable: true,
        // onDragEnd: (LatLng position) {
        //   storage.write("latitud", position.latitude);
        //   storage.write("longitud", position.longitude);
        //   storage.write("latitudEditar", position.latitude);
        //   storage.write("longitudEditar", position.longitude);
        // },
        markerId: markerId,
        position: LatLng(locationData!.latitude!, locationData!.longitude!)));
  }
}

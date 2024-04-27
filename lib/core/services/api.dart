import 'dart:convert';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../routes/app_routes.dart';
import '../../utils/utils.dart';
import '../models/catalogo.dart';
import '../models/cliente.dart';
import '../models/producto.dart';

class API {
  final urlAtlas = "https://api.binasystem.com/atlas";
  final urlAuthi5 = "https://api.binasystem.com/authi5";
  final urlbinaAuth = "https://api.binasystem.com/auth/v1";
  final urlEmpresa = "https://tendago-empresa-aps.azurewebsites.net";
  final urlOutputs = "https://tendago-outputapi.binasystem.com";
  final urlCatastro = "https://api.binasystem.com/catastro";
  API.internal();
  static API instance = API.internal();

  cerrarSesion() async {
    storage.remove("token");
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  Future<dynamic> postLogin(token) async {
    try {
      var body = json.encode({
        "appId": "601194F8-132C-4A4A-806A-EE986A1324B6",
        "deviceId": "1.1.1.1",
        "latitud": "0",
        "longitud": "0"
      });

      var response = await http.post(Uri.parse('$urlbinaAuth/login'),
          body: body,
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json'
          });
      var datosApi = json.decode(response.body);
      if (response.statusCode == 200) {
        return datosApi;
      } else {
        return datosApi;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> postAltasTokenn() async {
    try {
      var body = json.encode({
        "loginProvider": "atlas",
        "providerKey": "1f629a9e-01d1-4e95-b71c-f6b6432fb40b"
      });

      var response = await http.post(
          Uri.parse('$urlAuthi5/api/TokenAuth/ApplicationLogIn'),
          body: body,
          headers: {'Content-Type': 'application/json'});
      var datosApi = json.decode(response.body);
      if (response.statusCode == 200) {
        storage.write("tokenAtlas", datosApi["result"]["accessToken"]);
        return datosApi;
      } else {
        return datosApi;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TipoIdentificacion>> getIdentificacion() async {
    var token = storage.read("tokenAtlas");
    try {
      var response = await http.get(
          Uri.parse("$urlAtlas/tipoidentificacion/getall"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => TipoIdentificacion.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Pais>> getPaises() async {
    var token = storage.read("tokenAtlas");
    try {
      var response = await http
          .get(Uri.parse("$urlAtlas/pais/getall"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => Pais.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  //------------------- CIUDAD
  Future<List<Ciudad>> getCiudadByIdProvincia(idProvincia) async {
    var token = storage.read("tokenAtlas");
    try {
      var response = await http.get(
          Uri.parse("$urlAtlas/provincia/$idProvincia/ciudad/getall"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => Ciudad.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  //------------------- PROVINCIA
  Future<List<Provincia>> getProvinciasByIdPais(idPais) async {
    var token = storage.read("tokenAtlas");
    try {
      var response = await http.get(
          Uri.parse("$urlAtlas/pais/$idPais/provincia/getall"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => Provincia.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  //------------------- SECTORES
  Future<List<Sector>> getSectores() async {
    var token = storage.read("token");
    try {
      var response = await http.get(Uri.parse("$urlAtlas/catalogs/sectors"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ' $token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse as List).map((e) => Sector.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  //LISTA DE LOCALES
  Future<List<Bodega>> getLocales() async {
    var usuario = storage.read("user");
    var token = storage.read("token");
    try {
      var response =
          await http.get(Uri.parse("$urlEmpresa/locales/$usuario"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token',
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse as List).map((e) => Bodega.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // CREAR PRODUCTO
  Future<dynamic> postProducto(body) async {
    var token = storage.read("token");
    try {
      var response = await http.post(
          Uri.parse(
            "$urlOutputs/products/save",
          ),
          body: body,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ' $token',
          });

      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Marca>> getMarcas() async {
    var token = storage.read("token");
    try {
      var response = await http.get(Uri.parse("$urlOutputs/products/marcas"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ' $token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => Marca.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Division>> getDivisiones() async {
    var token = storage.read("token");
    try {
      var response = await http.get(
          Uri.parse("$urlOutputs/products/divisiones"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ' $token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => Division.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Linea>> getLineaByIdDivision(idDivision) async {
    var token = storage.read("token");
    try {
      var response = await http.get(
          Uri.parse("$urlOutputs/products/$idDivision/lineas"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ' $token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => Linea.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postCliente(body) async {
    var token = storage.read("token");
    try {
      var response = await http.post(
          Uri.parse(
            "$urlOutputs/clients/save",
          ),
          body: body,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ' $token',
          });

      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProductos({termino, page = 1, pageSize = 10}) async {
    var token = storage.read("token");
    var idLocal = storage.read("local");
    try {
      var response = await http.get(
          Uri.parse(
              "$urlOutputs/products/$idLocal/search?term=$termino&page=$page&pageSize=$pageSize"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': '$token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse["result"];
      } else {
        return jsonResponse;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProductoStock(id) async {
    var token = storage.read("token");
    try {
      var response = await http.get(
          Uri.parse("$urlOutputs/products/$id/stock;local"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ' $token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        return jsonResponse;
      }
    } catch (e) {}
  }

  Future<List<Vehiculo>> getVehiculos(
      {termino, page = 1, pageSize = 10}) async {
    var token = storage.read("token");
    try {
      var response = await http.get(
          Uri.parse(
              "$urlOutputs/catalogo/vehiculo/search?term=$termino&page=$page&pageSize=$pageSize"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': '$token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => Vehiculo.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Clientes>> getConductor(
      {termino, page = 1, pageSize = 10}) async {
    var token = storage.read("token");
    try {
      var response = await http.get(
          Uri.parse(
              "$urlOutputs/clients/search/driver/term?term=$termino&page=$page&pageSize=$pageSize"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': '$token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => Clientes.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Clientes>> getClientes({termino, page = 1, pageSize = 10}) async {
    var token = storage.read("token");

    try {
      var response = await http.get(
          Uri.parse(
              "$urlOutputs/clients/search/term?term=$termino&page=$page&pageSize=$pageSize"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': '$token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => Clientes.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getPlaca(placa) async {
    var token = storage.read("token");
    try {
      var response = await http.get(
          Uri.parse("$urlCatastro/consultar/placa/$placa"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ' $token',
          });
      var jsonResponse = convert.jsonDecode(response.body);

      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postVehiculo(body) async {
    var token = storage.read("token");
    try {
      var response = await http.post(
          Uri.parse(
            "$urlOutputs/catalogo/vehiculo/save",
          ),
          body: body,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ' $token',
          });

      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Chofer>> getUsurio({termino, page = 1, pageSize = 10}) async {
    var token = storage.read("token");

    try {
      var response = await http.get(
          Uri.parse(
              "$urlEmpresa/usuario/search?term=$termino&page=$page&pageSize=$pageSize"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': '$token',
          });
      var jsonResponse = convert.jsonDecode(response.body);
      return (jsonResponse["result"] as List)
          .map((e) => Chofer.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postTransfer(body) async {
    var token = storage.read("token");
    try {
      var response = await http.post(
          Uri.parse(
            "$urlOutputs/warehouse/save",
          ),
          body: body,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ' $token',
          });

      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postRuta(body) async {
    var token = storage.read("token");
    try {
      var response = await http.post(
          Uri.parse(
            "$urlOutputs/warehouse/ruta/save",
          ),
          body: body,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': '$token',
          });

      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getRutas({termino, page = 1, pageSize = 10}) async {
    var token = storage.read("token");
    try {
      var response = await http.get(
          Uri.parse(
              "$urlOutputs/warehouse/ruta/consultar?term=$termino&page=$page&pageSize=$pageSize"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': '$token',
          });
      var jsonResponse = convert.jsonDecode(response.body);

      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> makeApiRequest(String endpoint,
      {String method = 'GET', dynamic body}) async {
    var token = storage.read("token");
    try {
      var url = Uri.parse('$endpoint');
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token',
      };
      var response;
      if (method == 'GET') {
        response = await http.get(url, headers: headers);
      } else if (method == 'POST') {
        response = await http.post(url, headers: headers, body: body);
      }
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }
}

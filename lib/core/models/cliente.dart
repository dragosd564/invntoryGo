// To parse this JSON data, do
//
//     final clientes = clientesFromJson(jsonString);

import 'dart:convert';

Clientes clientesFromJson(String str) => Clientes.fromJson(json.decode(str));

String clientesToJson(Clientes data) => json.encode(data.toJson());

class Clientes {
  int? id;
  int? idEmpresa;
  String? tipoEntidad;
  String? tipoIdentificacion;
  String? razonSocial;
  String? identificacion;
  int? idPais;
  int? idProvincia;
  int? idCiudad;
  int? idLocalBodega;
  String? direccion;
  int? idSector;
  String? telefono;
  String? celular;
  String? correo;
  String? observaciones;
  String? foto;
  String? latitud;
  String? longitud;
  DateTime? fechaNacimiento;
  String? genero;
  String? estadoCivil;
  String? nacionalidad;
  String? nivelEstudio;
  String? profesion;
  bool? esConsumidorFinal;

  Clientes({
    this.id,
    this.idEmpresa,
    this.tipoEntidad,
    this.tipoIdentificacion,
    this.razonSocial,
    this.identificacion,
    this.idPais,
    this.idLocalBodega,
    this.idProvincia,
    this.idCiudad,
    this.direccion,
    this.idSector,
    this.telefono,
    this.celular,
    this.correo,
    this.observaciones,
    this.foto,
    this.latitud,
    this.longitud,
    this.fechaNacimiento,
    this.genero,
    this.estadoCivil,
    this.nacionalidad,
    this.nivelEstudio,
    this.profesion,
    this.esConsumidorFinal,
  });

  factory Clientes.fromJson(Map<String, dynamic> json) => Clientes(
        id: json["id"],
        idEmpresa: json["idEmpresa"],
        tipoEntidad: json["tipoEntidad"],
        tipoIdentificacion: json["tipoIdentificacion"],
        razonSocial: json["razonSocial"],
        identificacion: json["identificacion"],
        idPais: json["idPais"],
        idProvincia: json["idProvincia"],
        idCiudad: json["idCiudad"],
        idLocalBodega: json["idLocalBodega"],
        direccion: json["direccion"],
        idSector: json["idSector"],
        telefono: json["telefono"],
        celular: json["celular"],
        correo: json["correo"],
        observaciones: json["observaciones"],
        foto: json["foto"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        fechaNacimiento: json["fechaNacimiento"] == null
            ? null
            : DateTime.parse(json["fechaNacimiento"]),
        genero: json["genero"],
        estadoCivil: json["estadoCivil"],
        nacionalidad: json["nacionalidad"],
        nivelEstudio: json["nivelEstudio"],
        profesion: json["profesion"],
        esConsumidorFinal: json["esConsumidorFinal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idEmpresa": idEmpresa,
        "tipoEntidad": tipoEntidad,
        "tipoIdentificacion": tipoIdentificacion,
        "razonSocial": razonSocial,
        "identificacion": identificacion,
        "idPais": idPais,
        "idProvincia": idProvincia,
        "idCiudad": idCiudad,
        "idLocalBodega": idLocalBodega,
        "direccion": direccion,
        "idSector": idSector,
        "telefono": telefono,
        "celular": celular,
        "correo": correo,
        "observaciones": observaciones,
        "foto": foto,
        "latitud": latitud,
        "longitud": longitud,
        "fechaNacimiento": fechaNacimiento?.toIso8601String(),
        "genero": genero,
        "estadoCivil": estadoCivil,
        "nacionalidad": nacionalidad,
        "nivelEstudio": nivelEstudio,
        "profesion": profesion,
        "esConsumidorFinal": esConsumidorFinal,
      };
}

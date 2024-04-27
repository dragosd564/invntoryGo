import 'dart:convert';

Pais paisFromJson(String str) => Pais.fromJson(json.decode(str));

String paisToJson(Pais data) => json.encode(data.toJson());

class Pais {
  int? id;
  String? codigo;
  String? nombre;
  String? nacionalidad;
  String? codigoNacionalidad;

  Pais({
    this.id,
    this.codigo,
    this.nombre,
    this.nacionalidad,
    this.codigoNacionalidad,
  });

  factory Pais.fromJson(Map<String, dynamic> json) => Pais(
        id: json["id"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        nacionalidad: json["nacionalidad"],
        codigoNacionalidad: json["codigoNacionalidad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "nombre": nombre,
        "nacionalidad": nacionalidad,
        "codigoNacionalidad": codigoNacionalidad,
      };
}

Provincia provinciaFromJson(String str) => Provincia.fromJson(json.decode(str));

String provinciaToJson(Provincia data) => json.encode(data.toJson());

class Provincia {
  int? id;
  int? idPais;
  String? nombre;
  String? codigo;
  int? idEstado;

  Provincia({
    this.id,
    this.idPais,
    this.nombre,
    this.codigo,
    this.idEstado,
  });

  factory Provincia.fromJson(Map<String, dynamic> json) => Provincia(
        id: json["id"],
        idPais: json["idPais"],
        nombre: json["nombre"],
        codigo: json["codigo"],
        idEstado: json["idEstado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idPais": idPais,
        "nombre": nombre,
        "codigo": codigo,
        "idEstado": idEstado,
      };
}

Ciudad ciudadFromJson(String str) => Ciudad.fromJson(json.decode(str));

String ciudadToJson(Ciudad data) => json.encode(data.toJson());

class Ciudad {
  int? id;
  int? idProvincia;
  String? nombre;
  String? codigo;
  int? idEstado;

  Ciudad({
    this.id,
    this.idProvincia,
    this.nombre,
    this.codigo,
    this.idEstado,
  });

  factory Ciudad.fromJson(Map<String, dynamic> json) => Ciudad(
        id: json["id"],
        idProvincia: json["idProvincia"],
        nombre: json["nombre"],
        codigo: json["codigo"],
        idEstado: json["idEstado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idProvincia": idProvincia,
        "nombre": nombre,
        "codigo": codigo,
        "idEstado": idEstado,
      };
}

Sector sectorFromJson(String str) => Sector.fromJson(json.decode(str));

String sectorToJson(Sector data) => json.encode(data.toJson());

class Sector {
  Sector({
    this.id,
    this.sector,
    this.ipIngreso,
    this.usuarioIngreso,
    this.fechaIngreso,
    this.ipModificacion,
    this.usuarioModificacion,
    this.fechaModificacion,
    this.idEstado,
  });

  int? id;
  String? sector;
  String? ipIngreso;
  String? usuarioIngreso;
  DateTime? fechaIngreso;
  String? ipModificacion;
  String? usuarioModificacion;
  DateTime? fechaModificacion;
  int? idEstado;

  factory Sector.fromJson(Map<String, dynamic> json) => Sector(
        id: json["Id"],
        sector: json["Sector"],
        ipIngreso: json["IpIngreso"],
        usuarioIngreso: json["UsuarioIngreso"],
        fechaIngreso: json["FechaIngreso"] == null
            ? null
            : DateTime.parse(json["FechaIngreso"]),
        ipModificacion: json["IpModificacion"],
        usuarioModificacion: json["UsuarioModificacion"],
        fechaModificacion: json["FechaModificacion"] == null
            ? null
            : DateTime.parse(json["FechaModificacion"]),
        idEstado: json["IdEstado"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Sector": sector,
        "IpIngreso": ipIngreso,
        "UsuarioIngreso": usuarioIngreso,
        "FechaIngreso": fechaIngreso?.toIso8601String(),
        "IpModificacion": ipModificacion,
        "UsuarioModificacion": usuarioModificacion,
        "FechaModificacion": fechaModificacion?.toIso8601String(),
        "IdEstado": idEstado,
      };
}

Bodega bodegaFromJson(String str) => Bodega.fromJson(json.decode(str));

String bodegaToJson(Bodega data) => json.encode(data.toJson());

class Bodega {
  int? idEmpresa;
  String? direccion;
  String? ipIngreso;
  String? usuarioIngreso;
  DateTime? fechaIngreso;
  int? id;
  String? local;
  String? tipo;
  int? idEstado;
  String? defaultRuc;

  Bodega({
    this.idEmpresa,
    this.direccion,
    this.ipIngreso,
    this.usuarioIngreso,
    this.fechaIngreso,
    this.id,
    this.local,
    this.tipo,
    this.idEstado,
    this.defaultRuc,
  });

  factory Bodega.fromJson(Map<String, dynamic> json) => Bodega(
        idEmpresa: json["idEmpresa"],
        direccion: json["direccion"],
        ipIngreso: json["ipIngreso"],
        usuarioIngreso: json["usuarioIngreso"],
        fechaIngreso: json["fechaIngreso"] == null
            ? null
            : DateTime.parse(json["fechaIngreso"]),
        id: json["id"],
        local: json["local"],
        tipo: json["tipo"],
        idEstado: json["idEstado"],
        defaultRuc: json["defaultRUC"],
      );

  Map<String, dynamic> toJson() => {
        "idEmpresa": idEmpresa,
        "direccion": direccion,
        "ipIngreso": ipIngreso,
        "usuarioIngreso": usuarioIngreso,
        "fechaIngreso": fechaIngreso?.toIso8601String(),
        "id": id,
        "local": local,
        "tipo": tipo,
        "idEstado": idEstado,
        "defaultRUC": defaultRuc,
      };
}

//////
Marca marcaFromJson(String str) => Marca.fromJson(json.decode(str));

String marcaToJson(Marca data) => json.encode(data.toJson());

class Marca {
  int? id;
  int? idempresa;
  String? marca;
  String? ipingreso;
  String? usuarioingreso;
  DateTime? fechaingreso;
  int? idestado;

  Marca({
    this.id,
    this.idempresa,
    this.marca,
    this.ipingreso,
    this.usuarioingreso,
    this.fechaingreso,
    this.idestado,
  });

  factory Marca.fromJson(Map<String, dynamic> json) => Marca(
        id: json["id"],
        idempresa: json["idempresa"],
        marca: json["marca"],
        ipingreso: json["ipingreso"],
        usuarioingreso: json["usuarioingreso"],
        fechaingreso: json["fechaingreso"] == null
            ? null
            : DateTime.parse(json["fechaingreso"]),
        idestado: json["idestado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idempresa": idempresa,
        "marca": marca,
        "ipingreso": ipingreso,
        "usuarioingreso": usuarioingreso,
        "fechaingreso": fechaingreso?.toIso8601String(),
        "idestado": idestado,
      };
}

Division divisionFromJson(String str) => Division.fromJson(json.decode(str));

String divisionToJson(Division data) => json.encode(data.toJson());

class Division {
  int? id;
  int? idempresa;
  String? division;
  String? ipingreso;
  String? usuarioingreso;
  DateTime? fechaingreso;
  int? idestado;

  Division({
    this.id,
    this.idempresa,
    this.division,
    this.ipingreso,
    this.usuarioingreso,
    this.fechaingreso,
    this.idestado,
  });

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        id: json["id"],
        idempresa: json["idempresa"],
        division: json["division"],
        ipingreso: json["ipingreso"],
        usuarioingreso: json["usuarioingreso"],
        fechaingreso: json["fechaingreso"] == null
            ? null
            : DateTime.parse(json["fechaingreso"]),
        idestado: json["idestado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idempresa": idempresa,
        "division": division,
        "ipingreso": ipingreso,
        "usuarioingreso": usuarioingreso,
        "fechaingreso": fechaingreso?.toIso8601String(),
        "idestado": idestado,
      };
}

Linea lineaFromJson(String str) => Linea.fromJson(json.decode(str));

String lineaToJson(Linea data) => json.encode(data.toJson());

class Linea {
  int? id;
  int? idempresa;
  int? iddivision;
  String? linea;
  String? ipingreso;
  String? usuarioingreso;
  DateTime? fechaingreso;
  int? idestado;

  Linea({
    this.id,
    this.idempresa,
    this.iddivision,
    this.linea,
    this.ipingreso,
    this.usuarioingreso,
    this.fechaingreso,
    this.idestado,
  });

  factory Linea.fromJson(Map<String, dynamic> json) => Linea(
        id: json["id"],
        idempresa: json["idempresa"],
        iddivision: json["iddivision"],
        linea: json["linea"],
        ipingreso: json["ipingreso"],
        usuarioingreso: json["usuarioingreso"],
        fechaingreso: json["fechaingreso"] == null
            ? null
            : DateTime.parse(json["fechaingreso"]),
        idestado: json["idestado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idempresa": idempresa,
        "iddivision": iddivision,
        "linea": linea,
        "ipingreso": ipingreso,
        "usuarioingreso": usuarioingreso,
        "fechaingreso": fechaingreso?.toIso8601String(),
        "idestado": idestado,
      };
}

TipoIdentificacion tipoIdentificacionFromJson(String str) =>
    TipoIdentificacion.fromJson(json.decode(str));

String tipoIdentificacionToJson(TipoIdentificacion data) =>
    json.encode(data.toJson());

class TipoIdentificacion {
  int? idTipoIdentificacion;
  String? descripcion;
  int? idEstado;

  TipoIdentificacion({
    this.idTipoIdentificacion,
    this.descripcion,
    this.idEstado,
  });

  factory TipoIdentificacion.fromJson(Map<String, dynamic> json) =>
      TipoIdentificacion(
        idTipoIdentificacion: json["idTipoIdentificacion"],
        descripcion: json["descripcion"],
        idEstado: json["idEstado"],
      );

  Map<String, dynamic> toJson() => {
        "idTipoIdentificacion": idTipoIdentificacion,
        "descripcion": descripcion,
        "idEstado": idEstado,
      };
}

Vehiculo vehiculoFromJson(String str) => Vehiculo.fromJson(json.decode(str));

String vehiculoToJson(Vehiculo data) => json.encode(data.toJson());

class Vehiculo {
  int? id;
  String? placa;
  String? marca;
  String? modelo;
  String? observacion;
  bool? idEstado;
  int? idEmpresa;

  Vehiculo({
    this.id,
    this.placa,
    this.marca,
    this.modelo,
    this.observacion,
    this.idEstado,
    this.idEmpresa,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        id: json["id"],
        placa: json["placa"],
        marca: json["marca"],
        modelo: json["modelo"],
        observacion: json["observacion"],
        idEstado: json["idEstado"],
        idEmpresa: json["idEmpresa"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "placa": placa,
        "marca": marca,
        "modelo": modelo,
        "observacion": observacion,
        "idEstado": idEstado,
        "idEmpresa": idEmpresa,
      };
}

Chofer choferFromJson(String str) => Chofer.fromJson(json.decode(str));

String choferToJson(Chofer data) => json.encode(data.toJson());

class Chofer {
  String? inicioSesion;
  String? nombres;
  String? identificacion;
  bool? sexo;
  String? direccion;
  String? correo;
  String? contrasea;
  String? telefono;

  Chofer({
    this.inicioSesion,
    this.nombres,
    this.identificacion,
    this.sexo,
    this.direccion,
    this.correo,
    this.contrasea,
    this.telefono,
  });

  factory Chofer.fromJson(Map<String, dynamic> json) => Chofer(
        inicioSesion: json["inicioSesion"],
        nombres: json["nombres"],
        identificacion: json["identificacion"],
        sexo: json["sexo"],
        direccion: json["direccion"],
        correo: json["correo"],
        contrasea: json["contraseña"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toJson() => {
        "inicioSesion": inicioSesion,
        "nombres": nombres,
        "identificacion": identificacion,
        "sexo": sexo,
        "direccion": direccion,
        "correo": correo,
        "contraseña": contrasea,
        "telefono": telefono,
      };
}

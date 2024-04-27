import 'dart:convert';

Productos productosFromJson(String str) => Productos.fromJson(json.decode(str));

String productosToJson(Productos data) => json.encode(data.toJson());

class Productos {
  int? rowNumber;
  int? id;
  int? idEmpresa;
  String? codigoProveedor;
  String? codigoInterno;
  String? codigoBarra;
  String? tipoProducto;
  String? producto;
  String? descripcion;
  String? descipcionBusqueda;
  dynamic stock;
  dynamic stockMinimo;
  dynamic costo;
  dynamic unidadMedida;
  dynamic cantidad;
  bool? cobraIva;
  String? pathArchivo;
  String? ipIngreso;
  String? usuarioIngreso;
  DateTime? fechaIngreso;
  String? ipModificacion;
  DateTime? fechaModificacion;
  int? idEstado;
  int? idUnidadMedidaFromUnidadMedida;
  String? unidadMedidaUnidadMedidaFromUnidadMedida;

  Productos({
    this.rowNumber,
    this.id,
    this.idEmpresa,
    this.codigoProveedor,
    this.codigoInterno,
    this.codigoBarra,
    this.tipoProducto,
    this.producto,
    this.descripcion,
    this.descipcionBusqueda,
    this.stock,
    this.stockMinimo,
    this.costo,
    this.unidadMedida,
    this.cantidad = 1,
    this.cobraIva,
    this.pathArchivo,
    this.ipIngreso,
    this.usuarioIngreso,
    this.fechaIngreso,
    this.ipModificacion,
    this.fechaModificacion,
    this.idEstado,
    this.idUnidadMedidaFromUnidadMedida,
    this.unidadMedidaUnidadMedidaFromUnidadMedida,
  });

  factory Productos.fromJson(Map<String, dynamic> json) => Productos(
        rowNumber: json["rowNumber"],
        id: json["id"],
        idEmpresa: json["idEmpresa"],
        codigoProveedor: json["codigoProveedor"],
        codigoInterno: json["codigoInterno"],
        codigoBarra: json["codigoBarra"],
        tipoProducto: json["tipoProducto"],
        producto: json["producto"],
        descripcion: json["descripcion"],
        descipcionBusqueda: json["descipcionBusqueda"],
        stock: json["stock"],
        stockMinimo: json["stockMinimo"],
        costo: json["costo"],
        unidadMedida: json["unidadMedida"],
        cobraIva: json["cobraIva"],
        pathArchivo: json["pathArchivo"],
        ipIngreso: json["ipIngreso"],
        usuarioIngreso: json["usuarioIngreso"],
        fechaIngreso: json["fechaIngreso"] == null
            ? null
            : DateTime.parse(json["fechaIngreso"]),
        ipModificacion: json["ipModificacion"],
        fechaModificacion: json["fechaModificacion"] == null
            ? null
            : DateTime.parse(json["fechaModificacion"]),
        idEstado: json["idEstado"],
        idUnidadMedidaFromUnidadMedida: json["id_UnidadMedidaFromUnidadMedida"],
        unidadMedidaUnidadMedidaFromUnidadMedida:
            json["unidadMedida_UnidadMedidaFromUnidadMedida"],
      );

  Map<String, dynamic> toJson() => {
        "rowNumber": rowNumber,
        "id": id,
        "idEmpresa": idEmpresa,
        "codigoProveedor": codigoProveedor,
        "codigoInterno": codigoInterno,
        "codigoBarra": codigoBarra,
        "tipoProducto": tipoProducto,
        "producto": producto,
        "descripcion": descripcion,
        "descipcionBusqueda": descipcionBusqueda,
        "stock": stock,
        "stockMinimo": stockMinimo,
        "costo": costo,
        "unidadMedida": unidadMedida,
        "cobraIva": cobraIva,
        "pathArchivo": pathArchivo,
        "ipIngreso": ipIngreso,
        "usuarioIngreso": usuarioIngreso,
        "fechaIngreso": fechaIngreso?.toIso8601String(),
        "ipModificacion": ipModificacion,
        "fechaModificacion": fechaModificacion?.toIso8601String(),
        "idEstado": idEstado,
        "id_UnidadMedidaFromUnidadMedida": idUnidadMedidaFromUnidadMedida,
        "unidadMedida_UnidadMedidaFromUnidadMedida":
            unidadMedidaUnidadMedidaFromUnidadMedida,
      };
}

ProductoStock productoStockFromJson(String str) =>
    ProductoStock.fromJson(json.decode(str));

String productoStockToJson(ProductoStock data) => json.encode(data.toJson());

class ProductoStock {
  int? id;
  String? codigoInterno;
  String? producto;
  String? descripcion;
  int? stock;
  int? idEstado;
  String? pathArchivo;
  int? idEmpresa;
  bool? cobraIva;
  String? tipoProducto;
  int? descuento;
  String? codigoProveedor;
  int? costo;
  int? unidadMedida;
  DateTime? fechaIngreso;
  bool? hasFotoChanges;
  int? idLocal;
  int? idTarifaImpuesto;
  int? porcentajeTarifaImpuesto;
  int? idTipoUnidad;
  int? precio;
  dynamic cantidad;

  ProductoStock({
    this.id,
    this.codigoInterno,
    this.producto,
    this.descripcion,
    this.stock,
    this.idEstado,
    this.pathArchivo,
    this.idEmpresa,
    this.cobraIva,
    this.tipoProducto,
    this.descuento,
    this.codigoProveedor,
    this.costo,
    this.unidadMedida,
    this.fechaIngreso,
    this.hasFotoChanges,
    this.idLocal,
    this.idTarifaImpuesto,
    this.porcentajeTarifaImpuesto,
    this.idTipoUnidad,
    this.precio,
    this.cantidad,
  });

  factory ProductoStock.fromJson(Map<String, dynamic> json) => ProductoStock(
        id: json["id"],
        codigoInterno: json["codigoInterno"],
        producto: json["producto"],
        descripcion: json["descripcion"],
        stock: json["stock"],
        idEstado: json["idEstado"],
        pathArchivo: json["pathArchivo"],
        idEmpresa: json["idEmpresa"],
        cobraIva: json["cobraIva"],
        tipoProducto: json["tipoProducto"],
        descuento: json["descuento"],
        codigoProveedor: json["codigoProveedor"],
        costo: json["costo"],
        unidadMedida: json["unidadMedida"],
        fechaIngreso: json["fechaIngreso"] == null
            ? null
            : DateTime.parse(json["fechaIngreso"]),
        hasFotoChanges: json["hasFotoChanges"],
        idLocal: json["idLocal"],
        idTarifaImpuesto: json["idTarifaImpuesto"],
        porcentajeTarifaImpuesto: json["porcentajeTarifaImpuesto"],
        idTipoUnidad: json["idTipoUnidad"],
        precio: json["precio"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigoInterno": codigoInterno,
        "producto": producto,
        "descripcion": descripcion,
        "stock": stock,
        "idEstado": idEstado,
        "pathArchivo": pathArchivo,
        "idEmpresa": idEmpresa,
        "cobraIva": cobraIva,
        "tipoProducto": tipoProducto,
        "descuento": descuento,
        "codigoProveedor": codigoProveedor,
        "costo": costo,
        "unidadMedida": unidadMedida,
        "fechaIngreso": fechaIngreso?.toIso8601String(),
        "hasFotoChanges": hasFotoChanges,
        "idLocal": idLocal,
        "idTarifaImpuesto": idTarifaImpuesto,
        "porcentajeTarifaImpuesto": porcentajeTarifaImpuesto,
        "idTipoUnidad": idTipoUnidad,
        "precio": precio,
        "cantidad": cantidad,
      };
}

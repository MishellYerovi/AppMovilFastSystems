import 'dart:convert';
import 'package:http/http.dart' as http;


import '../constantes/const.dart';

class InfoPagosBancos {
  String nombreBanco;
  String tipoCuenta;
  String numCuenta;
  String cedula;
  String nombrePropietario;
  String emailPropietario;
  String descripcion;
  String whatsapp;

  InfoPagosBancos (this.nombreBanco,this.tipoCuenta,this.numCuenta, this. cedula, this.nombrePropietario, this.emailPropietario,
      this.descripcion,this.whatsapp );
  factory InfoPagosBancos.fromJson(dynamic json) {
    print("factory"+json.toString());
    return InfoPagosBancos(json['nombreBanco'] as String,json['tipoCuenta'] as String,json['numCuenta'] as String, json["cedula"] as String,
        json['nombrePropietario'] as String, json['emailPropietario'] as String,
        json['descripcion'] as String,json['whatsapp'] as String );
  }
  //@override
  /*String toString() {
    return '{ ${this.id},,${this.nombreAdmin}, ${this.emailAdmin} }';
  }*/

/*
//Retorno de información en formato JSON
  Map<String, dynamic> toJsonName() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nombreAdmin'] = nombreAdmin;
    data['emailAdmin'] = emailAdmin;
    return data;
  }
  Map<String, dynamic> toJsonDescripcion() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nombreAdmin'] = nombreAdmin;
    data['emailAdmin'] = emailAdmin;
    return data;
  }
*/
}




Future<List<InfoPagosBancos>> fetchInfoBanco() async {
  final response = await http
      .get(Uri.parse("$raizUrl$obtenerInfoBancos"));
  if (response.statusCode == 200) {

    print (response.body);
    final data = jsonDecode(response.body) ;

    List<InfoPagosBancos> imagenesObjs=[] ;
    //imgObjsJson.map((imageJson) => Imagenes.fromJson(imageJson)).toList();
    for(var item in data)
    {
      imagenesObjs.add(InfoPagosBancos(item["nombreBanco"],item["tipoCuenta"],item["numCuenta"], item["cedula"], item["nombrePropietario"],
      item["emailPropietario"], item["descripcion"], item ['whatsapp']));

    }
    return (imagenesObjs );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Falló al cargar');
  }


}

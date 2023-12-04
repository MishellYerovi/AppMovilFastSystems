import 'dart:convert';
import 'package:http/http.dart' as http;


import '../constantes/const.dart';

class Administrador {
  String id;
  String nombreAdmin;
  String emailAdmin;


  Administrador (this.id, this.nombreAdmin, this.emailAdmin);
  factory Administrador.fromJson(dynamic json) {
    print("factory"+json.toString());
    return Administrador(json['id'] as String, json["nombreAdmin"] as String, json['emailAdmin'] as String, );
  }
  @override
  String toString() {
    return '{ ${this.id},,${this.nombreAdmin}, ${this.emailAdmin} }';
  }


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

}




Future<List<Administrador>> fetchAdministrador() async {
  final response = await http
      .get(Uri.parse("$raizUrl""$obtenerListaAdministradores"));
  if (response.statusCode == 200) {

    print (response.body);
    final data = jsonDecode(response.body) ;

    List<Administrador> imagenesObjs=[] ;
    //imgObjsJson.map((imageJson) => Imagenes.fromJson(imageJson)).toList();
    for(var item in data)
    {
      imagenesObjs.add(Administrador(item["id"], item["nombreAdmin"], item["emailAdmin"]));
    }
    return (imagenesObjs );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Falló al cargar');
  }


}

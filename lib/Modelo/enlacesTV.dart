import 'dart:convert';
import 'package:http/http.dart' as http;


import '../constantes/const.dart';

class enlacesTVPlay {
  String id;
  String nombreEnlace;
  String enlace;


  enlacesTVPlay (this.id, this.nombreEnlace, this.enlace);
  factory enlacesTVPlay.fromJson(dynamic json) {
    print("factory"+json.toString());
    return enlacesTVPlay(json['id'] as String, json["nombreEnlace"] as String, json['enlace'] as String, );
  }
  @override
  String toString() {
    return '{ ${this.id},,${this.nombreEnlace}, ${this.enlace} }';
  }


//Retorno de información en formato JSON
  Map<String, dynamic> toJsonName() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nombreEnlace'] = nombreEnlace;
    data['enlace'] = enlace;
    return data;
  }
  Map<String, dynamic> toJsonDescripcion() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nombreEnlace'] = nombreEnlace;
    data['enlace'] = enlace;
    return data;
  }

}




Future<List<enlacesTVPlay>> fetchEnlacesTV() async {
  final response = await http
      .get(Uri.parse("$raizUrl""$enlacesTV"));
  if (response.statusCode == 200) {

    print (response.body);
    final data = jsonDecode(response.body) ;

    List<enlacesTVPlay> imagenesObjs=[] ;
    //imgObjsJson.map((imageJson) => Imagenes.fromJson(imageJson)).toList();
    for(var item in data)
    {
      imagenesObjs.add(enlacesTVPlay(item["id"], item["nombreEnlace"], item["enlace"]));
    }
    return (imagenesObjs );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Falló al cargar');
  }


}
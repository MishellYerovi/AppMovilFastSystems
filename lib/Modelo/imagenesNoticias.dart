import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constantes/const.dart';


class Imagenes {
  String id;
  String nombreNoticia;
  String imagen;


  Imagenes(this.id, this.nombreNoticia, this.imagen);
  factory Imagenes.fromJson(dynamic json) {
    print("factory"+json.toString());
    return Imagenes(json['id'] as String, json["nombre_noticia"] as String, json['imagen'] as String, );
  }
  @override
  String toString() {
    return '{ ${this.id},,${this.nombreNoticia}, ${this.imagen} }';
  }


//Retorno de información en formato JSON
  Map<String, dynamic> toJsonName() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['imagen'] = imagen;
    data['nombre_noticia'] = nombreNoticia;
    return data;
  }
  Map<String, dynamic> toJsonDescripcion() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['imagen'] = imagen;
    data['nombre_noticia'] = nombreNoticia;
    return data;
  }

}




Future<List<Imagenes>> fetchNoticias() async {
  final response = await http
      .get(Uri.parse("$raizUrl""$obtenerNoticias"));
  if (response.statusCode == 200) {

    print (response.body);
    final data = jsonDecode(response.body) ;

    List<Imagenes> imagenesObjs=[] ;
    //imgObjsJson.map((imageJson) => Imagenes.fromJson(imageJson)).toList();
 for(var item in data)
   {
     imagenesObjs.add(Imagenes(item["id"], item["nombre_noticia"], item["imagen"]));
   }
    return (imagenesObjs );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Falló al cargar');
  }


}


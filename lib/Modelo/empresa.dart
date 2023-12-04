import 'dart:convert';


import 'package:http/http.dart' as http;
import '../constantes/const.dart';


class Empresa {
  String? id;
  String? nombre;
  String? descripcion;
  String? descripcion_corta;
  String? direccion;
  String? telefono;
  String? whatsapp;
  String? paginaWeb;
  String? facebook;
  String? instagram;
  String? latitud;
  String? longitud;

  Empresa(
  {     this.id,
        this.nombre,
        this.descripcion,
        this.descripcion_corta,
        this.direccion,
        this.telefono,
        this.whatsapp,
        this.paginaWeb,
        this.facebook,
        this.instagram,
        this.latitud,
        this.longitud
  });

  factory Empresa.fromJson(Map<String, dynamic> json) {
    //print( json['id'] +"IDENTIFICADOR");
    return Empresa(
        id : json['id'] as String,
        nombre : json['nombre'] as String ,
        descripcion : json['descripcion'] as String ,
        descripcion_corta : json['descripcion_corta'] as String ,
        direccion : json['direccion'] as String ,
        telefono : json['telefono'] as String ,
        whatsapp : json['whatsapp'] as String ,
        paginaWeb : json['pagina_web'] as String ,
        facebook : json['facebook'] as String ,
        instagram : json['instagram'] as String ,
        latitud : json['latitud'] as String ,
        longitud : json['longitud'] as String ,
    );


  }

//Retorno de información en formato JSON
  Map<String, dynamic> toJsonName() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['nombre'] = nombre;
    return data;
  }
  Map<String, dynamic> toJsonDescripcion() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['descripcion'] = descripcion;
    return data;
  }
  Map<String, dynamic> toJsonDescripcionCorta() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['descripcion_corta'] = descripcion_corta;

    return data;
  }
  Map<String, dynamic> toJsonDireccion() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['direccion'] = direccion;
    return data;
  }

  Map<String, dynamic> toJsonTelefono() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['telefono'] = telefono;
    return data;
  }

  Map<String, dynamic> toJsonWhatsApp() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['whatsapp'] = whatsapp;
    return data;
  }

  Map<String, dynamic> toJsonPaginaWeb() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['pagina_web'] = paginaWeb;
    return data;
  }
  Map<String, dynamic> toJsonFacebook() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['facebook'] = facebook;
    return data;
  }
  Map<String, dynamic> toJsonInstagram() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['instagram'] = instagram;
    return data;
  }
  Map<String, dynamic> toJsonLatitud() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['latitud'] = latitud;
    return data;
  }
  Map<String, dynamic> toJsonLongitud() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['longitud'] = longitud;
    return data;
  }
  String? imprimir ()
  {
    return nombre;
  }
}




Future<Empresa> fetchEmpresa() async {
  final response = await http
      //.get(Uri.parse('https://fastsysstems99.000webhostapp.com/get.php'));
     // .get(Uri.parse('https://fastsystems23.000webhostapp.com/get.php'));
      .get(Uri.parse("$raizUrl""$obtenerDatosEmpresa"));
  if (response.statusCode == 200) {

    print (response.body);
    final data = jsonDecode(response.body)[0] ;

    print(data["nombre"]);// nombre

    return Empresa.fromJson(jsonDecode(response.body)[0] as Map<String, dynamic>);

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Falló al cargar');
  }


}



import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../Modelo/imagenesNoticias.dart';
import '../constantes/const.dart';
import 'package:http/http.dart' as http;

class listarNoticias extends StatefulWidget {
  const listarNoticias({super.key});

  @override
  State<listarNoticias> createState() => _listarNoticiasState();
}

class _listarNoticiasState extends State<listarNoticias> {
  late Future <List<Imagenes>> futureNoticias;
  //final nombreNoticia=TextEditingController();
  @override
  void initState() {
    super.initState();
    futureNoticias = fetchNoticias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Imágenes/Carousel"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
        elevation: 3,
        shadowColor: Colors.lightBlue,
        backgroundColor: Colors.lightBlueAccent,
      ),body:

          FutureBuilder(
            future:  fetchNoticias(),
            builder: (BuildContext context,snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) { //Este estado indica que el futuro se está resolviendo actualmente y recibiremos el resultado en breve.
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurpleAccent,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) { //Esto denota la finalización del futuro.
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      ' ${snapshot.error} ',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  //print("longitud future" +data!.length.toString());
                  //em.id=data!.id.toString();
                  return
                      data?.length != 0?
                          ListView(
                            children:
                            //  Padding(padding:EdgeInsets.all(8.0)), //Espacio
                              _listImagenes(data!),

                          )
                  : Container( alignment: Alignment.center, child:Text("No existen noticias"));
                }
              }

              return const Center(
                child: CircularProgressIndicator(
                  semanticsLabel: "Cargando...",
                ),
              );
            },)


    );
    // ),

  }

  List<Widget> _listImagenes(data) {

    List<Widget> imagenes=[];
    //print("tamaño"+data.length.toString());
    for(var img in data)
    {
      imagenes.add(

        Card(
         // margin: EdgeInsets.fromLTRB(1, 1, 1, 1),
          elevation: 15,
          color: Colors.red,
          child:
        Column(
          children: [
            //const Padding(padding:EdgeInsets.all(8.0)),
            //Cargar Imagen - Lista
            Image.network(img.imagen),

            const Padding(padding:EdgeInsets.all(8.0)), //Espacio
            //Botones---------------
           // Row(
               // mainAxisAlignment: MainAxisAlignment.center,
                //children: <Widget>[
                 /* IconButton(onPressed: () { //Botón Editar
                    editarImagenNoticia(img.id,img.nombre);
                  }, icon: Icon(Icons.edit, color: Colors.indigoAccent)),*/
                  IconButton(onPressed: () { //Botón Eliminar
                    //print (img.id.toString()+img.nombreNoticia.toString()+img.imagen.toString());

                    eliminarImagenNoticia(img.id.toString(), img.nombreNoticia.toString(), img.imagen.toString());
                    //Navigator.of(context).pop();


                  }, icon: Icon(Icons.delete, color: Colors.white)),
                //]),//Text(img.nombreNoticia)
            const Padding(padding:EdgeInsets.all(8.0) ), //ESPACIO
          ],
        ),
        ),

      );
    }
    return imagenes;
  }


  Future<void> eliminarImagenNoticia(id, nombre, imagen) async {
    var deleteurl = Uri.parse("$raizUrl""$eliminarImagenNoticiaCarousel");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nombre_noticia'] = nombre;
    data['imagen_noticia'] = imagen;
    var data2=json.encode(data);
    try{
      final response = await http.post(
        deleteurl,
        body:
        data2,
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      );
      if(response.statusCode == 200){

        var jsondata = json.decode(response.body);
        if(jsondata["error"]){
          print(jsondata["msg"]);
        }else{
          print("Se ha eliminado la imagen exitosamente");

        }

      }else{
        print("Error durante la conexión al servidor");
      }
    }catch(e){
      print("");
    }
    setState(() {
    }
    );
  }
}
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      extendBodyBehindAppBar: true,
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

                    child: Container(
                    padding: const EdgeInsets.all(16),
                    //height: 60,
                    //color: Colors.white,
                    child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                        children: [
                            const Icon(Icons.signal_wifi_bad_rounded, size: 80,),
                            const SizedBox(width: 8),
                            const Text('¡Error al conectarse con el servidor!'),
                            // const Text('Sin información'),
                  ],
              ),

              ),

                    /*Text(
                      ' ${snapshot.error} ',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),*/
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  //print("longitud future" +data!.length.toString());
                  //em.id=data!.id.toString();
                  return
                      data?.length != 0?
                          ListView(
                            padding: EdgeInsets.fromLTRB(0, 100, 0, 100),
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
                    alertDeseaEliminar(img.id.toString(), img.nombreNoticia.toString(), img.imagen.toString());
                    //eliminarImagenNoticia(img.id.toString(), img.nombreNoticia.toString(), img.imagen.toString());
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
         // print(jsondata["msg"]);
        }else{
         Fluttertoast.showToast(
              msg: "Se ha eliminado la imagen exitosamente",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
          //print("Se ha eliminado la imagen exitosamente");

        }

      }else{
        Fluttertoast.showToast(
            msg: "Error con el servidor",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        //print("Error durante la conexión al servidor");
      }
    }catch(e){
      /*Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );*/
      //print("");
    }
    alertEliminadoExitosamente();
    setState(() {
    }
    );
  }

  alertEliminadoExitosamente()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Eliminado exitosamente") ,
            icon: const Icon(Icons.check_circle,color: Colors.green,size:50,),
            actions: [

              TextButton(
                  onPressed: (){
                    //deleteAdmin(id, nombre, email, context);
                    Navigator.of(context).pop();
                  }, child: const Text("Ok")),


            ],

          );
        }
    );

  }

  alertDeseaEliminar(id,nombre,imagen)
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("¿Desea eliminar esta imagen?") ,
            icon: const Icon(Icons.info_sharp,color: Colors.orange,size:50,),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("No")),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    eliminarImagenNoticia(id.toString(), nombre.toString(), imagen.toString());
                  }, child: const Text("Si")),


            ],

          );
        }
    );

  }
}
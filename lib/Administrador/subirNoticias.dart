import 'dart:convert';
import 'dart:io';
import 'package:fastsystems_app2/constantes/const.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../verifConexionInternet.dart';

class guardarNoticias extends StatefulWidget {
  const guardarNoticias({super.key});

  @override
  State<guardarNoticias> createState() => _guardarNoticiasState();
}

class _guardarNoticiasState extends State<guardarNoticias> {

  //Subir Imagen
  final ImagePicker _picker = ImagePicker();
  File? uploadimage;
  Future<void> chooseImage() async {
    var choosedimage = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 20);
    if(choosedimage==null)return;
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }

  //cargando
  //int estado=0;
  //Controlador de TextEditing
  final nombreNoticia=TextEditingController();
  // Clave Formulario nombre de la noticia
  final _formKeyNombreNoticia = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
     // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Noticias"),
       /* shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),*/
        elevation: 3,
        shadowColor: Colors.lightBlue,
        backgroundColor: Colors.lightBlueAccent,
      ),body:
    SizedBox(


    width: double.infinity,
    height: double.infinity,
    child:

 Column(

     // mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[
      //  SizedBox(height: 100,),
        const WarningWidgetValueNotifier(),
 Expanded(
 child:
Card(
      //elevation: 6,
     child: SingleChildScrollView(
     padding: EdgeInsets.all(1),

   child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Align(
            alignment: Alignment.center,
         child: Container(
           padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
           child: Text("Agregar noticia", style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 18,
               fontStyle: FontStyle.normal,
               color: Colors.deepPurpleAccent),),
         ), ),

          Container(
             padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
             child:  mostrarFormNombre(),

         ),

    Card(
      elevation: 5,
      child:Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      height:300,
      //padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        //color: Colors.blueAccent,
       // border: Border.all(width: 1,color: Colors.lightBlue,),
      ),
      alignment: Alignment.center,
      child:Column( //Imagen
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(
              child:uploadimage == null?
              Container():
              SizedBox(

                  height:150,
                  child:Image.file(uploadimage!)
              )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              ElevatedButton.icon(

                onPressed: (){
                  chooseImage();
                },
                style: ElevatedButton.styleFrom( backgroundColor:Colors.indigoAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                icon:const Icon(Icons.folder_open),
                label: const Text("Seleccionar imagen"),
              ),
              Container(
                  child:uploadimage == null?
                  Container():
                  ElevatedButton.icon(
                    onPressed: (){
                      uploadImage();
                          //==1?
                      //:;
                      //guardarNombre(context);
                    },
                    style: ElevatedButton.styleFrom( backgroundColor:Colors.orangeAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    icon: const Icon(Icons.file_upload),
                    label: const Text("Guardar noticia"),
                  )
              ),

            ],),
        ],
    ),),
    ),

        ]),),
    ),),
      /*  Container(
         // padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            alignment: Alignment.bottomCenter,
            // padding: EdgeInsets.all(20),
            height: 70,
            //width: 40,
            color: Colors.indigoAccent,

        )*/
      ]),
    ),

        );
     // ),

  }

  mostrarFormNombre() {
    return Form(
        key: _formKeyNombreNoticia,
      child:TextFormField(
        keyboardType:TextInputType.text,
        maxLength: 30,
        //autofocus: true,
        controller: nombreNoticia,
        validator:  (value) {
          if (value!.isEmpty || value.trim()=="") {
            return 'Ingrese un nombre';
          }else{
            return validateNombre(value);
          }
          return null;
        },
        decoration: const InputDecoration(
          //border: OutlineInputBorder(),
          hintText: "Nombre de la noticia",
          errorMaxLines: 2,

        ),),);

  }
  int? validarFormNombre(){
    int bandera=0;
    if (_formKeyNombreNoticia.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }

  mostrarGuardando ()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Guardado exitosamente") ,
            icon: const Icon(Icons.check_circle,color: Colors.green,size:50,),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("Ok")),

            ],

          );
        }
    );

  }
  Future<void> uploadImage() async {

    if(validarFormNombre()==1){

      var nombreN=nombreNoticia.text.toString().trim();
      var uploadurl = Uri.parse('$raizUrl'"$subirImagenNoticia");
      //return estado=1;
    try{
      List<int> imageBytes = uploadimage!.readAsBytesSync();

      String baseimage = base64Encode(imageBytes);

      var response = await http.post(
        uploadurl,
        body: {
          'image': baseimage,
          'nombre': "_noticia_"+nombreN,
        },
      );
      nombreNoticia.clear();
      setState(() {
        uploadimage = null;
      });
      //print("cuerpo"+response.body.toString());
      if(response.statusCode == 200){

        var jsondata = json.decode(response.body);
        if(jsondata["error"]){
          Fluttertoast.showToast(
              msg: "Error al guardar",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
          //print(jsondata["msg"]);
        }else{
          mostrarGuardando();
          Fluttertoast.showToast(
              msg: "Se ha agregado la noticia exitosamente",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
         // print("Se ha subido la imagen exitosamente");
        }
         /* nombreNoticia.clear();
        setState(() {
          uploadimage = null;
        });*/
      }else{
        Fluttertoast.showToast(
            msg: "¡Error con el servidor!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        //print("Error durante la conexión al servidor");
      }
    }catch(e){
      Fluttertoast.showToast(
          msg: "¡Error con el servidor!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
      //print("Error durante la conversión del archivo");
    }
    }
    setState(() {
    });
  }

  String? validateNombre(String value) {
    String pattern = r'(^[a-zA-Z0-9 (/,.*-_)ñÑáéíóúÁÉÍÓÚ&]*$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      // bandera=5;// si no está en ese rango
      return "El nombre solo puede contener [0-9],[A-Z],[a-z],[&/*-,._"+ "( "+")"+"]";
    }

  }

}

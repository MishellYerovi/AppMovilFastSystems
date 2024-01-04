import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:fastsystems_app2/constantes/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Modelo/administrador.dart';
import 'package:http/http.dart' as http;

import '../verifConexionInternet.dart';

class cModificarPefil extends StatefulWidget {
  const cModificarPefil({super.key});

  @override
  State<cModificarPefil> createState() => _cModificarPefilState();
}

class _cModificarPefilState extends State<cModificarPefil> {
  late String emailAdmin="";
  late String nombreAdmin="";
  late String contraseniaAdmin="";
  late String id="";

  //Controladores de Texto
  final nombreUser=TextEditingController();
  final emailUser=TextEditingController();
  final passwordUser=TextEditingController();
  //Clve Formulario
  final _formkeyEmail= GlobalKey<FormState>();

  final _formkeyName = GlobalKey<FormState>();
  final _formkeyPassword = GlobalKey<FormState>();
  void getCredenciales( ) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      emailAdmin=pref.getString("email")!;
      contraseniaAdmin=pref.getString("contrasenia")!;
      nombreAdmin=pref.getString("nombreA")!;
      id=pref.getString("id")!;
    });


  }


  @override
  void initState() {
    getCredenciales();
    //nombreAdmin();

    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
        centerTitle: true,
        title: Text("Perfil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),  textAlign: TextAlign.center,),
        //toolbarHeight: 2,
        elevation: 3,
        shadowColor: Colors.lightBlue,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:
      SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const WarningWidgetValueNotifier(),
        Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Center(
          child: Container(
            //color:Colors.white,
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            width: 140,
            height: 140,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueGrey)
            ),
            child: Icon(Icons.person, color:Colors.indigo, size: 100,),
            //Image.asset('assets/icon.png', fit: BoxFit.fill),
          ),
        ),
      ),
              Center(
              child: SizedBox (
                child:
                Container(
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        //borderRadius: BorderRadius.circular(12)
                    ),
                         //padding: const EdgeInsets.all(5),

                              child: Card(
                                margin: const EdgeInsets.fromLTRB(20, 5, 20, 1),
                                elevation: 15,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(30),
                                    )),
                                child:
                                Column(
                                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //const Padding(padding:EdgeInsets.all(8.0)),
                                    //Cargar Imagen - Lista
                                    //Image.network(admin.imagen),
                                    const Padding(padding:EdgeInsets.all(8.0)), //Espacio
                                    ListTile(
                                      //key: _formKeyDatosAdmin,
                                      title: Text("Nombre"),
                                      subtitle: Text(nombreAdmin),//Text()),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                                          IconButton(onPressed: () {
                                            editarForNombreAdmin(nombreAdmin);
                                          }, icon: const Icon(Icons.edit, color:Colors.deepPurpleAccent)),

                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("Correo electrónico"),
                                      subtitle: Text(emailAdmin),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                                          IconButton(onPressed: () {
                                            editarFormCorreoAdmin(emailAdmin);
                                            //editarForNombreAdmin("admin.id", );
                                          }, icon: const Icon(Icons.edit, color:Colors.deepPurpleAccent)),

                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("Contraseña"),
                                      subtitle: Text("********"),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                                          IconButton(onPressed: () {


                                            editarFormContraseniaAdmin(contraseniaAdmin);
                                          }, icon: const Icon(Icons.edit, color:Colors.deepPurpleAccent)),

                                        ],
                                      ),
                                    ),

                                    const Padding(padding:EdgeInsets.all(8.0) ), //ESPACIO
                                  ],
                                ),
                              )
                                  //: Container( alignment: Alignment.center, child:const Text("Datos no disponibles"));

                        ),
                      ),),

       ]
        ),
      ),
    );

  }
  List<Widget> _listAdministradores(data) {
    List<Widget> administradores=[];
    //print("tamaño"+data.length.toString());
    for(var admin in data)
    {
      /*administradores.add(


      );*/
    }
    return administradores;
  }
  void editarForNombreAdmin(nombreAdmin) {
    nombreUser.text=nombreAdmin;
    var nombreTemporal=nombreAdmin;
    //editarEmailAdmin.text=emailAdmin;
    //var emailTemporal=emailAdmin;
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formkeyName,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:const EdgeInsets.fromLTRB(10,5,10,5),
                          child: TextFormField(
                            keyboardType:TextInputType.text,
                            //autofocus: true,
                            maxLength: 60,
                            controller: nombreUser,
                            validator:  (value) {
                              if (value!.isEmpty || value.trim()=="") {
                                return 'Ingrese un nombre';
                              }else{
                                // if(nombreTemporal == editarNombreAdmin.text)
                                // {
                                //Navigator.of(context).pop();
                                // return  alertCambioNombre();
                                //  }else{
                                return validateNombre(value);
                                // }

                              }
                              return null;

                            },
                            /* onChanged:(value)
                      {
                        value!.length==0?
                        editarNombreAdmin.clear():null;
                      },*/
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nombre",
                              errorMaxLines: 2,
                              prefixIcon: Icon(
                                Icons.person,
                                //color: Colors.green,
                              ),
                            ),
                          ), ),
                        /*Padding(
                          padding:const EdgeInsets.fromLTRB(10,5,10,5),
                          child: TextFormField(
                            keyboardType:TextInputType.emailAddress,
                            maxLength: 30,
                            //autofocus: true,
                            //controller: editarEmailAdmin,
                            validator:  (value) {
                              if (value!.isEmpty || value.trim()=="") {
                                return 'Ingrese un correo electrónico';
                              }else{
                                //if(emailTemporal==editarEmailAdmin.text)
                                //{
                                //Navigator.of(context).pop();
                                //return alertNoCambios();
                                //}else{
                                //return validateEmail(value) ; //}
                              }
                            },
                            /*onChanged:  (value) {
                value!.length==0?
                _formKeyDatosAdmin.currentState?.reset():null;
              },*/
                            decoration: const InputDecoration(
                              //border: OutlineInputBorder(),
                              hintText: "Correo electrónico",
                              border: OutlineInputBorder(),
                              errorMaxLines: 3,
                              prefixIcon: Icon(
                                Icons.email,
                                //color: Colors.green,
                              ),


                            ),),
                        ),*/

                      ]),),
              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    guardarCambioNombreA(context,nombreTemporal );
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );


  }

  void editarFormCorreoAdmin(correoAdmin) {
    emailUser.text=correoAdmin;
    var emailTemporal=correoAdmin;
    //editarEmailAdmin.text=emailAdmin;
    //var emailTemporal=emailAdmin;
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formkeyEmail,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:const EdgeInsets.fromLTRB(10,5,10,5),
                          child: TextFormField(
                            keyboardType:TextInputType.emailAddress,
                            maxLength: 60,
                            //autofocus: true,
                            controller: emailUser,
                            validator:  (value) {
                              if (value!.isEmpty || value.trim()=="") {
                                return 'Ingrese un correo electrónico';
                              }else{
                                //if(emailTemporal==editarEmailAdmin.text)
                                //{
                                //Navigator.of(context).pop();
                                //return alertNoCambios();
                                //}else{
                             return validateEmail(value) ;  //}
                              }
                            },
                            /*onChanged:  (value) {
                value!.length==0?
                _formKeyDatosAdmin.currentState?.reset():null;
              },*/
                            decoration: const InputDecoration(
                              //border: OutlineInputBorder(),
                              hintText: "Correo electrónico",
                              border: OutlineInputBorder(),
                              errorMaxLines: 3,
                              prefixIcon: Icon(
                                Icons.email,
                                //color: Colors.green,
                              ),
                            ),),
                        ),
                      ]),),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    guardarCambioEmailA(context, emailTemporal);
                    //guardarCambiosAdmin(context,id,nombreTemporal,emailTemporal);
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );


  }
  void editarFormContraseniaAdmin(contraseniaAdmin) {
    //passwordUser.text=contraseniaAdmin;
    var contraseniaTemporal=contraseniaAdmin;
    //editarEmailAdmin.text=emailAdmin;
    //var emailTemporal=emailAdmin;
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formkeyPassword,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:const EdgeInsets.fromLTRB(10,5,10,5),
                          child: TextFormField(
                            keyboardType:TextInputType.visiblePassword,
                            obscureText: true,//!_passwordV
                            //keyboardType:TextInputType.emailAddress,
                            maxLength: 16,
                            //autofocus: true,
                            controller: passwordUser,
                            validator:  (value) {
                              if (value!.isEmpty || value.trim()=="") {
                                return 'Ingrese una contraseña';
                              }else{
                                //if(emailTemporal==editarEmailAdmin.text)
                                //{
                                //Navigator.of(context).pop();
                                //return alertNoCambios();
                                //}else{
                                return validatePassword(value) ; //}
                              }
                            },
                            /*onChanged:  (value) {
                value!.length==0?
                _formKeyDatosAdmin.currentState?.reset():null;
              },*/
                            decoration: const InputDecoration(
                              //border: OutlineInputBorder(),
                              hintText: "Contraseña",
                              border: OutlineInputBorder(),
                              errorMaxLines: 3,
                              prefixIcon: Icon(
                                Icons.email,
                                //color: Colors.green,
                              ),
                            ),),
                        ),
                      ]),),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    guardarCambioPasswordA(context,contraseniaTemporal);
                    //guardarCambiosAdmin(context,id,nombreTemporal,emailTemporal);
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );


  }

  String? validateNombre(String value) {

    String pattern = r'(^[a-zA-Z0-9 (/,.*-_)ñÑáéíóúÁÉÍÓÚ&]*$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      // bandera=5;// si no está en ese rango
      return "El nombre solo puede contener [0-9],[A-Z],[a-z],[&/*-,._"+ "( "+")"+"]";
    }
  }

  String? validatePassword(String value) {

    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    // bool isURLValid = Uri.parse(value).host.isNotEmpty;//V
    //!regExp.hasMatch(value)||

    if (!regExp.hasMatch(value) ) {
      return "La contraseña debe tener al menos 8 caracteres. (Una letra mayúscula, una letra minúscula, un número y un caracter especial) ";
    }

  }

  String?  validateEmail(String value) {
    String pattern = "^[a-z0-9!#%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value) ) {
      return "Ingrese un correo válido: user@example.com";
    }
  }

  //Validaciones de Formularios
  int? validarFormNombreAdmin(){
    int bandera=0;
    if (_formkeyName.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarFormEmailAdmin(){
    int bandera=0;
    if (_formkeyEmail.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarFormPasswordAdmin(){
    int bandera=0;
    if (_formkeyPassword.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  //se envía el nuevo nombre al servidor
  Future<void> guardarCambioNombreA( BuildContext context, nombreTemporal) async
  {
    var nombre=nombreUser.text.trim();
    //var email= emailUser.text.trim();
    var urlEnviarNombreAdmin=Uri.parse("$raizUrl$editNombrePerfilAdmin");


    if(validarFormNombreAdmin()==1) {
      if (nombreTemporal != nombre ) {
        try{
         // print(id);
         // print(nombre);
         // print(nombreTemporal);
          //print(email);


            var response = await http.post(urlEnviarNombreAdmin,
                body: {
                  'id':id,
                  'nombreA':nombre,
                }
            );
            if(response.statusCode == 200){
              //print("Entra");
              var jsondata = json.decode(response.body);
              // print("nombre"+jsondata1);

              if(jsondata["Correcto"]){
                //print("hola"+jsondata["Correcto"].toString());
                Navigator.of(context).pop();
                alertCambioNombre();
                setState(() {
                  nombreAdmin=nombre;
                });
                //_formkeyName.currentState?.reset();
                nombreUser.clear();
                //reload();

              }else{
                Fluttertoast.showToast(
                    msg: "¡Error al editar el nombre!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                //print("Error al editar el Nombre");
              }
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
          //print("Error en el Servidor nombre"+e.toString());
        }

      }else{
        Navigator.of(context).pop();
        alertNingunCambio();
      }
    }else{

      //print("ERROR");
    }
  }

  Future<void> guardarCambioEmailA( BuildContext context, emailTemporal) async
  {
    var email=emailUser.text.trim();
    //var email= emailUser.text.trim();
    var urlEnviarNombreAdmin=Uri.parse("$raizUrl$editEmailPerfilAdmin");


    if(validarFormEmailAdmin()==1) {
      if (emailTemporal != email ) {
        try{
          // print(id);
          //print(email);
          //print(emailTemporal);
          //print(email);


          var response = await http.post(urlEnviarNombreAdmin,
              body: {
                'id':id,
                'emailA':email,
              }
          );
          if(response.statusCode == 200){
            //print("Entra");
            var jsondata = json.decode(response.body);
            // print("nombre"+jsondata1);

            if(jsondata["Correcto"]){
              //print("hola"+jsondata["Correcto"].toString());
              Navigator.of(context).pop();
              setState(() {
                emailAdmin=email;
              });
              //_formkeyName.currentState?.reset();
              emailUser.clear();
              //reload();
              alertCambioEmail();
            }else{
              Fluttertoast.showToast(
                  msg: "¡Error al editar el correo!",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
             // print("Error al editar el Correo Electrónico");
            }
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
         // print("Error en el Servidor nombre"+e.toString());
        }

      }else{
        Navigator.of(context).pop();
        alertNingunCambio();
      }
    }else{
      //print("ERROR");
    }
  }

  Future<void> guardarCambioPasswordA( BuildContext context, contraseniaTemporal) async
  {

    var passwordA=passwordUser.text.trim();
    final bytes = utf8.encode(passwordA); // data being hashed
    final passwordCrypto= sha512.convert(bytes);
    final password=passwordCrypto.toString();
    //var email= emailUser.text.trim();
    var urlEnviarContraseniaAdmin=Uri.parse("$raizUrl$editContraseniaPerfilAdmin");


    if(validarFormPasswordAdmin()==1) {
      if (contraseniaTemporal != password ) {
        try{
          // print(id);
         // print(password);
         // print(contraseniaTemporal);
          //print(email);


          var response = await http.post(urlEnviarContraseniaAdmin,
              body: {
                'id':id,
                'passwordA':password,
              }
          );
          if(response.statusCode == 200){
            //print("Entra");
            var jsondata = json.decode(response.body);
            // print("nombre"+jsondata1);

            if(jsondata["Correcto"]){
              //print("hola"+jsondata["Correcto"].toString());
              Navigator.of(context).pop();
              alertCambioPassword();

              setState(() {
                contraseniaAdmin=password;
              });

              //_formkeyName.currentState?.reset();
              passwordUser.clear();
              //reload();

            }else{
              Fluttertoast.showToast(
                  msg: "¡Error al editar la contraseña!",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            }
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
          //print("Error en el Servidor nombre"+e.toString());
        }

      }else{
        Navigator.of(context).pop();
        alertNingunCambio();
      }
    }else{
      //print("ERROR");
    }
  }
  alertNingunCambio()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Ningún cambio aplicado") ,
            icon: const Icon(Icons.check_circle,color: Colors.green,size:50,),
            actions: [
              TextButton(
                  onPressed: (){
                    passwordUser.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Ok")),
            ],
          );
        }
    );
  }

  alertCambioNombre()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Nombre cambiado correctamente") ,
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
  alertCambioEmail()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Correo electrónico cambiado correctamente.\nInicie sesión nuevamente") ,
            icon: const Icon(Icons.check_circle,color: Colors.green,size:50,),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    cerrarSesion();
                  }, child: const Text("Ok")),
            ],
          );
        }
    );
  }
  alertCambioPassword()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Contraseña cambiada correctamente.\nInicie sesión nuevamente") ,
            icon: const Icon(Icons.check_circle,color: Colors.green,size:50,),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    cerrarSesion ();
                  }, child: const Text("Ok")
              ),
            ],
          );
        }
    );
  }
  void cerrarSesion () async
  {
    //setState(() async {
    SharedPreferences pref= await SharedPreferences.getInstance();
    await pref.clear();
    context.pushReplacementNamed("HomeLogInAdministrador");
    //});
  }

}

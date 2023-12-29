import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:fastsystems_app2/Modelo/administrador.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constantes/const.dart';

class cListarAdministradores extends StatefulWidget {
  const cListarAdministradores({super.key});

  @override
  State<cListarAdministradores> createState() => _cListarAdministradoresState();
}

class _cListarAdministradoresState extends State<cListarAdministradores> {

  late Future <List<Administrador>> futureAdmin;
  //Formulario para agregar un administrador
  final _formKeyDatosAdmin= GlobalKey<FormState>();//Clave de formulario
  final nombreAdmin=TextEditingController(); //Controlador
  final emailAdmin=TextEditingController(); //Controlador
  final passwordAdmin=TextEditingController(); //Controlador

  //Formulario para Editar al Administrador
  final _formKeyEditarDatosAdmin= GlobalKey<FormState>();//Clave de formulario
  final editarNombreAdmin=TextEditingController(); //Controlador
  final editarEmailAdmin=TextEditingController(); //Controlador
  //final editarPasswordAdmin=TextEditingController(); //Controlador

  @override
  void initState() {

    super.initState();
    futureAdmin=fetchAdministrador();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Administradores"),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              )),
          elevation: 3,
          shadowColor: Colors.lightBlue,
          backgroundColor: Colors.lightBlueAccent,
        ),body:
    Scrollbar(
      radius: const Radius.circular(50),
      trackVisibility: true,
    child: SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(5, 5,5, 80),
    child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                  child: const Text("Agregar Administrador", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      color: Colors.deepPurpleAccent),),
                ), ),

                Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),

                    child:  mostrarFormDatosAdmin(),
                ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                      child: const Text("Administradores", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: Colors.blueAccent),),
                    ), ),
                SizedBox (
                child:
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12) ),
                    padding: const EdgeInsets.all(5),
                child: FutureBuilder(
                  future:  fetchAdministrador(),
                  builder: (BuildContext context,snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) { //Este estado indica que el futuro se está resolviendo actualmente y recibiremos el resultado en breve.
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
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
                          Container(
                            //height: 240,
                              child:Scrollbar(
                                  radius: const Radius.circular(50),
                                  //thumbVisibility: true,
                                  trackVisibility: true,
                            //scrollbarOrientation: ScrollbarOrientation.top,
                              child:ListView(
                                padding: const EdgeInsets.all(10),
                            shrinkWrap: true,
                            children:
                            //  Padding(padding:EdgeInsets.all(8.0)), //Espacio
                            _listAdministradores(data!),

                          )))
                              : Container( alignment: Alignment.center, child:const Text("No existen administradores"));
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: "Cargando...",
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),

                      ),
                    );
                  },) ),),

        ]),),),


    );
    // ),
  }

  List<Widget> _listAdministradores(data) {
    List<Widget> administradores=[];
    //print("tamaño"+data.length.toString());
    for(var admin in data)
    {
      administradores.add(
        Card(
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          elevation: 15,
          color: Colors.white,
          child:
          Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
           mainAxisSize: MainAxisSize.min,
            children: [
              //const Padding(padding:EdgeInsets.all(8.0)),
              //Cargar Imagen - Lista
              //Image.network(admin.imagen),
              const Padding(padding:EdgeInsets.all(8.0)), //Espacio
              ListTile(
                title: Text(admin.nombreAdmin),
               subtitle: Text(admin.emailAdmin),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                    IconButton(onPressed: () {

                      editarFormAdmin(admin.id, admin.nombreAdmin, admin.emailAdmin);
                    }, icon: const Icon(Icons.edit, color:Colors.deepPurpleAccent)),
                    IconButton(onPressed: () {
                      alertDeseaEliminar(admin.id, admin.nombreAdmin, admin.emailAdmin);
                    }, icon: const Icon(Icons.delete, color: Colors.red,)),
                  ],
                ),
              ),


              //Botones---------------
              // Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              //children: <Widget>[
              /* IconButton(onPressed: () { //Botón Editar
                    editarImagenNoticia(img.id,img.nombre);
                  }, icon: Icon(Icons.edit, color: Colors.indigoAccent)),*/
             /* IconButton(onPressed: () { //Botón Eliminar

                eliminarAdministrador(admin.id.toString(), admin.nombreAdmin.toString(), admin.emailAdmin.toString());

              }, icon: Icon(Icons.delete, color: Colors.white)),
              //]),//Text(img.nombreNoticia)*/
              const Padding(padding:EdgeInsets.all(8.0) ), //ESPACIO
            ],
          ),
        ),

      );
    }
    return administradores;
  }


  Future<void> eliminarAdministrador(id, nombre, email) async {
    var deleteurl = Uri.parse("$raizUrl""$eliminarImagenNoticiaCarousel");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nombreAdmin'] = nombre;
    data['emailAdmin'] = email;
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
          //print(jsondata["msg"]);
        }else{
          //print("Se ha eliminado exitosamente");

        }

      }else{
        //print("Error durante la conexión al servidor");
      }
    }catch(e){
      print("");
    }
    setState(() {
    }

    );
  }

  mostrarFormDatosAdmin() {
    return
      Card(
          elevation: 5,
          color: Colors.white,
         // margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Form(
      key: _formKeyDatosAdmin,
      child:Column(
        children: <Widget>[
        Padding(
        padding: const EdgeInsets.fromLTRB(25,20,25,5),
        child: TextFormField(
                keyboardType:TextInputType.text,
                maxLength: 60,
                //autofocus: true,
                controller: nombreAdmin,
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
                    hintText: "Nombre",
                    labelText: 'Nombre',
                    errorMaxLines: 2,
                    prefixIcon: Icon(
                      Icons.person,
                      //color: Colors.green,
                    ),
                    border: OutlineInputBorder(
                      //borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                            Radius.circular(9.0)))
                ),
            /*onChanged:  (value) {
              value!.length==0?
              _formKeyDatosAdmin.currentState?.reset():null;
            }*/

        ),
         ),
          Padding(
            padding:const EdgeInsets.fromLTRB(25,5,25,5),
            child: TextFormField(
              keyboardType:TextInputType.emailAddress,
              maxLength: 60,
              //autofocus: true,
              controller: emailAdmin,
              validator:  (value) {
                if (value!.isEmpty || value.trim()=="") {
                  return 'Ingrese un correo electrónico';
                }else{
                  return validateEmail(value);
                }
              },
              /*onChanged:  (value) {
                value!.length==0?
                _formKeyDatosAdmin.currentState?.reset():null;
              },*/
              decoration: const InputDecoration(
                //border: OutlineInputBorder(),
                labelText: 'Correo electrónico',
                hintText: "Correo electrónico",
                errorMaxLines: 3,
                prefixIcon: Icon(
                  Icons.email,
                  //color: Colors.green,
                ),
                  border: OutlineInputBorder(
                    //borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(
                          Radius.circular(9.0)))

              ),),
          ),
          Padding(
            padding:const EdgeInsets.fromLTRB(25,5,25,10),
            child: TextFormField(
              keyboardType:TextInputType.visiblePassword,
              maxLength:16 ,
              autofocus: false,
              obscureText: true,//!_passwordVisible,
              controller: passwordAdmin,
              decoration: const InputDecoration(
                errorMaxLines: 4,
                hintText: 'Contraseña',
                labelText: 'Contraseña',
                prefixIcon: Icon(
                  Icons.key,
                ),

               /*suffixIcon:IconButton(
                 icon: Icon(
                   // Based on passwordVisible state choose the icon
                   _passwordVisible
                       ? Icons.visibility
                       : Icons.visibility_off,
                   color: Theme.of(context).primaryColorDark,
                 ), onPressed: () {
                 setState(() {
                   _passwordVisible = !_passwordVisible;
                 });
               },

               ),*/

               // errorStyle: TextStyle(fontSize: 14.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius:
                    BorderRadius.all(Radius.circular(9.0))),
              ),
              /*onChanged:  (value) {
                value!.length==0?
                passwordAdmin.clear():null;
                //_formkeyEmailAndPassword.currentState?.reset():null;
              },*/
              validator:  (value) {
                if (value!.isEmpty || value.trim()=="") {
                  //_formkeyEmailAndPassword.currentState?.reset();
                  passwordAdmin.clear();
                  return 'Ingrese la contraseña';
                }else{
                  return validatePassword(value);

                  //return validatePassword(value);
                }},
                /*onChanged:  (value) {
                  value!.length==0?
                  _formKeyDatosAdmin.currentState?.reset():null;
                }*/
            ),
          ),

          Padding(
              padding:const EdgeInsets.fromLTRB(25,5,25,10),
            child:  ElevatedButton.icon(
              onPressed: (){
              guardarAdmin();
              },
              style: ElevatedButton.styleFrom( backgroundColor:Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              icon: const Icon(Icons.save),
              label: const Text("Guardar"),
            ),
          ),
     ])));

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
  int? validarFormAdmin(){
    int bandera=0;
    if (_formKeyDatosAdmin.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarCambiosFormAdmin(){
    int bandera=0;
    if (_formKeyEditarDatosAdmin.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }

  alertMostrarAdminYaExiste()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Administrador ya existe") ,
            icon: const Icon(Icons.dangerous_sharp,color: Colors.red,size:50,),
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
  alertDeseaEliminar(id,nombre,email)
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("¿Desea eliminar este administrador?") ,
            icon: const Icon(Icons.info_sharp,color: Colors.orange,size:50,),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("No")),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    deleteAdmin(id, nombre, email, context);
                  }, child: const Text("Si")),


            ],

          );
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
  alertNoEliminado()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Eliminado exitosamente") ,
            icon: const Icon(Icons.dangerous,color: Colors.red,size:50,),
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
  alertMostrarAdminRegistradoCorrect()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Se ha registrado exitosamente") ,
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
            title:const Text("Email cambiado correctamente") ,
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
  alertCambioInformacionAdmin()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Datos cambiados correctamente") ,
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
                    Navigator.of(context).pop();
                  }, child: const Text("Ok")),

            ],

          );
        }
    );

  }


  Future guardarAdmin() async{

     if(validarFormAdmin()==1)
       {
         var nombreAdministrador=nombreAdmin.text.toString().trim();
         var emailAdministrador=emailAdmin.text.toString().trim();
         var passwordAdministrador=passwordAdmin.text.toString().trim();
         var guardarAdmin=Uri.parse("$raizUrl""$agregarAdministradores");
         final bytes = utf8.encode(passwordAdministrador); // data being hashed
         final passwordDigest = sha512.convert(bytes);
         final hexPasswordDigest=passwordDigest.toString();
         print("encriptado:"+hexPasswordDigest.toString());
         try{
           var response = await http.post(
             guardarAdmin,
             body: {
               'emailA': emailAdministrador,
               'nombreA': nombreAdministrador,
               'passwordA': hexPasswordDigest,
             },
           );

           if(response.statusCode == 200){
             //print("hola2"+response.body);
              var jsondata = json.decode(response.body);
             if(jsondata["YaExiste"]){
               alertMostrarAdminYaExiste();
               print("YaExiste");
             }else
             {
               if(jsondata["RegistroExitoso"]){
                 print("Registrado");
                 alertMostrarAdminRegistradoCorrect();
                 nombreAdmin.clear();
                 emailAdmin.clear();
                 passwordAdmin.clear();
                // _formKeyDatosAdmin.currentState?.reset();
                 setState(() {
                 });
               }else {
                 print("Registro Fallido");

               }

             }
           }


         }catch(e){
           print("Error con el servidor");
         }
       }
  }

  Future deleteAdmin(id,nombre,email, BuildContext context) async {

    var deleteAdmin= Uri.parse("$raizUrl""$eliminarAdmin");
    try{
      var response = await http.post(
        deleteAdmin,
        body: {
          'id': id,
          'nombre': nombre,
          'email': email,
        },
      );

      if(response.statusCode == 200){
       // print("hola2"+response.body);
        var jsondata = json.decode(response.body);
        if(jsondata["Eliminado"]){
          alertEliminadoExitosamente();
          //print("Eliminado exitosamente");
          setState(() {
          });
        }else
        {
          if(jsondata["NoEliminado"]){
           // print("Error, no se ha eliminado");
            alertNoEliminado();
          }else {
            print("Error");

          }

        }
      }


    }catch(e){
      print("Error con el servidor");
    }

  }

  void editarFormAdmin(id, nombreAdmin, emailAdmin) {
    editarNombreAdmin.text=nombreAdmin;
    var nombreTemporal=nombreAdmin;
    editarEmailAdmin.text=emailAdmin;
    var emailTemporal=emailAdmin;
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                    key: _formKeyEditarDatosAdmin,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
              Padding(
                padding:const EdgeInsets.fromLTRB(10,5,10,5),
                    child: TextFormField(
                      keyboardType:TextInputType.text,
                      //autofocus: true,
                      maxLength: 60,
                      controller: editarNombreAdmin,
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
                    Padding(
                      padding:const EdgeInsets.fromLTRB(10,5,10,5),
                      child: TextFormField(
                        keyboardType:TextInputType.emailAddress,
                        maxLength: 60,
                        //autofocus: true,
                        controller: editarEmailAdmin,
                        validator:  (value) {
                          if (value!.isEmpty || value.trim()=="") {
                            return 'Ingrese un correo electrónico';
                          }else{
                          //if(emailTemporal==editarEmailAdmin.text)
                          //{
                            //Navigator.of(context).pop();
                            //return alertNoCambios();
                          //}else{
                             return validateEmail(value) ; //}
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
                    guardarCambiosAdmin(context,id,nombreTemporal,emailTemporal);
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );


  }

  Future<void> guardarCambiosAdmin( BuildContext context,id, nombreTemporal, emailTemporal) async
  {
    var nombre=editarNombreAdmin.text.trim();
    var email= editarEmailAdmin.text.trim();
    var urlEnviarEditarDatosAdmin=Uri.parse("$raizUrl$editarAdminFromAdmin");
   /* print(id);
    print(nombre);
    print(email);*/

    if(validarCambiosFormAdmin()==1) {
      if (nombreTemporal != nombre && emailTemporal == email ) {


        //nombreTemporal != nombre && emailTemporal == email
        try{
          print(id);
           print(nombre);
            print(email);
          var response = await http.post(urlEnviarEditarDatosAdmin,
            body: {
              'id':id,
              'nombreA':nombre
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
              editarNombreAdmin.clear();
              editarEmailAdmin.clear();
              setState(() {});
            }else{
              print("Error al editar el Nombre del administrador");
            }
          }
        }catch(e){
          print("Error en el Servidor nombre"+e.toString());
        }
        //se envía el nombre
      }else{
        if(nombreTemporal != nombre && emailTemporal != email)
        {
          //se envía nombre-email
          try{
            var response = await http.post(
              urlEnviarEditarDatosAdmin,
              body: {
                'id': id,
                'nombreA':nombre,
                'emailA': email
              },
            );
            if(response.statusCode == 200){
              var jsondata = json.decode(response.body);
              //print("info"+jsondata);
              if(jsondata["Correcto"]){
                Navigator.of(context).pop();
                alertCambioInformacionAdmin();
                editarNombreAdmin.clear();
                editarEmailAdmin.clear();
                setState(() {});
              }else{
                print("Error al editar la información");
              }
            }
          }catch(e){
            print("Error en el Servidor" +e.toString());
          }
        }
        else{

          if(nombreTemporal == nombre && emailTemporal != email)
        {
        //se envía el email
        try{
          var response = await http.post(
            urlEnviarEditarDatosAdmin,
            body: {
              'id': id,
              'emailA': email,

            },
          );
          if(response.statusCode == 200){
            var jsondata = json.decode(response.body);
           // print("email"+jsondata);

            if(jsondata["Correcto"]){
              Navigator.of(context).pop();
              alertCambioEmail();
              editarNombreAdmin.clear();
              editarEmailAdmin.clear();
              setState(() {});
            }else{
              print("Error al editar el Email del administrador");
            }

          }
        }catch(e){
          print("Error en el Servidor email"+e.toString());
        }
      }
         else
              {
                if(nombreTemporal == nombre && emailTemporal == email)
                  {
                    Navigator.of(context).pop();
                    alertNingunCambio();
                    //editarNombreAdmin.clear();
                    //editarEmailAdmin.clear();
                  }
              }
          }
        }
      }else{
      print("ERROR");
    }
  }



}

import 'dart:convert';
import 'package:fastsystems_app2/constantes/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../Modelo/empresa.dart';

class editarInformacionEmpresa extends StatefulWidget {
  const editarInformacionEmpresa({super.key});
  @override
  State<editarInformacionEmpresa> createState() =>
      _editarInformacionEmpresaState();
}

class _editarInformacionEmpresaState extends State<editarInformacionEmpresa> {
  late Future<Empresa> futureEmpresa;
  Empresa em= Empresa();
  late int id=0;
  final nombre=TextEditingController();
  final descripcion=TextEditingController();
  final descripcionCorta=TextEditingController();
  final direccion=TextEditingController();
  final telefono=TextEditingController();
  final whatsapp=TextEditingController();
  final paginaWeb=TextEditingController();
  final facebook=TextEditingController();
  final instagram=TextEditingController();
  final latitud=TextEditingController();
  final longitud=TextEditingController();
  final _formKeyNombre = GlobalKey<FormState>();
  final _formKeyDescripcion = GlobalKey<FormState>();
  final _formKeyDescripcionCorta = GlobalKey<FormState>();
  final _formKeyDireccion = GlobalKey<FormState>();
  final _formKeyTelefono = GlobalKey<FormState>();
  final _formKeyWhatsApp= GlobalKey<FormState>();
  final _formKeyPaginaWeb= GlobalKey<FormState>();
  final _formKeyInstagram= GlobalKey<FormState>();
  final _formKeyFacebook= GlobalKey<FormState>();
  final _formKeyLatitud= GlobalKey<FormState>();
  final _formKeyLongitud= GlobalKey<FormState>();

  late String nombreTemporal="";

  @override
  void initState() {
    super.initState();
    futureEmpresa = fetchEmpresa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Datos de la Empresa"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
        elevation: 3,
        shadowColor: Colors.lightBlue,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:
      SizedBox(
        width: double.infinity,
        height: double.infinity,
                child: Form(
                    child:
                    FutureBuilder(
                      future:  fetchEmpresa(),
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
                            em.id=data!.id.toString();
                            return SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 80),
                              child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                  ListTile(
                                    contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                    leading: const Icon(Icons.business_rounded, color:Colors.black45),
                                    title: const Text("Nombre de la empresa"),
                                    subtitle: Text(data.nombre.toString()),
                                    trailing: IconButton(onPressed: ()
                                      {
                                        mostrarFormNombreEmpresa();
                                      },
                                      icon: const Icon(Icons.edit),
                                      color: Colors.lightBlueAccent,
                                      disabledColor: Colors.black,
                                      focusColor: Colors.deepPurpleAccent,
                                      highlightColor: Colors.yellowAccent,
                                      hoverColor: Colors.deepPurpleAccent,
                                      splashColor: Colors.pinkAccent,

                                    ),
                                  ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                      leading: const Icon(Icons.text_snippet_outlined, color:Colors.black45),
                                      title: const Text("Descripción/Sobre nosotros"),
                                      subtitle: Text(data.descripcion.toString()),
                                      trailing:  IconButton(onPressed: ()
                                      {
                                        mostrarFormDescripcionEmpresa();
                                      },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                      leading: const Icon(Icons.text_snippet_outlined, color:Colors.black45),
                                      title: const Text("Breve Descripción"),
                                      subtitle: Text(data.descripcion_corta.toString()),
                                      trailing:  IconButton(onPressed: ()
                                      {
                                        mostrarFormDescripcionCortaEmpresa();
                                      },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                      leading: const Icon(Icons.location_on_sharp, color:Colors.black45),
                                      title: const Text("Dirección"),
                                      subtitle: Text(data.direccion.toString()),
                                      trailing:  IconButton(onPressed: ()
                                      {
                                        mostrarFormDireccionEmpresa();
                                      },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                      leading: const Icon(Icons.phone, color:Colors.black45),
                                      title: const Text("Teléfono"),
                                      subtitle: Text(data.telefono.toString()),
                                      trailing:  IconButton(onPressed: ()
                                      {
                                        mostrarFormTelefonoEmpresa();

                                      },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                      leading: const Icon(Icons.chat_bubble_outlined, color:Colors.black45),
                                      title: const Text("WhatsApp"),
                                      subtitle: Text(data.whatsapp.toString()),
                                      trailing:  IconButton(onPressed: ()
                                      {
                                        mostrarFormWhatsAppEmpresa();
                                      },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                      leading: const Icon(Icons.web, color:Colors.black45),
                                      title: const Text("Página Web"),
                                      subtitle: Text(data.paginaWeb.toString()),
                                      trailing:  IconButton(onPressed: ()
                                      {
                                        mostrarFormPaginaWebEmpresa();
                                      },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                      leading: const Icon(Icons.facebook, color:Colors.black45),
                                      title: const Text("Facebook"),
                                      subtitle: Text(data.facebook.toString()),
                                      trailing: IconButton(onPressed: ()
                                      {
                                        mostrarFormFacebook();
                                      },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                      leading: const Icon(Icons.chat, color:Colors.black45),
                                      title: const Text("Instagram"),
                                      subtitle: Text(data.instagram.toString()),
                                      trailing:  IconButton(onPressed: ()
                                      {
                                        mostrarFormInstagram();
                                      },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                      leading: const Icon(Icons.linear_scale_rounded, color:Colors.black45),
                                      title: const Text("Latitud"),
                                      subtitle: Text(data.latitud.toString()),
                                      trailing:  IconButton(onPressed: ()
                                      {
                                        mostrarFormLatitud();
                                      },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:  const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                      leading: const Icon(Icons.linear_scale_rounded, color:Colors.black45),
                                      title: const Text("Longitud"),
                                      subtitle: Text(data.longitud.toString()),
                                      trailing:  IconButton(onPressed: ()
                                      {
                                        mostrarFormLongitud();
                                      },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                ]
                              ),


                            );
                          }
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },)

                  /*TextField(
                              style: Theme.of(context).textTheme.labelSmall,
                            ),*/


                ),

      ),
    );
  }

  void mostrarFormNombreEmpresa() {
    showDialog(context: context, 
        builder: (context){
          return  AlertDialog(

            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKeyNombre,
            child: TextFormField(
                keyboardType:TextInputType.text,
                autofocus: true,
                maxLength: 30,
                controller: nombre,
                //inputFormatters: [FilteringTextInputFormatter.allow( RegExp(r'(^[a-z A-Z]*$)'))],
                //inputFormatters: [FilteringTextInputFormatter.allow( RegExp(r'(^[0-9a-zA-Z /*-_"()ñ]*$)'))],
                validator:  (value) {
              if (value!.isEmpty || value.trim()=="") {
                return 'Ingrese un nombre';
                }else{
                return validateName(value);
              }
              return null;

              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nombre de la Empresa",
                  errorMaxLines: 2,
              ),

            )),



              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    nombre.clear();
                    Navigator.of(context).pop();
              }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.nombre=nombre.text.trim();
                    guardarNombre(context);
                    //nombre.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],
            
          );
        }
    );
    
  }

  void mostrarFormDescripcionEmpresa() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               Form(
                  key:_formKeyDescripcion,
                 child: TextFormField(
                   keyboardType:TextInputType.multiline,
                   maxLines: 3,
                   maxLength: 800,
                   autofocus: true,
                   textAlign: TextAlign.justify,
                   controller: descripcion,
                   validator:  (value) {
                     if (value!.isEmpty || value.trim()=="") {
                       return 'Ingrese una descripción';
                     }else{
                       return validateDescripcion(value);
                     }
                     return null;

                   },
                   decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: "Descripción de la Empresa",
                       errorMaxLines: 2,

                   ),
                 ),
               ),
              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    descripcion.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.descripcion=descripcion.text.trim();
                    guardarDescripcion(context);

                    //descripcion.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );

  }

  void mostrarFormDescripcionCortaEmpresa() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                    key: _formKeyDescripcionCorta,
                    child:TextFormField(
                    keyboardType:TextInputType.text,
                    maxLength: 50,
                    autofocus: true,
                    controller: descripcionCorta,
                    validator:  (value) {
                      if (value!.isEmpty || value.trim()=="") {
                        return 'Ingrese una breve descripción';
                      }else{
                        return validateDescripcionCorta(value);
                      }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Breve descripción",
                errorMaxLines: 2,

                ),),),
              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    descripcionCorta.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.descripcion_corta=descripcionCorta.text.trim();
                    guardarDescripcionCorta(context);
                    //descripcionCorta.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );

  }
  void mostrarFormDireccionEmpresa() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKeyDireccion,
                  child:TextFormField(
                    keyboardType:TextInputType.streetAddress,
                    maxLength: 100,
                    autofocus: true,
                    controller: direccion,
                    validator:  (value) {
                      if (value!.isEmpty || value.trim()=="") {
                        return 'Ingrese una dirección';
                      }else{
                        return validateDireccion(value);
                      }
                      return null;

                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Dirección de la Empresa",
                        errorMaxLines: 2,
                    ),
                  ),
                ),

              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    direccion.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.direccion=direccion.text.trim();
                    guardarDireccion(context);
                   // direccion.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );

  }

  void mostrarFormTelefonoEmpresa() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key:_formKeyTelefono,
                  child: TextFormField(
                    keyboardType:TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.allow( RegExp(r'(^[0-9]*$)'))],
                    maxLength: 9,
                    autofocus: true,
                    controller: telefono,
                    validator:  (value) {
                      if (value!.isEmpty || value.trim()=="") {
                        return 'Ingrese un número de teléfono';
                      }else{
                        return validateTelefono(value);
                      }
                      return null;

                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Teléfono de la Empresa",
                      errorMaxLines: 2,
                    ),
                  ),
                ),

              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    telefono.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.telefono=telefono.text.trim();
                    guardarTelefono(context);
                    //telefono.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );

  }
  void mostrarFormWhatsAppEmpresa() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key:_formKeyWhatsApp,
                  child:TextFormField(
                    keyboardType:TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.allow( RegExp(r'(^[0-9]*$)'))],
                    maxLength: 10,
                    autofocus: true,
                    controller: whatsapp,
                    validator:  (value) {
                      if (value!.isEmpty || value.trim()=="") {
                        return 'Ingrese un número de celular';
                      }else{
                        return validateWhatsApp(value);
                      }
                      return null;

                    },
                    decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Número de celular",
                          errorMaxLines: 2,
                    ),
                  ),
                ),

              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    whatsapp.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.whatsapp=whatsapp.text.trim();
                    guardarWhatsApp(context);
                    //whatsapp.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );

  }

  void mostrarFormPaginaWebEmpresa() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key:_formKeyPaginaWeb,
                  child: TextFormField(
                    keyboardType:TextInputType.url,
                    maxLength: 200,
                    autofocus: true,
                    controller: paginaWeb,
                    validator:  (value) {
                      if (value!.isEmpty || value.trim()=="") {
                        return 'Ingrese el link de la Página Web';
                      }else{
                        return validatePaginaWeb(value);
                      }
                      return null;

                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Página Web",
                        errorMaxLines: 2
                    ),
                  ),
                ),

              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    paginaWeb.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.paginaWeb=paginaWeb.text.trim();
                    guardarPaginaWeb(context);
                    //paginaWeb.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );

  }

  void mostrarFormFacebook() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key:_formKeyFacebook,
                  child: TextFormField(
                    keyboardType:TextInputType.url,
                    maxLength: 50,
                    autofocus: true,
                    controller: facebook,
                    validator:  (value) {
                      if (value!.isEmpty || value.trim()=="") {
                        return 'Ingrese el link de la Página Web';
                      }else{
                        return validateRedSocial(value);
                      }
                      return null;

                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Facebook de la Empresa",
                        errorMaxLines: 2,
                    ),
                  ),
                ),

              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    facebook.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.facebook=facebook.text.trim();
                    guardarFacebook(context);
                    //facebook.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );

  }

  void mostrarFormInstagram() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key:_formKeyInstagram,
                  child:TextFormField(
                    keyboardType:TextInputType.url,
                    maxLength: 50,
                    autofocus: true,
                    controller: instagram,
                    validator:  (value) {
                    if (value!.isEmpty || value.trim()=="") {
                      return 'Ingrese el link de Instagram';
                    }else{
                      return validateRedSocial(value);
                    }
                    return null;

                  },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Instagram de la empresa",
                        errorMaxLines: 2,
                    ),
                  ),
                ),

              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    instagram.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.instagram=instagram.text.trim();
                    guardarInstagram(context);
                    //instagram.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );

  }
  void mostrarFormLatitud() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key:_formKeyLatitud,
                  child:TextFormField(
                    keyboardType:const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow( RegExp(r'(^[0-9.-]*$)'))],
                    maxLength: 12,
                    autofocus: true,
                    controller: latitud,
                    validator:  (value) {
                      if (value!.isEmpty || value.trim()=="") {
                        return 'Ingrese un valor de Latitud';
                      }else{
                        return validateLatitud(value);
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Latitud de la Ubicación",
                        errorMaxLines: 3,
                    ),
                  ),
                ),

              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    latitud.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.latitud=latitud.text.trim();
                    guardarLatitud(context);
                    //latitud.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );

  }

  void mostrarFormLongitud() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Editar") ,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key:_formKeyLongitud,
                  child:TextFormField(
                    keyboardType:const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow( RegExp(r'(^[0-9.-]*$)'))],
                    maxLength: 12,
                    autofocus: true,
                    controller: longitud,
                    validator:  (value) {
                      if (value!.isEmpty || value.trim()=="") {
                        return 'Ingrese un valor de Longitud';
                      }else{
                        return validateLongitud(value);
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Longitud de la ubicación",
                        errorMaxLines: 3,
                    ),

                  ),
                ),

              ],
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    longitud.clear();
                    Navigator.of(context).pop();
                  }, child: const Text("Cancelar")),

              TextButton(
                  onPressed: (){
                    em.longitud=longitud.text.trim();
                    guardarLongitud(context);
                    //longitud.clear();
                    //Navigator.of(context).pop();
                  }, child: const Text("Guardar")),
            ],

          );
        }
    );

  }
  //Alert Error
  void mostrarFormError() {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Error") ,
            content: const Text("Ha ocurrido un error inesperado") ,
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

int? validarFormNombre(){
    int bandera=0;
  if (_formKeyNombre.currentState!.validate()) {
    bandera=1;
    return bandera;
  }
}
  int? validarFormDescripcion(){
    int bandera=0;
    if (_formKeyDescripcion.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarFormDescripcionCorta(){
    int bandera=0;
    if (_formKeyDescripcionCorta.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarFormDireccion(){
    int bandera=0;
    if (_formKeyDireccion.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarFormTelefono(){
    int bandera=0;
    if (_formKeyTelefono.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarFormWhatsApp(){
    int bandera=0;
    if (_formKeyWhatsApp.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }

  int? validarFormPaginaWeb(){
    int bandera=0;
    if (_formKeyPaginaWeb.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarFormFacebook(){
    int bandera=0;
    if (_formKeyFacebook.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarFormInstagram(){
    int bandera=0;
    if (_formKeyInstagram.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarFormLatitud(){
    int bandera=0;
    if (_formKeyLatitud.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  int? validarFormLongitud(){
    int bandera=0;
    if (_formKeyLongitud.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }




  Future<void> guardarNombre(BuildContext context) async {
    if(validarFormNombre()==1){
      nombre.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog

      var data=json.encode(em.toJsonName());//Parsear a JSON desde el atributo de la clase empresa
      const String url = "$raizUrl""$modificarNombreEmpresa"; //Solicitud POST
      print(data+"cuerpo json");
      final res= await http.post(Uri.parse(url), body:data,
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},);//Envío de datos y cabecera

      if (res.statusCode == 200) {
        setState(() {});//Carga la página con los nuevos datos
        //  print(res.body);
        //  final Map<String, dynamic> responseData = jsonDecode(res.body);
        // final data = jsonDecode(res.body)[0] ;
        print('Se ha cambiado exitosamente');

      } else {
        throw Exception('Falló al cargar');
        //mostrarFormError();
        //print('Ha ocurrido un error inesperado');
      }

    }

  }

  Future<void> guardarDescripcion(BuildContext context) async {

    if(validarFormDescripcion()==1){
      descripcion.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog
      
      var data=json.encode(em.toJsonDescripcion());
      const String url = "$raizUrl""$modificarDescripcion";
      final res= await http.post(Uri.parse(url), body:data,
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
  
      );
        //print(res.body);
        if (res.statusCode == 200) {
          setState(() {});
          print('Se ha cambiado exitosamente');
        } else {
          throw Exception('Falló al cargar');
          //mostrarFormError();
          //print('Ha ocurrido un error inesperado');
        }
    }
  }
  Future<void> guardarDescripcionCorta(BuildContext context) async {
    if(validarFormDescripcionCorta()==1){
      descripcionCorta.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog

        var data=json.encode(em.toJsonDescripcionCorta());
        const String url = "$raizUrl$modificarDescripcionCorta";
        final res= await http.post(Uri.parse(url), body:data,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},

        );
        //print(res.body);
        if (res.statusCode == 200) {
          setState(() {});
          print('Se ha cambiado exitosamente');
        } else {
          throw Exception('Falló al cargar');
          //mostrarFormError();
          //print('Ha ocurrido un error inesperado');
        }
    }
  }

  Future<void> guardarDireccion(BuildContext context) async {
    if(validarFormDireccion()==1){
      direccion.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog

        var data=json.encode(em.toJsonDireccion());
        const String url = "$raizUrl$modificarDireccion";
        final res= await http.post(Uri.parse(url), body:data,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        );
       // print(res.body);
        if (res.statusCode == 200) {
          setState(() {});
          print('Se ha cambiado exitosamente');
        } else {
          throw Exception('Falló al cargar');
          //mostrarFormError();
          //print('Ha ocurrido un error inesperado');
        }
    }
  }
  Future<void> guardarTelefono(BuildContext context) async {
    if(validarFormTelefono()==1){
      telefono.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog

          var data=json.encode(em.toJsonTelefono());
          const String url = "$raizUrl$modificarTelefono";
          final res= await http.post(Uri.parse(url), body:data,
            headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          );
          //print(res.body);
          if (res.statusCode == 200) {
            setState(() {});
            print('Se ha cambiado exitosamente');
          } else {
            throw Exception('Falló al cargar');
            //mostrarFormError();
            //print('Ha ocurrido un error inesperado');
          }
    }
  }
  Future<void> guardarWhatsApp(BuildContext context) async {

    if(validarFormWhatsApp()==1){
      whatsapp.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog

      var data=json.encode(em.toJsonWhatsApp());
      const String url = "$raizUrl$modificarWhatsApp";
      final res= await http.post(Uri.parse(url), body:data,
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
    );
    //print(res.body);
    if (res.statusCode == 200) {
      setState(() {});
      print('Se ha cambiado exitosamente');
    } else {
      throw Exception('Falló al cargar');
      //mostrarFormError();
     // print('Ha ocurrido un error inesperado');
    }
    }
  }
  Future<void> guardarPaginaWeb(BuildContext context) async {
    if(validarFormPaginaWeb()==1){
      paginaWeb.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog

          var data=json.encode(em.toJsonPaginaWeb());
          const String url = "$raizUrl$modificarPaginaWeb";
          final res= await http.post(Uri.parse(url), body:data,
            headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          );
          //print(res.body);
          if (res.statusCode == 200) {
            setState(() {});

            print('Se ha cambiado exitosamente');
          } else {
            //mostrarFormError();
            //print('Ha ocurrido un error inesperado');
            throw Exception('Falló al cargar');
          }
    }
  }

  Future<void> guardarFacebook(BuildContext context) async {
    if(validarFormFacebook()==1){
      facebook.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog

        var data=json.encode(em.toJsonFacebook());
        const String url = "$raizUrl$modificarFacebook";
        final res= await http.post(Uri.parse(url), body:data,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        );
        //print(res.body);
        if (res.statusCode == 200) {
          setState(() {});

          print('Se ha cambiado exitosamente');
        } else {
          //mostrarFormError();
         // print('Ha ocurrido un error inesperado');
          throw Exception('Falló al cargar');
        }
    }
  }
  Future<void> guardarInstagram(BuildContext context) async {
    if(validarFormInstagram()==1){
      instagram.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog

          var data=json.encode(em.toJsonInstagram());
          const String url = "$raizUrl$modificarInstagram";
          final res= await http.post(Uri.parse(url), body:data,
            headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          );
          //print(res.body);
          if (res.statusCode == 200) {
            setState(() {});
            print('Se ha cambiado exitosamente');
          } else {
            //mostrarFormError();
            throw Exception('Falló al cargar');
            //print('Ha ocurrido un error inesperado');
          }
    }
  }
  Future<void> guardarLatitud(BuildContext context) async {
    if(validarFormLatitud()==1){
      latitud.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog

        var data=json.encode(em.toJsonLatitud());
        const String url = "$raizUrl$modificarLatitud";
        final res= await http.post(Uri.parse(url), body:data,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        );
        //print(res.body);
        if (res.statusCode == 200) {
          setState(() {});

          print('Se ha cambiado exitosamente');
        } else {
          //mostrarFormError();
          throw Exception('Falló al cargar');
         // print('Ha ocurrido un error inesperado');
        }
    }
  }
  Future<void> guardarLongitud(BuildContext context) async {
    if(validarFormLongitud()==1){
      longitud.clear(); //Limpiar el controlador de texto
      Navigator.of(context).pop(); //Cerrar el AlertDialog

          var data=json.encode(em.toJsonLongitud());
          const String url = "$raizUrl$modificarLongitud";
          final res= await http.post(Uri.parse(url), body:data,
            headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          );
          //print(res.body);
          if (res.statusCode == 200) {
            setState(() {});
            print('Se ha cambiado exitosamente');
          } else {
            throw Exception('Falló al cargar');
            //mostrarFormError();
            //print('Ha ocurrido un error');
          }
    }
  }


  String? validateName(String value) {
   String pattern = r'(^[a-zA-Z0-9 (/,.*-_)ñÑáéíóúÁÉÍÓÚ&]*$)';
                RegExp regExp = new RegExp(pattern);
                if (!regExp.hasMatch(value)) {
                  // bandera=5;// si no está en ese rango
                  return "El nombre solo puede contener [0-9],[A-Z],[a-z],[&/*-,._"+ "( "+")"+"]";
                }

        }
  String? validateDescripcion(String value) {
    String pattern = r'(^[a-zA-Z0-9 ?¿(/,.*-_)ñÑáéíóúÁÉÍÓÚ&]*$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      // bandera=5;// si no está en ese rango
      return "La descripción solo puede contener [0-9],[A-Z],[a-z],[&/*-,._"+ "( "+")"+"]";
    }

  }
  String? validateDescripcionCorta(String value) {
    String pattern = r'(^[a-zA-Z0-9 ?¿(/,.*-_)ñÑáéíóúÁÉÍÓÚ&]*$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      // bandera=5;// si no está en ese rango
      return "La descripción solo puede contener [0-9],[A-Z],[a-z],[&/*-,._"+ "( "+")"+"]";
    }

  }
  String? validateDireccion(String value) {
    String pattern = r'(^[a-zA-Z0-9 ?¿(/,.*-_)ñÑáéíóúÁÉÍÓÚ&]*$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      // bandera=5;// si no está en ese rango
      return "La dirección solo puede contener [0-9],[A-Z],[a-z],[&/*-,._"+ "( "+")"+"]";
    }

  }
  String? validateTelefono(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      // bandera=5;// si no está en ese rango
      return "El número de teléfono solo puede contener [0-9]";
    }

  }


  String? validateWhatsApp(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      // bandera=5;// si no está en ese rango
      return "El número de celular solo puede contener [0-9]";
    }

  }
  String? validatePaginaWeb(String value) {
    String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = new RegExp(pattern);
   // bool isURLValid = Uri.parse(value).host.isNotEmpty;//V
    //!regExp.hasMatch(value)||
    if (!regExp.hasMatch(value) ) {
      return "Ingrese un link válido: https://www.example.com";
    }
  }
  String? validateRedSocial(String value) {
    String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value) ) {
      return "Ingrese un link válido: https://www.example.com";
    }
  }
  String? validateLatitud(String value) {
    String pattern = r'(^(\+|-)?(?:90(?:(?:\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,6})?))$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value) ) {
      return "Valor o formato incorrecto. Caracteres permitidos: [0-9]&[.]&[-]";
    }
  }
  String? validateLongitud(String value) {
    String pattern = r'(^(\+|-)?(?:180(?:(?:\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,6})?))$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value) ) {
      return "Valor o formato incorrecto. Caracteres permitidos: [0-9]&[.]&[-]";
    }
  }

}



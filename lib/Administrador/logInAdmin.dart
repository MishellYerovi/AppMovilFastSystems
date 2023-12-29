import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

import '../constantes/const.dart';




class logInAdmin extends StatefulWidget {
  const logInAdmin({super.key});

  @override
  State<logInAdmin> createState() => _logInAdminState();
}

class _logInAdminState extends State<logInAdmin> {
  Map userData = {};
  Hash hasher=sha512;
  //Claves de los Formularios
  final _formkeyEmailAndPassword = GlobalKey<FormState>();

  //Controladores
  final emailUser=TextEditingController();
  final passwordUser=TextEditingController();
  bool error = false;

  @override
  void initState() {

    super.initState();
    verificarLogIn();
    //showStatusBar();
  }

  void verificarLogIn () async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val= pref.getString("email");
    if(val!=null)
      {
      //  Navigator.of(context).pushAndRemoveUntil(menuAdministrador() as Route<Object?>, (route) => false);
        //context.goNamed("HomeAdminMenu");
       // context.pushNamed("HomeAdminMenu");
        context.pushReplacementNamed("HomeAdminMenu");
        //context.goNamed("HomeAdminMenu");
      }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white54,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
              )),
          centerTitle: true,
          title: Text("Iniciar Sesión",
            style: TextStyle(
            fontWeight: FontWeight.bold,
          ),  textAlign: TextAlign.center,),
          //toolbarHeight: 2,
          elevation: 3,
          shadowColor: Colors.lightBlue,
          backgroundColor: Colors.lightBlueAccent,
        ),
        body:
        Center(

          child:
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 65),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Container(
                        //color:Colors.white,
                        padding: EdgeInsets.all(10),
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blueGrey)
                        ),
                      child: Image.asset('assets/icon.png', fit: BoxFit.fill),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: _formkeyEmailAndPassword,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextFormField(
                                      keyboardType:TextInputType.emailAddress,
                                      autofocus: false,
                                      //maxLength: 80,
                                      controller: emailUser,
                                      //inputFormatters: [FilteringTextInputFormatter.allow( RegExp("[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*@[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,5}?"))],
                                      validator:  (value) {
                                      if (value!.isEmpty || value.trim()=="") {
                                        _formkeyEmailAndPassword.currentState?.reset();
                                       // emailUser.clear();
                                      return 'Ingrese el correo electrónico';
                                      }else{

                                      return validateEmail(value);
                                      }},
                                      onChanged:  (value) {
                                        value!.length==0?
                                        _formkeyEmailAndPassword.currentState?.reset():null;
                                      },

                                      decoration:   InputDecoration(
                                          hintText: 'Correo Electrónico',
                                          labelText: 'Correo Electrónico',
                                          errorMaxLines: 2,
                                          prefixIcon: Icon(
                                            Icons.email,
                                            //color: Colors.green,
                                          ),
                                          errorStyle:TextStyle(fontSize: 14.0),
                                          border: OutlineInputBorder(
                                              //borderSide: BorderSide(color: Colors.transparent),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(9.0)))
                                            )
                                        )),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  keyboardType:TextInputType.visiblePassword,
                                  //maxLength:16 ,
                                  autofocus: false,
                                  obscureText: true,
                                  controller: passwordUser,
                                  decoration: InputDecoration(
                                    errorMaxLines: 2,
                                    hintText: 'Contraseña',
                                    labelText: 'Contraseña',

                                    prefixIcon: Icon(
                                      Icons.key,
                                      color: Colors.green,
                                    ),
                                    errorStyle: TextStyle(fontSize: 14.0),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(9.0))),
                                  ),
                                  onChanged:  (value) {
                                    value!.length==0?
                                        passwordUser.clear():null;
                                    //_formkeyEmailAndPassword.currentState?.reset():null;
                                  },
                                  validator:  (value) {
                                    if (value!.isEmpty || value.trim()=="") {
                                      //_formkeyEmailAndPassword.currentState?.reset();
                                      passwordUser.clear();
                                      return 'Ingrese la contraseña';
                                    }else{
                                      return null;

                                      //return validatePassword(value);
                                    }},
                                ),
                              ),
                            /*  Container( //Olvidó la contraseña
                                margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                child: Text('Forget Password!'),
                              ),*/
                              Padding(
                                padding: const EdgeInsets.fromLTRB(50,20,50,70),
                                child: Container(
                                  child: ElevatedButton(
                                    child: Text(
                                      'Ingresar',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {

                                     // if( iniciarSesion()==1){
                                      iniciarSesion();
                                        //context.goNamed("HomeAdminMenu");
                                        //iniciarSesion();
                                     // }
                                    },
                                    style: ElevatedButton.styleFrom( backgroundColor: Colors.indigoAccent,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                ),
                              ),

                              /*ElevatedButton(
                                onPressed: () {
                                  context.goNamed("HomeAdminMenu");
                                  //Navigator.push( context, MaterialPageRoute(builder: (context) =>menu_configuraciones()),);

                                },
                                style: ElevatedButton.styleFrom(fixedSize: const Size(160, 160), backgroundColor:Colors.lightBlueAccent,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                    SizedBox(
                                      width:10,
                                      // height: 50,
                                    ),
                                    //Text("Menú", style:TextStyle(fontSize:14, color:Colors.white), textAlign: TextAlign.center ),
                                  ],
                                ),
                              ),*/
                             /* Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  child: Center(
                                    child: Text(
                                      'Or Sign In Using!',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),*/
                              /*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 40,
                                            width: 40,
                                            child: Image.asset(
                                              'assets/social.jpg',
                                              fit: BoxFit.cover,
                                            )),
                                        Container(
                                          height: 70,
                                          width: 70,
                                          child: Image.asset(
                                            'assets/vishal.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          child: Image.asset(
                                            'assets/google.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),*/
                             /* Center(
                                child: Container(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Text(
                                    'SIGN UP!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                              )*/
                            ]),
                      )),
                ),
              ],
            ),
          ),

          /*child: ElevatedButton(
          onPressed: () {
            context.goNamed("HomeAdminMenu");
            //Navigator.push( context, MaterialPageRoute(builder: (context) =>menu_configuraciones()),);

          },
          style: ElevatedButton.styleFrom(fixedSize: const Size(160, 160), backgroundColor:Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Icon(
                Icons.menu,
                color: Colors.white,
                size: 50.0,
              ),
              SizedBox(
                width:10,
                // height: 50,
              ),
              //Text("Menú", style:TextStyle(fontSize:14, color:Colors.white), textAlign: TextAlign.center ),
            ],
          ),
        ),*/
    ),
    );

  }
    String? validateEmail(String value) {
    String pattern = "^[a-z0-9!#%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value) ) {
              return "Ingrese un correo válido: user@example.com";
          }
    }

  /*String? validatePassword(String value) {

    String pattern = "/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,16}?/";
    RegExp regExp = new RegExp(pattern);
    // bool isURLValid = Uri.parse(value).host.isNotEmpty;//V
    //!regExp.hasMatch(value)||

    if (!regExp.hasMatch(value) ) {

      return "Ingrese una contraseña que contenga: ";

    }
    else{

    }
  }*/

  int? validarFormEmail(){
    int bandera=0;
    if (_formkeyEmailAndPassword.currentState!.validate()) {
      bandera=1;
      return bandera;
    }
  }
  mostrarUsuarioContraseniaIncorrectos ()
  {
    showDialog(context: context,
        builder: (context){
          return  AlertDialog(
            title:const Text("Usuario o contraseña incorrectos") ,
            icon: Icon(Icons.dangerous_sharp,color: Colors.red,size:50,),
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

  Future<void> iniciarSesion() async {
    int bandera=0;
    if(validarFormEmail()==1){
      var email=emailUser.text.toString().trim();
      var passwordA=passwordUser.text.toString().trim();

      //var cript=hasher.startChunkedConversion(password as Sink<Digest>);

     // print("cript1"+ cript.toString());
     // Hash temporal=hasher.bind(password);
     // var value = hasher.bind(password as Stream<List<int>>);
      //print("cript2$value");
     // hasher=512.

      final bytes = utf8.encode(passwordA); // data being hashed
      final passwordDigest = sha512.convert(bytes);
      final hexPasswordDigest=passwordDigest.toString();
      //print("encriptado:"+hexPasswordDigest.toString());
      //print(email);
      //print(password);
      var verificarAdminUrl = Uri.parse('$raizUrl'"$verificarCredencialesAdministrador");

      //context.goNamed("HomeAdminMenu");
      try{
      var response = await http.post(
        verificarAdminUrl,
        body: {
          'email': email,
          'password': hexPasswordDigest
        },
      );
      //print(response.body);
      if(response.statusCode == 200){
        print("hola2"+response.body);
        var jsondata = json.decode(response.body);
        if(jsondata["noAdmin"]){
          print(jsondata["msg"]);
          bandera=0;
          mostrarUsuarioContraseniaIncorrectos ();
          emailUser.clear();
          passwordUser.clear();
          //_formkeyEmailAndPassword.currentState?.reset();
        }else{
          if(jsondata["Admin"]){
            print(jsondata["msg"].toString());
            bandera=1;
            //prueba-----------
            /*SharedPreferences prefs = await SharedPreferences.getInstance();
            //sharedpreferences.getinstance()
            prefs.setBool("isloggedin", true);*/
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', email);
            prefs.setString('contrasenia', hexPasswordDigest as String);
            //-----------------

            context.pushReplacementNamed("HomeAdminMenu");
            //context.goNamed("HomeAdminMenu");
           // AppNavigation(bandera);

            //Cerrar sesión
            /*sharedpreferences sharedpreference = await sharedpreferences.getinstance();
            keys.remove("isloggedin");*/
          }

        }

      }

    } catch(e){
    print("Error en el servidor"+e.toString());
    }
    }
   // return bandera;
  }

}
//log in
/*SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('email', email);
context.pushReplacementNamed("HomeAdminMenu");
*/





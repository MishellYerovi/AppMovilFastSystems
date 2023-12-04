import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class menuAdministrador extends StatefulWidget {
  const menuAdministrador({super.key});

  @override
  State<menuAdministrador> createState() => _menuAdministradorState();
}

class _menuAdministradorState extends State<menuAdministrador> {
late String email="";
  @override
  void initState() {

    super.initState();
    getCredenciales();
  }

  void getCredenciales( ) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      email=pref.getString("email")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Menú Administrador" ),
        elevation: 3,
       // automaticallyImplyLeading: false,
        shadowColor: Colors.lightBlue,
        backgroundColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
        actions:[
          PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("My Account"),
                  ),

                  /* PopupMenuItem<int>(
                      value: 1,
                      child: Text("Settings"),
                    ),*/
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("Cerrar sesión"),
                  ),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  print("Mi cuenta");
                }else if(value == 1){
                  cerrarSesion();
                 // print("Cerrar sesión");

                }/*else if(value == 2){
                    print("Logout menu is selected.");
                  }*/
              }
          ),

        ],
      ),
        body:SizedBox(
          width: double.infinity,
          height: double.infinity,
    child: SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(5, 10, 5, 80),
    child: Column(

    mainAxisAlignment: MainAxisAlignment.center,
    children:  [
      Text("Bienvenid@ $email"),
      Card(
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20,20 ),
          leading: const Icon(Icons.business_rounded, color:Colors.black45),
          title: const Text("Datos de la empresa"),
          subtitle: Text("Nombre, Descripción, Dirección... "),
          trailing: IconButton(onPressed: ()
          {
           // context.goNamed("HomeEditarInfoEmpresa");
            context.pushNamed("HomeEditarInfoEmpresa");
          },
            icon: const Icon(Icons.arrow_forward_ios_outlined ),
            color: Colors.lightBlueAccent,
            disabledColor: Colors.indigoAccent,
            focusColor: Colors.indigoAccent,
            highlightColor: Colors.indigoAccent,
            hoverColor: Colors.indigoAccent,
            splashColor: Colors.indigoAccent,

          ),
        ),
      ),

      Card(
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20,20 ),
          leading: const Icon(Icons.business_rounded, color:Colors.black45),
          title: const Text("Noticias/Carousel"),
          subtitle: Text("Agregar noticias"),
          trailing: IconButton(onPressed: ()
          {
            context.pushNamed("HomeGuardarNoticias");
            //mostrarFormNombreEmpresa();

          },
            icon: const Icon(Icons.arrow_forward_ios_outlined ),
            color: Colors.lightBlueAccent,
            disabledColor: Colors.indigoAccent,
            focusColor: Colors.indigoAccent,
            highlightColor: Colors.indigoAccent,
            hoverColor: Colors.indigoAccent,
            splashColor: Colors.indigoAccent,

          ),
        ),
      ),
      Card(
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20,20 ),
          leading: const Icon(Icons.business_rounded, color:Colors.black45),
          title: const Text("Imágenes del Carousel"),
          subtitle: Text("Eliminar"),
          trailing: IconButton(onPressed: ()
          {
            context.pushNamed("HomeListarNoticias");
            //mostrarFormNombreEmpresa();

          },
            icon: const Icon(Icons.arrow_forward_ios_outlined ),
            color: Colors.lightBlueAccent,
            disabledColor: Colors.indigoAccent,
            focusColor: Colors.indigoAccent,
            highlightColor: Colors.indigoAccent,
            hoverColor: Colors.indigoAccent,
            splashColor: Colors.indigoAccent,

          ),
        ),
      ),
      Card(
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20,20 ),
          leading: const Icon(Icons.business_rounded, color:Colors.black45),
          title: const Text("Administradores"),
          subtitle: Text("Editar/Eliminar"),
          trailing: IconButton(onPressed: ()
          {
            context.pushNamed("HomeListarAdministradores");
            //mostrarFormNombreEmpresa();

          },
            icon: const Icon(Icons.arrow_forward_ios_outlined ),
            color: Colors.lightBlueAccent,
            disabledColor: Colors.indigoAccent,
            focusColor: Colors.indigoAccent,
            highlightColor: Colors.indigoAccent,
            hoverColor: Colors.indigoAccent,
            splashColor: Colors.indigoAccent,

          ),
        ),
      ),
      ]), ),
        ),
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

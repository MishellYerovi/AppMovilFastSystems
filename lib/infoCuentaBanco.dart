

import 'package:fastsystems_app2/Modelo/infoCuentaBanco.dart';
import 'package:fastsystems_app2/constantes/const.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class cInfoCuentaBanco extends StatefulWidget {
  const cInfoCuentaBanco({super.key});
  @override
  State<cInfoCuentaBanco> createState() => _cInfoCuentaBancoState();
}

class _cInfoCuentaBancoState extends State<cInfoCuentaBanco> {
  late Future <List<InfoPagosBancos>> futureInfoPagosBancos;
  var data2;
  @override
  void initState() {
    super.initState();
    futureInfoPagosBancos=fetchInfoBanco();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white54,
      appBar: AppBar(
        clipBehavior: Clip.none,
        shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
        centerTitle: true,
        title: Text("Medios de Pago",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),  textAlign: TextAlign.center,),
        //toolbarHeight: 2,
        elevation: 3,
        shadowColor: Colors.lightBlue,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:
      Scrollbar(

        radius: const Radius.circular(50),
    trackVisibility: true,
    child: SingleChildScrollView(
      clipBehavior: Clip.none,
    padding: const EdgeInsets.fromLTRB(5, 5,5, 80),
    child:
      Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.0),
            /*Image(

              image: AssetImage('assets/icon.png'),
              fit: BoxFit.fitHeight,
              height: 50,
            ),*/
           // SizedBox(height: 8.0),
            //Text("Medios de Pago",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo),),
            //SizedBox(height: 10.0),

            Container(
              clipBehavior: Clip.none,
                decoration: BoxDecoration(

                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12) ),
                padding: const EdgeInsets.fromLTRB(30, 10,30,10),
                child: FutureBuilder(
                  future:  fetchInfoBanco(),
                  builder: (BuildContext context,snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) { //Este estado indica que el futuro se está resolviendo actualmente y recibiremos el resultado en breve.
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
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
                        data2 = snapshot.data;
                        //print("longitud future" +data!.length.toString());
                        //em.id=data!.id.toString();
                        return
                          data?.length != 0?
                          Container(
                            //height: 240,
                            clipBehavior: Clip.none,
                                  child:ListView(
                                    clipBehavior: Clip.none,
                                    padding: const EdgeInsets.all(1),
                                    shrinkWrap: true,
                                    children:
                                    //  Padding(padding:EdgeInsets.all(8.0)), //Espacio
                                    _listInfoBancos(data!),

                                  ))
                              : Container(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center, child:const Text("No existe información")
                          );
                      }
                    }
                    return const Center(

                      child: CircularProgressIndicator(

                        semanticsLabel: "Cargando...",
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    );
                  },) ),

            SizedBox(height: 10.0),
            ElevatedButton.icon(
              clipBehavior: Clip.none,
              onPressed: (){
               //print(data2[0].toString());
                enviarComprobante();
              },
              style: ElevatedButton.styleFrom( backgroundColor:Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              icon: const Icon(Icons.message),
              label: const Text("Enviar comprobante"),
            )
          ],

        ),
      ),),),
    );
  }

  List<Widget>_listInfoBancos(data) {

    List<Widget> infoPagos=[];
    //print("tamaño"+data.length.toString());
    for(var admin in data)
    {
      infoPagos.add(
        Card(
          clipBehavior: Clip.none,
          //margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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

                title: Text(admin.nombreBanco,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                subtitle:
                /*Align(
                  alignment: Alignment.topLeft,
               child: */
               Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(admin.tipoCuenta,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15),),
                      RichText(  text: TextSpan (
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(text: "Num. de cuenta: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
                          TextSpan(text: admin.numCuenta, style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18),),
                        ],),
                       ),

                      RichText(  text: TextSpan (
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(text: "Nombre: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
                          TextSpan(text: admin.nombrePropietario, style: TextStyle(fontSize: 18),),
                        ],),
                      ),
                      RichText(  text: TextSpan (
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(text: "C.I.: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
                          TextSpan(text: admin.cedula, style: TextStyle(fontSize: 18),),
                        ],),
                      ),
                      RichText(  text: TextSpan (
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(text: "Correo electrónico: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
                          TextSpan(text: admin.emailPropietario, style: TextStyle(fontSize: 18),),
                        ],),
                      ),

                      //Text("# de cuenta"+admin.tipoCuenta,style: TextStyle(fontStyle: FontStyle.italic),),
                     // Text(admin.numCuenta),
                     // Text(admin.nombrePropietario),
                     // Text(admin.cedula),
                     // Text(admin.emailPropietario),
                      //Text(admin.descripcion),
                      RichText(  text: TextSpan (
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(text: "Nota: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
                          TextSpan(text: admin.descripcion, style: TextStyle(fontSize: 18),),
                        ],),
                      ),
                      Row( children:[
                        Image(
                          //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                          image: AssetImage('assets/whatsapp2.png'),
                          fit: BoxFit.fitHeight,
                          height: 30,
                        ),
                        InkWell(child: Text("$celular", style: TextStyle(decoration: TextDecoration.underline,decorationColor: Colors.green,color: Colors.black)),
                          onTap:() {
                            enviarComprobante();
                          }, ),
                      ]

                      ),

                      //Text(admin.descripcion),
                       ]),
              //),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                  /*  IconButton(onPressed: () {

                      //editarFormAdmin(admin.id, admin.nombreAdmin, admin.emailAdmin);
                    }, icon: const Icon(Icons.send, color:Colors.green)),*/
                    /*IconButton(onPressed: () {
                      //alertDeseaEliminar(admin.id, admin.nombreAdmin, admin.emailAdmin);
                    }, icon: const Icon(Icons.delete, color: Colors.red,)),*/
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
    return infoPagos;

  }

  void enviarComprobante() async{
      final link = WhatsAppUnilink(
        phoneNumber: '+593-'"$celular",
        text: "Envío el comprobante de Pago",
      );
      // Convert the WhatsAppUnilink instance to a Uri.
      // The "launch" method is part of "url_launcher".
      await launchUrlString("$link");
  }

}

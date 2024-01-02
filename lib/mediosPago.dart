import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'constantes/const.dart';

class cMediosPago extends StatefulWidget {
  const cMediosPago({super.key});

  @override
  State<cMediosPago> createState() => _cMediosPagoState();
}

class _cMediosPagoState extends State<cMediosPago> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      //primary: true,
     // backgroundColor: Colors.transparent,
      appBar: AppBar(
       // clipBehavior: Clip.none,
        //color
        //foregroundColor: Colors.red,
        //surfaceTintColor: Colors.red,
        shape: const RoundedRectangleBorder(

            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
        centerTitle: true,
        title: const Text("Medios de Pago",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),  textAlign: TextAlign.center,),
        //toolbarHeight: 2,
        elevation: 3,
        shadowColor: Colors.lightBlue,
        backgroundColor: Colors.lightBlueAccent,

      ),
      body:
      ListView(
        padding: const EdgeInsets.fromLTRB(20, 100,20, 100),
       children:[
      SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),

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

                        title: const Text("Banco Pichincha",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                        subtitle:
                        /*Align(
                  alignment: Alignment.topLeft,
               child: */
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Cuenta de Ahorros",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15),),
                                SelectableText.rich(  TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                               TextSpan(text: "Num. de cuenta: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text:"2203462289", style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16),),
                                ],),

                              ),

                              SelectableText.rich(  TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "Nombre: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text:"Juan Carlos Ricachi", style: TextStyle(fontSize: 16),),
                                ],),

                              ),
                              SelectableText.rich(  TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "C.I.: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text: "170773307-8", style: TextStyle(fontSize: 16),),
                                ],),

                              ),
                              SelectableText.rich( TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "Correo electrónico: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text: "juank_1820@hotmail.com", style: TextStyle(fontSize: 16),),
                                ],),
                              ),

                              SelectableText.rich( TextSpan (

                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "Nota: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                  TextSpan(text: "Una vez realizado el depósito o transferencia, "
                                      "enviar el comprobante para registrar el pago al WhatsApp.", style: TextStyle(fontSize: 16),),
                                ],),
                                textAlign: TextAlign.justify,
                              ),
                              Row( children:[
                                const Image(
                                  //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                                  image: AssetImage('assets/whatsapp2.png'),
                                  fit: BoxFit.fitHeight,
                                  height: 30,
                                ),
                                InkWell(child: const Text("$celular", style: TextStyle(decoration: TextDecoration.underline,decorationColor: Colors.green,color: Colors.black)),
                                  onTap:() {
                                    enviarComprobante();
                                  }, ),
                              ]

                              ),

                              //Text(admin.descripcion),
                            ]),
                        //),

                      ),


                      const Padding(padding:EdgeInsets.all(2.0) ), //ESPACIO
                    ],
                  ),
                ),

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

                        title: const Text("Banco Pichincha",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                        subtitle:
                        /*Align(
                  alignment: Alignment.topLeft,
               child: */
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Cuenta de Ahorros",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15),),
                              SelectableText.rich(  TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                   TextSpan(text: "Num. de cuenta: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                   TextSpan(text:"2203462289", style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16),),
                                ],),

                              ),

                              SelectableText.rich(  TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "Nombre: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text:"Juan Carlos Ricachi", style: TextStyle(fontSize: 16),),
                                ],),

                              ),
                              SelectableText.rich(  TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children:const <TextSpan>[
                                  TextSpan(text: "C.I.: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text: "170773307-8", style: TextStyle(fontSize: 16),),
                                ],),

                              ),
                              SelectableText.rich( TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "Correo electrónico: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text: "juank_1820@hotmail.com", style: TextStyle(fontSize: 16),),
                                ],),
                              ),

                              SelectableText.rich( TextSpan (

                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "Nota: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                  TextSpan(text: "Una vez realizado el depósito o transferencia, "
                                      "enviar el comprobante para registrar el pago al WhatsApp.", style: TextStyle(fontSize: 16),),
                                ],),
                                textAlign: TextAlign.justify,
                              ),
                              Row( children:[
                                const Image(
                                  //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                                  image: AssetImage('assets/whatsapp2.png'),
                                  fit: BoxFit.fitHeight,
                                  height: 30,
                                ),
                                InkWell(child: const Text("$celular", style: TextStyle(decoration: TextDecoration.underline,decorationColor: Colors.green,color: Colors.black)),
                                  onTap:() {
                                    enviarComprobante();
                                  }, ),
                              ]

                              ),

                              //Text(admin.descripcion),
                            ]),
                        //),

                      ),


                      const Padding(padding:EdgeInsets.all(2.0) ), //ESPACIO
                    ],
                  ),
                ),
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

                        title: const Text("Banco Pichincha",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                        subtitle:
                        /*Align(
                  alignment: Alignment.topLeft,
               child: */
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Cuenta de Ahorros",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15),),
                              SelectableText.rich(  TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "Num. de cuenta: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text:"2203462289", style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16),),
                                ],),

                              ),

                              SelectableText.rich(  TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "Nombre: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text:"Juan Carlos Ricachi", style: TextStyle(fontSize: 16),),
                                ],),

                              ),
                              SelectableText.rich(  TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "C.I.: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text: "170773307-8", style: TextStyle(fontSize: 16),),
                                ],),

                              ),
                              SelectableText.rich( TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "Correo electrónico: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                                  TextSpan(text: "juank_1820@hotmail.com", style: TextStyle(fontSize: 16),),
                                ],),
                              ),

                              SelectableText.rich( TextSpan (

                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: "Nota: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                  TextSpan(text: "Una vez realizado el depósito o transferencia, "
                                      "enviar el comprobante para registrar el pago al WhatsApp.", style: TextStyle(fontSize: 16),),
                                ],),
                                textAlign: TextAlign.justify,
                              ),
                              Row( children:[
                                const Image(
                                  //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                                  image:  AssetImage('assets/whatsapp2.png'),
                                  fit: BoxFit.fitHeight,
                                  height: 30,
                                ),
                                InkWell(child: const Text("$celular", style: TextStyle(decoration: TextDecoration.underline,decorationColor: Colors.green,color: Colors.black)),
                                  onTap:() {
                                    enviarComprobante();
                                  }, ),
                              ]

                              ),

                              //Text(admin.descripcion),
                            ]),
                        //),

                      ),


                      const Padding(padding:EdgeInsets.all(2.0) ), //ESPACIO
                    ],
                  ),
                ),


                const SizedBox(height: 10.0),
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
          ) ],
    ),
    );
  }

  void enviarComprobante() async{
    final link = WhatsAppUnilink(
      // phoneNumber: '+593-'"$celular",
      phoneNumber:"$code$celular",
      text: "Envío el comprobante de Pago",
    );
    // Convert the WhatsAppUnilink instance to a Uri.
    // The "launch" method is part of "url_launcher".
    await launchUrlString("$link");
  }
}

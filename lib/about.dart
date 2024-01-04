

import 'package:flutter/material.dart';

import 'Modelo/empresa.dart';
import 'constantes/const.dart';



class AboutInfo extends StatefulWidget {
  const AboutInfo({super.key});
  @override
  State<AboutInfo> createState() => _AboutInfoState();
}

class _AboutInfoState extends State<AboutInfo> {
  //Variables para Refrescar la página
  var list;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  //----------------------------------------

  late Future<Empresa> futureEmpresa;

  @override
  void initState() {
    super.initState();
    futureEmpresa = fetchEmpresa();
   // random = Random();
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBody: true,
        //backgroundColor:Colors.grey.shade200,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:
        Text('Sobre nosotros',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 3,
        shape: const RoundedRectangleBorder(

            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:
    list == null
    ? RefreshIndicator(
      key: refreshKey,
      onRefresh: refreshList,
        child:
            ListView(

              children: <Widget>[

            SizedBox(
               // width: double.infinity,
              //height: double.infinity,

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
              Card(
                  color: Colors.white,
                  elevation: 2,
                  shadowColor: Colors.lightBlueAccent,
                //margin: EdgeInsets.all(20),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),),

                  child:Container(
                    padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //SizedBox(height: 30.0),
                          Image(
                            image: AssetImage('assets/logos/logo2.png'),
                            fit: BoxFit.fitHeight,
                            height:40,
                            width: 250,
                          ),
                         // SizedBox(height: 3.0),
                         /* Text("FastSystems",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                              color: Colors.blue),),*/

                        ],
                      ),
                    ), ),
                  Card(
                    color: Colors.white,
                    elevation: 10,
                    shadowColor: Colors.lightBlueAccent,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),),

                    margin: EdgeInsets.all(20),
                    child :Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(20),
                    child:

                    Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/misionandvision/mision.jpg'),
                            fit: BoxFit.fitHeight,
                            height:200,
                          ),
                          Text("Misión",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),textAlign: TextAlign.center,),
                         /* SelectableText.rich(  TextSpan (
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              const TextSpan(text: "text ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16), ),
                              TextSpan(text:"text", style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16),),
                            ],),

                          ),*/



                          SelectableText.rich( TextSpan (

                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                            //  const TextSpan(text: "Nota: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                              TextSpan(text: "Ser una empresa líder que se desarrolle en "
                                  "forma armónica y sustentable, teniendo como eje principal "
                                  "una actividad de servicio de Internet a domicilio de alto impacto "
                                  "en el desarrollo económico y cultural de nuestra sociedad y fomentar "
                                  "el desarrollo de las telecomunicaciones del país. Brindar excelencia en "
                                  "la comunicación de datos a través de tecnología de punta, con talento humano "
                                  "comprometido y servicio de calidad que superen las expectativas de valor de "
                                  "nuestros clientes.", style: TextStyle(fontSize: 16),),
                            ],),
                            textAlign: TextAlign.justify,
                          ),
                          /*Row( children:[
                            Image(
                              //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                              image: AssetImage('assets/whatsapp2.png'),
                              fit: BoxFit.fitHeight,
                              height: 30,
                            ),
                            InkWell(child: Text("$celular", style: TextStyle(decoration: TextDecoration.underline,decorationColor: Colors.green,color: Colors.black)),
                              onTap:() {
                               // enviarComprobante();
                              }, ),
                          ]

                          ),*/

                          //Text(admin.descripcion),
                        ]),
                        //Inicio de llamada de datos al servidor
                    /*FutureBuilder(

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
                                'Ha ocurrido un error al obtener la informacion:',// ${snapshot.error} ',
                                style: const TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            final data = snapshot.data;

                            return Center(
                              child: Text(
                                data!.descripcion.toString(),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.normal ),textAlign: TextAlign.justify,
                              ),

                            );
                          }
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
          },),*/
                        //Fin de llamada de datos all servidor

                    ),),
                    Card(
                      color: Colors.white,
                      elevation: 10,
                      shadowColor: Colors.lightBlueAccent,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),),

                      margin: EdgeInsets.all(20),
                      child :Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(20),
                        child:

                        Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/misionandvision/vision.jpg'),
                                fit: BoxFit.fitHeight,
                                height:200,
                              ),
                              Text("Visión",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),textAlign: TextAlign.center,),

                              SelectableText.rich( TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  //  const TextSpan(text: "Nota: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                  TextSpan(text: "Ser la mejor alternativa de proveedores de servicios a "
                                      "nivel regional con la mejor infraestructura y ser reconocidos "
                                      "como una de las mejores empresas que brinda servicios de excelencia "
                                      "con calidad, innovación y responsabilidad. Ofrecer servicios de Internet a "
                                      "domicilio con gente altamente capacitada y calificada para brindar un mejor "
                                      "servicio, satisfacción y seguridad comprometidos con el mejoramiento continuo "
                                      "para maximizar la satisfacción de cada cliente.", style: TextStyle(fontSize: 16),),
                                ],),
                                textAlign: TextAlign.justify,
                              ),

                            ]),


                      ),),
                    Container(
                      height: 30,
                      //width: 160,
                    ),
                  ]
              )
             ),
          ]),
    ) : Center(child: CircularProgressIndicator()),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(milliseconds: 20));
    setState(() {
    });
    return null;
  }
}
import 'package:flutter/material.dart';

class cRecomendaciones extends StatefulWidget {
  const cRecomendaciones({super.key});

  @override
  State<cRecomendaciones> createState() => _cRecomendacionesState();
}

class _cRecomendacionesState extends State<cRecomendaciones> {

  //Variables para Refrescar la página
  var list;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
        centerTitle: true,
        title: Text("Recomendaciones",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),  textAlign: TextAlign.center,),
        //toolbarHeight: 2,
        elevation: 3,
        shadowColor: Colors.lightBlue,
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
                        Container(
                          height: 30,
                          width: 30,
                        ),
                        Card(
                            color: Colors.white,
                            elevation: 15,
                            shadowColor: Colors.black45,
                            shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),),
                            margin: EdgeInsets.fromLTRB(40, 10, 40, 5),
                          child :Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(20),
                                child: Text("Consejos para mejorar \n la señal de tu WIFI",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                  style: const TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.bold ),textAlign: TextAlign.center,
                                      ),
                          ),),
                        Card(
                            margin: EdgeInsets.all(20),
                            clipBehavior: Clip.none,
                            //margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            elevation: 15,
                            color: Colors.white,
                            child:
                            Column(

                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(padding:EdgeInsets.all(8.0)),
                                //Cargar Imagen - Lista
                                //Image.network(admin.imagen),
                               // const Padding(padding:EdgeInsets.all(8.0)), //Espacio
                                ListTile(
                                  contentPadding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                                  title: const Text("Reinicia el router",textAlign: TextAlign.center,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                                  subtitle:
                                  /*Align(
                  alignment: Alignment.topLeft,
               child: */
                                  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text("¿Te suena esta frase?",textAlign: TextAlign.center,style:
                                        TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 16),),

                                        RichText(  textAlign:TextAlign.justify,text: TextSpan (
                                          style: DefaultTextStyle.of(context).style,
                                          children: const <TextSpan>[

                                             TextSpan(text:
                                                "Este es el primer consejo de cualquier técnico. ¿Has probado reiniciando el router?"
                                               " Pues no, no es un truco tonto, desenchufarlo, esperar unos segundos y luego volver a enchufarlo puede"
                                                    " eliminar cualquier tipo de error o congestión pendiente en el router. Una vez lo vuelvas a conectar la transmisión "
                                                    "Wi-Fi debería mejorar. Si no mejora, pasamos al siguiente consejo." ,
                                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, ),
                                            ),
                                            TextSpan(text:"", style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18),),
                                          ],),
                                        ),


                                       /* Row( children:[
                                          Image(
                                            //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                                            image: AssetImage('assets/whatsapp2.png'),
                                            fit: BoxFit.fitHeight,
                                            height: 30,
                                          ),
                                          InkWell(child: Text("", style: TextStyle(decoration: TextDecoration.underline,decorationColor: Colors.green,color: Colors.black)),
                                            onTap:() {
                                              //enviarComprobante();
                                            }, ),
                                        ]

                                        ),*/

                                        //Text(admin.descripcion),
                                      ]),

                                ),



                                const Padding(padding:EdgeInsets.all(8.0) ), //ESPACIO
                              ],
                            ),



                        ),
                        Container(
                          height: 500,
                          width: 160,
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

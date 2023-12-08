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
                                child: Text("Consejos para mejorar \n la señal de tu Wi-Fi",
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
                                               " Pues no, no es un truco tonto, desenchufarlo, esperar unos segundos y luego volver a enchufarlo puede ",
                                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, ),
                                            ),
                                            TextSpan(text:"eliminar cualquier tipo de error o congestión ",
                                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),),
                                            TextSpan(text:"pendiente en el router. Una vez lo vuelvas a conectar la transmisión "
                                            "Wi-Fi debería mejorar. Si no mejora, pasamos al siguiente consejo.",
                                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17,),),
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
                                title: const Text("Coloca el router en\nuna buena ubicación",textAlign: TextAlign.center,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                                subtitle:
                                /*Align(
                  alignment: Alignment.topLeft,
               child: */
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      /*const Text("¿Te suena esta frase?",textAlign: TextAlign.center,style:
                                      TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 16),),*/

                                      RichText(  textAlign:TextAlign.justify,text: TextSpan (
                                        style: DefaultTextStyle.of(context).style,
                                        children: const <TextSpan>[

                                          TextSpan(text:
                                          "Tenemos que tener en cuenta que al instalar la antena del router este propagará "
                                              "la señal en todas las direcciones. Por lo tanto ",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, ),
                                          ),
                                          TextSpan(text:"la mejor ubicación debería ser el centro de la casa.",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),),
                                          TextSpan(text:" De esta forma conseguimos que la señal se propague "
                                            "uniformemente en todas las direcciones.",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17,),),
                                        ],),
                                      ),
                                      const Padding(padding:EdgeInsets.all(8.0) ),
                                      Image(
                                        //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                                        image: AssetImage('assets/ubicacionRouter1.jpg'),
                                        fit: BoxFit.fitHeight,
                                        height: 200,
                                      ),
                                      const Padding(padding:EdgeInsets.all(8.0) ),
                                      RichText(  textAlign:TextAlign.justify,text: TextSpan (
                                        style: DefaultTextStyle.of(context).style,
                                        children: const <TextSpan>[

                                          TextSpan(text:
                                          "Por lo general, los routers más sencillos cuentan con antenas "
                                              "omnidireccionales, es decir, envían una señal en un ángulo "
                                              "de 360º alrededor del equipo. Si los colocas en una esquina, "
                                              "la mitad de la señal del equipo se perderá en la calle o en casa de los vecinos." ,
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, ),
                                          ),

                                        ],),

                                      ),
                                      const Padding(padding:EdgeInsets.all(8.0) ),
                                      Image(
                                        //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                                        image: AssetImage('assets/ubicacionRouter2.jpg'),
                                        fit: BoxFit.fitHeight,
                                        height: 200,
                                      ),


                                    ]),
                              ),
                              const Padding(padding:EdgeInsets.all(8.0) ), //ESPACIO
                            ],
                          ),
                        ),
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
                                title: const Text("Elimina los obstáculos que\npuedan interferir con el Wi-Fi",textAlign: TextAlign.center,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                                subtitle:
                                /*Align(
                  alignment: Alignment.topLeft,
               child: */
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      /*const Text("¿Te suena esta frase?",textAlign: TextAlign.center,style:
                                      TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 16),),*/

                                      RichText(  textAlign:TextAlign.justify,text: TextSpan (
                                        style: DefaultTextStyle.of(context).style,
                                        children: const <TextSpan>[

                                          TextSpan(text:
                                          "Es importante que ",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, ),
                                          ),
                                          TextSpan(text:"no coloques el router cerca de objetos ",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),),
                                          TextSpan(text:"como espejos,paredes, vigas muy gruesas y estructuras con marcos de malla o metal. "
                                              "Tampoco lo coloques al lado de equipos que emitan ruido en la red, como "
                                              "microondas o teléfonos inalámbricos. Todos estos objetos y estructuras "
                                              "dificultan e impiden la propagación de la señal WiFi. Se sabe que hay algunos "
                                              "elementos que interrumpen en gran medida la señal del WiFi. "
                                              "El agua, por ejemplo, no deja pasar la señal. Los equipos que funcionan o ",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17,),),
                                          TextSpan(text:"emiten ruido en la frecuencia de 2,4 GHz, ",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),),
                                          TextSpan(text:"como un microondas, monitores para bebés,dispositivos "
                                              "Bluetooth, etc., también pueden interferir con el rendimiento de nuestro router.",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17,),),
                                        ],),
                                      ),
                                      const Padding(padding:EdgeInsets.all(8.0) ),
                                      Image(
                                        //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                                        image: AssetImage('assets/obstaculo.jpg'),
                                        fit: BoxFit.fitHeight,
                                        height: 200,
                                      ),
                                      const Padding(padding:EdgeInsets.all(8.0) ),
                                      RichText(  textAlign:TextAlign.justify,text: TextSpan (
                                        style: DefaultTextStyle.of(context).style,
                                        children: const <TextSpan>[

                                          TextSpan(text:
                                              "Puedes tener un router de doble banda, es decir, que también funciona en la "
                                              "frecuencia de 5 GHz. En este caso un teléfono inalámbrico no debería "
                                              "provocar mucha diferencia (si usa esa frecuencia), pero aún así dañará la red de 2,4 GHz."
                                            ,
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, ),
                                          ),
                                          TextSpan(text:"", style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18),),
                                        ],),
                                      ),

                                    ]),
                              ),
                              const Padding(padding:EdgeInsets.all(8.0) ), //ESPACIO
                            ],
                          ),
                        ),
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
                                title: const Text("Revisa el uso de Internet",textAlign: TextAlign.center,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                                subtitle:
                                /*Align(
                  alignment: Alignment.topLeft,
               child: */
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      /*const Text("¿Te suena esta frase?",textAlign: TextAlign.center,style:
                                      TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 16),),*/

                                      RichText(  textAlign:TextAlign.justify,text: TextSpan (
                                        style: DefaultTextStyle.of(context).style,
                                        children: const <TextSpan>[

                                          TextSpan(text:
                                          "Es muy importante que comprobemos que la velocidad de nuestro Internet "
                                              "es la que hemos contratado. Si el problema no está en la velocidad, "
                                              "es posible que alguno de los dispositivos que están conectados a nuestro WiFi "
                                              "usen demasiado ancho de banda al intentar usar internet.Ver series en ",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, ),
                                          ),
                                          TextSpan(text:"Netflix, Prime Video o descargar juegos ",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          TextSpan(text:"y otros archivos consume mucho ancho de banda. Si alguien que está conectado "
                                          "a nuestro Internet hace este tipo de uso es muy posible que sea el motivo "
                                          "de la congestión de la red.",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),
                                          )
                                        ],),
                                      ),
                                      /*const Padding(padding:EdgeInsets.all(8.0) ),
                                      Image(
                                        //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                                        image: AssetImage('assets/obstaculo.jpg'),
                                        fit: BoxFit.fitHeight,
                                        height: 200,
                                      ),*/


                                    ]),
                              ),
                              const Padding(padding:EdgeInsets.all(8.0) ), //ESPACIO
                            ],
                          ),
                        ),
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
                                title: const Text("Cambia el nombre\ny la contraseña de tu Wi-Fi",textAlign: TextAlign.center,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                                subtitle:
                                /*Align(
                  alignment: Alignment.topLeft,
               child: */
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      /*const Text("¿Te suena esta frase?",textAlign: TextAlign.center,style:
                                      TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 16),),*/

                                      RichText(  textAlign:TextAlign.justify,text: TextSpan (
                                        style: DefaultTextStyle.of(context).style,
                                        children: const <TextSpan>[

                                          TextSpan(text:
                                          "De la misma forma que un dispositivo que utiliza mucho ancho de banda de Internet "
                                              "perjudica la conexión de tu WiFi, tener demasiados dispositivos conectados "
                                              "también lo hace. Dependiendo del router que tengas, es posible que este no "
                                              "pueda distribuir la señal a todos los dispositivos. Debido a esto es posible "
                                              "que se dañe la conexión o incluso que no funcione en alguno de los dispositivos."
                                            ,
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, ),
                                          ),

                                          TextSpan(text:" Cambiar el nombre y la contraseña de la red Wi-Fi ",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          TextSpan(text:
                                          "hará que los "
                                              "dispositivos conectados no puedan encontrar la red anterior y tengan que "
                                              "volver a conectarse a otra. Esto ayudará a eliminar el acceso de aquellos "
                                              "que usan tu red sin autorización (este puede ser el caso de algunos vecinos). "
                                              "Pero recuerda que si cambias el nombre y la contraseña tendrás que volver a "
                                              "conectarte en todos los dispositivos de la casa.",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),),
                                        ],),
                                      ),


                                    ]),
                              ),
                              const Padding(padding:EdgeInsets.all(8.0) ), //ESPACIO
                            ],
                          ),
                        ),
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
                                title: const Text("Cambia de router\npara mejorar tu señal",
                                  textAlign: TextAlign.center,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent),),
                                subtitle:
                                /*Align(
                  alignment: Alignment.topLeft,
               child: */
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      /*const Text("¿Te suena esta frase?",textAlign: TextAlign.center,style:
                                      TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 16),),*/

                                      RichText(  textAlign:TextAlign.justify,text: TextSpan (
                                        style: DefaultTextStyle.of(context).style,
                                        children: const <TextSpan>[
                                          TextSpan(text:"Los nuevos routers ",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          TextSpan(text:
                                              "que hay en el mercado agregan nuevas tecnologías para optimizar "
                                              "el rendimiento y la transmisión de la señal Wi-Fi. Estos routers cuentan con ",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, ),
                                          ),

                                          TextSpan(text:"tecnología de malla ",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          TextSpan(text:"y se están volviendo muy populares en el mercado. Son capaces de ",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),),
                                          TextSpan(text:"ampliar el área de cobertura ",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          TextSpan(text:"y, además, agregan características como el roaming rápido. Permiten que "
                                              "los dispositivos se muevan pero permanecen conectados al nodo con mejor velocidad "
                                              "de conexión"
                                              "en su red de malla.",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),),

                                          TextSpan(text:" Comprar un router con nuevas tecnologías puede ayudar a mejorar la "
                                              "señal Wi-Fi. ",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          TextSpan(text:"Tenda, D-Link, TP-Link y otros fabricantes ya trabajan con "
                                           ,
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),
                                             ),
                                          TextSpan(text:"Wi-Fi Mesh ",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          TextSpan(text:"Son kits que se componen de dos, tres o más routers. "
                                              "Estos forman los “nudos” que "
                                              "distribuyen la señal por toda tu casa o negocio. "
                                          "La diferencia con los repetidores de señal es que estos crean "
                                              "varias redes diferentes y reducen la velocidad "
                                            "a la mitad a medida que instalas más."
                                            " En cambio un sistema ",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),),
                                          TextSpan(text:"\nWi-Fi Mesh brinda una señal fuerte y constante ",
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          TextSpan(text:"en cada milímetro del inmueble y es capaz "
                                              "de conectar decenas de dispositivos al mismo tiempo, como "
                                              "móviles, smart TV, notebooks, videojuegos y otros "
                                              "dispositivos del hogar.",
                                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),),

                                        ],),
                                      ),
                                      const Padding(padding:EdgeInsets.all(4.0) ),
                                      Image(
                                        //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                                        image: AssetImage('assets/router1.png'),
                                        fit: BoxFit.contain,
                                        height: 200,
                                      ),

                                    ]),
                              ),
                              const Padding(padding:EdgeInsets.all(8.0) ), //ESPACIO
                            ],
                          ),
                        ),

                        Container(
                          height:20,
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

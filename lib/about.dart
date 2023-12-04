

import 'package:flutter/material.dart';

import 'Modelo/empresa.dart';



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
        extendBody: true,
        backgroundColor:Colors.transparent,
      appBar: AppBar(
        title: Text('Sobre nosotros',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 2,
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
                      height: 160,
                      width: 160,
                    ),
                  Card(
                    color: Colors.white,
                    elevation: 15,
                    shadowColor: Colors.black45,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),),

                    margin: EdgeInsets.all(20),
                    child :Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(20),
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
          },),

                    ),),
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
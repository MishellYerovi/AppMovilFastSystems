
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class menuServicios extends StatefulWidget {
  const menuServicios({super.key});

  @override
  State<menuServicios> createState() => _menuServiciosState();
}

class _menuServiciosState extends State<menuServicios> {


  @override
  Widget build(BuildContext context) {
  return  Scaffold(

    extendBodyBehindAppBar: true,
      //extendBody: true,
    backgroundColor: Colors.transparent,
     // backgroundColor: Im,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
        title: Text(" Servicios"),
        backgroundColor: Colors.lightBlueAccent,

      ),
      body:
Center (
      child: Padding(

        //child: Text('Services Page',style: TextStyle(fontWeight: FontWeight.bold),),
          padding: EdgeInsets.fromLTRB(5, 60, 5, 60),
          child:
              Card(
                //margin: EdgeInsets.fromLTRB(20, 20, 20, 50),
                elevation: 15,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),),
                color: Colors.white,
                  child:
                  Container( padding: EdgeInsets.all(50),
                    child:
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //const Padding(padding:EdgeInsets.all(8.0)),
                      //const Padding(padding:EdgeInsets.all(10.0) ), //ESPACIO
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed("HomeServiciosInfoPagos");
                          //Navigator.push( context, MaterialPageRoute(builder: (context) => webViewContainer()),);
                        },
                        style: ElevatedButton.styleFrom(fixedSize: const Size(160, 160), backgroundColor: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.credit_score_outlined,
                              color: Colors.white,
                              size: 80.0,
                            ),
                            SizedBox(
                              width:10,
                              // height: 50,
                            ),
                            Text("Pagos", style:TextStyle(fontSize:20, color:Colors.white), textAlign: TextAlign.center, ),
                          ],
                        ),
                      ),
                      const Padding(padding:EdgeInsets.all(10.0) ), //ESPACIO
                      //Botón Recomendaciones
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed("HomeServiciosRecomendaciones");
                         // context.pushNamed("HomeServiciosRecomendaciones");
                         // GoRouter.of(context).pushNamed("HomeServiciosRecomendaciones");
                          //Navigator.push( context, MaterialPageRoute(builder: (context) => webViewContainer()),);
                        },
                        style: ElevatedButton.styleFrom(fixedSize: const Size(160, 160), backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.tips_and_updates_outlined,
                              color: Colors.white,
                              size: 80.0,
                            ),
                            SizedBox(
                              width:10,
                              // height: 50,
                            ),
                            Text("Tips", style:TextStyle(fontSize:20, color:Colors.white,), textAlign: TextAlign.center, ),
                          ],
                        ),
                      ),
                      //SizedBox(height: 60,),
                    ],
                  ),),
              ),


      ),
  ),

    );
  }
}

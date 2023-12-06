
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
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(" Servicios"),
      ),
      body: Center(
        //child: Text('Services Page',style: TextStyle(fontWeight: FontWeight.bold),),
          child: ElevatedButton(
            onPressed: () {
              context.goNamed("HomeServiciosInfoPagos");
              //Navigator.push( context, MaterialPageRoute(builder: (context) => webViewContainer()),);
            },
            style: ElevatedButton.styleFrom(fixedSize: const Size(160, 160), backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
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
          )
      ),

    );
  }
}

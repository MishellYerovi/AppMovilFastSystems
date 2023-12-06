


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:wifi_info_plugin_plus/wifi_info_plugin_plus.dart';





class menu_configuraciones extends StatefulWidget {
  const menu_configuraciones ({super.key});
 // BottomNavBar a = new BottomNavBar();
  @override
  State<menu_configuraciones> createState() => _menu_configuracionesState();
}

class _menu_configuracionesState extends State<menu_configuraciones> {

  String? router;
  String? routerName;
  String? routerB;
  WifiInfoWrapper? _wifiObject;  //example
  Future<String?>getData() async {
    final info = NetworkInfo();
    var wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    var wifiIP = await info.getWifiIP(); // 192.168.1.1
    var wifiIP2 = await info.getWifiGatewayIP(); // 192.168.0.1 //Obtiene la puerta de enlace
    var wifiName = await info.getWifiName();
    return wifiIP2;
  }
  Future<String?>getDataName() async {
    final info = NetworkInfo();

    var wifiName = await info.getWifiName();//Obtiene el nombre de la red
    return wifiName;
  }
  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        router = value;
      });

    });
    getDataName().then((value) {
      setState(() {
        routerName = value;
      });

    });

    initPlatformState();  //EXAMPLE

  }
  ///example
  Future<void> initPlatformState() async {
    WifiInfoWrapper? wifiObject;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}
    if (!mounted) return;

    setState(() {
      _wifiObject= wifiObject;
    });
  }

  @override
  Widget build(BuildContext context) {

    String ipAddress = _wifiObject != null ? _wifiObject!.ipAddress.toString() : "no";

    String macAddress = _wifiObject != null ? _wifiObject!.macAddress.toString() : 'no';
    String connectionType = _wifiObject != null ? _wifiObject!.connectionType.toString() : 'unknown';

    String name = _wifiObject != null ? _wifiObject!.ssid.toString() : 'unknown';

    return Scaffold(
      appBar: AppBar(
         //title: Text("Configuraciones),
       // toolbarHeight: 40,
        elevation: 5,
        title: Text("Configuraciones"),
        shadowColor: Colors.lightBlue,
        backgroundColor: Colors.lightBlueAccent,

      ),
    body:

     // child: Text( text.toString()),
     SizedBox(
       width: double.infinity,
       height: double.infinity,
          child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              //  _list.elementAt(_page),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // _pages[_selectedTab],
                      Container(
                          color:Colors.grey.shade300,

                          // margin: EdgeInsets.symmetric(horizontal: 21.0),
                          //margin: const EdgeInsets.all(10),
                          margin: const EdgeInsets.fromLTRB(10, 30, 0, 10),
                          child: Center(
                              child: Container(

                                  height: 160,
                                  width: 160,

                                  decoration:BoxDecoration(
                                    color:Colors.grey.shade300,
                                    //color:Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.indigoAccent,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: Offset(4,4),
                                      ),
                                      BoxShadow(
                                        color: Colors.white,
                                        spreadRadius: 2,
                                        blurRadius: 8,
                                        offset: Offset(-4,-4),
                                      ),
                                    ],
                                  ),
                                 /* child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push( context, MaterialPageRoute(builder: (context) => webViewContainerRouter(tex)),); },
                                    style: ElevatedButton.styleFrom(fixedSize: const Size(150, 150), backgroundColor:Colors.indigo,

                                    ),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 80.0,
                                        ),
                                        SizedBox(
                                          width:10,
                                          // height: 50,
                                        ),
                                        Text("Usuarios", style:TextStyle(fontSize:20, color:Colors.white ), textAlign: TextAlign.center, ),
                                      ],),)*/
                              ))),
                      Container(
                          color:Colors.grey.shade300,

                          margin: const EdgeInsets.fromLTRB(0, 30, 10, 10),
                          // margin: EdgeInsets.symmetric(horizontal: 15.0),
                          // margin: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                          child: Center(
                              child: Container(

                                  height: 160,
                                  width: 160,

                                  decoration:BoxDecoration(
                                    color:Colors.grey.shade300,
                                    //color:Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.lightBlue,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: Offset(4,4),
                                      ),
                                      BoxShadow(
                                        color: Colors.white,
                                        spreadRadius: 2,
                                        blurRadius: 8,
                                        offset: Offset(-4,-4),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                     // webViewContainerRouter(text.toString());
                                    // webViewContainerRouter(router.toString());
                                      routerB= router.toString();
                                      //print("HOLA MUNDO" + routerB!);
                                      context.goNamed("HomeRouterPage",extra: routerB);

                                     /*Navigator.push( context, MaterialPageRoute(builder: (context)
                                          {
                                            return new webViewContainerRouter(router.toString());
                                    },

                                          ));*/


                                    },
                                    style: ElevatedButton.styleFrom(fixedSize: const Size(150, 150), backgroundColor: Colors.lightBlue
                                    ),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.router,
                                          color: Colors.white,
                                          size: 80.0,
                                        ),
                                        SizedBox(
                                          width:10,
                                          // height: 50,
                                        ),
                                        Text("Cambiar Contraseña"+routerName.toString(), style:TextStyle(fontSize:20, color:Colors.white), textAlign: TextAlign.center, ),
                                      ],
                                    ),
                                  )
                              )
                          )
                      ),
                    ]
                ),

                //  ),

                 //Container _buildChild() (

                 //child:

                 //_list.elementAt(_page),

          /* */

              ]

          ),
          /* Container(
             child: _list.elementAt(_page),
           ),*/

      ),

    );


  }

}


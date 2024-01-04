import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import 'Modelo/empresa.dart';

class Ubicacion extends StatefulWidget {
  const Ubicacion({Key? key}) : super(key: key);

  @override
  State<Ubicacion> createState() => _UbicacionState();
}

class _UbicacionState extends State<Ubicacion> {
  late Future<Empresa> futureEmpresa; //instanciamos la clase Empresa

  final PopupController _popupController = PopupController();
  final MapController _mapController = MapController(
   //initMap
  );

  double _zoom = 10.0;
 // List<LatLng> latlang =new List();
  final List<LatLng>_latLngList = [
    const LatLng(-1.73296,-78.59704),
   // LatLng(13.02, 77.51),
    //LatLng(13.05, 77.53),
  ];
  List<Marker> _markers = [];


  @override
  void initState() {
     //Obtiene datos de la clase Empresa
    super.initState();
    futureEmpresa = fetchEmpresa();
    //Carga el marcador
    _markers = _latLngList
        .map((point) => Marker(
      point: point,
      width: 40,
      height: 40, child: Icon(
      Icons.location_pin,
      size: 40,
      color: Colors.indigoAccent,
    ),
      //builder: (_) => const Icon(Icons.location_on, size: 40),
      //anchorPos: const AnchorPos.align(AnchorAlign.top),
      alignment: Alignment.topCenter,
      rotate: true,
      //rotateAlignment: AnchorAlign.top.rotationAlignment,
      //builder: (context) =>
    ),)
        .toList();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //extendBody: false,
      appBar: AppBar(
        title: Text('Ubicación'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )) ,
      ),

      body:
         // Container(
     //child:
     FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _latLngList[0],
          initialZoom: _zoom,
          initialCameraFit: CameraFit.coordinates(coordinates: _latLngList),
          interactionOptions: InteractionOptions(enableMultiFingerGestureRace: true),
          //maxZoom: 17,
          maxZoom: 19,
          //swPanBoundary: LatLng(-1.7279,-78.7613) ,
          //nePanBoundary: LatLng(-1.7213,-78.4026) ,
          //maxBounds: LatLngBounds(LatLng(-2.0020,-78.5797), LatLng(-1.6142,-78.6175)),
          //-----------maxBounds: LatLngBounds(LatLng(-1.6145,-78.7054), LatLng(-1.7910,-78.5437)),
          //-----cameraConstraint: CameraConstraint.contain(bounds: LatLngBounds(LatLng(-1.6145,-78.7054), LatLng(-1.7910,-78.5437))),
          cameraConstraint: CameraConstraint.contain(bounds: LatLngBounds(LatLng(-1.6786,-78.6209), LatLng(-1.8227,-78.4286))),
          //minZoom: 12,



           //swPanBoundary: LatLng(13, 77.5),
           //nePanBoundary: LatLng(13.07001, 77.58),


         //---------- bounds: LatLngBounds.fromPoints(_latLngList),

          /*plugins: [
            MarkerClusterPlugin(),
          ],*/
         // onTap: _popupController.hideAllPopups(disableAnimation: false),
          //onTap: () =>_popupController.hideAllPopups(),

          onTap: (tapPosition, point) => _popupController.hideAllPopups(),
        ),

       children:[

         TileLayer(
           tileProvider: NetworkTileProvider(),
          //minNativeZoom: 12,
          maxNativeZoom: 19,

           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
           fallbackUrl:'https://tile.openstreetmap.org/{z}/{x}/{y}.png' ,
           //urlTemplate: 'https://www.openstreetmap.org/?mlat=-1.73296&mlon=-78.59704#map=19/-1.73296/-78.59704.png',
            // subdomains: ['a', 'b', 'c'],
           userAgentPackageName: 'com.fastsystems_app2.app',
           retinaMode: true  && MediaQuery.of(context).devicePixelRatio > 1.0,


         ),

        /* MarkerClusterLayer(
             key:null, map:_mapController,
              MarkerClusterLayerOptions(builder: (context, markers) {
           return Container( alignment: Alignment.center, decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
             child: Text('${markers.length}'),);
         },size:Size(50,50),fitBoundsOptions: FitBoundsOptions( padding: EdgeInsets.all(50),),)
         ),*/
        MarkerClusterLayerWidget( options: MarkerClusterLayerOptions(builder: (context, markers) {
           return Container( alignment: Alignment.center, decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
             child: Text('${markers.length}'),);
         },//maxClusterRadius: 190,
           disableClusteringAtZoom: 16,
          size:Size(50,50),
          markers: _markers,
          // size:Size(50,50),fitBoundsOptions: FitBoundsOptions( padding: EdgeInsets.all(50),), markers: _markers,
           /*polygonOptions: PolygonOptions(
               borderColor: Colors.orange,
               color: Colors.red,
               borderStrokeWidth: 3),
           popupOptions: PopupOptions(
               popupSnap: PopupSnap.mapTop,
               popupController: _popupController,
               popupBuilder: (_, marker) => Container(
                 color: Colors.amberAccent,
                 child: Text('Popup'),
               ),
           ),*/
         ), key: null,),
        /* PolygonOptions(borderColor: Colors.orange,
             color: Colors.red,
             borderStrokeWidth: 3),*/

         Stack(
           children: [
         PopupMarkerLayer(options: PopupMarkerLayerOptions(
           popupController:_popupController ,
           markers: _markers,
           popupDisplayOptions: PopupDisplayOptions(
             //snap: PopupSnap.mapBottom,
             builder: (BuildContext context, Marker marker) =>

              SizedBox(
                width:250 ,
                height: 200,
                child: Card(
                   color: Colors.white,
                   elevation: 5,
                   shadowColor: Colors.black45,
                   shape:RoundedRectangleBorder(
                     /* side: BorderSide(
                  color: Colors.black45,
                ),*/
                     borderRadius: BorderRadius.circular(5.0),
             ),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                    // mainAxisSize: MainAxisSize.min,
                   ListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        title: Text("FastSystems",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                        subtitle: Text("Proveedor de Internet",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15)),

                       /* Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text("",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15),),
                              SelectableText.rich(  TextSpan (
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  const TextSpan(text: "Empresa Proveedora de Internet",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16), ),
                                  //TextSpan(text:"2203462289", style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16),),
                                ],),

                              ),


*/
                             /* Row( children:[
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

                              ),*/

                              //Text(admin.descripcion),

                        trailing:  CloseButton(
                          style: ButtonStyle(

                            //shadowColor: MaterialStateProperty.all(Colors.blueAccent),
                          ),
                        onPressed: (){
                          _popupController.hidePopupsOnlyFor(_markers);
                        },),
                   ),


                       ListTile(

                         subtitle:
                         Column(
                             mainAxisSize: MainAxisSize.min,
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               //Text("Proveedor de Internet",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15),),
                              /* SelectableText.rich(  TextSpan (
                                 style: DefaultTextStyle.of(context).style,
                                 children: <TextSpan>[
                                   const TextSpan(text: "Proveedor de Internet",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),
                                   //TextSpan(text:"2203462289", style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16),),
                                 ],),

                               ),*/
                               Row(children: [
                                 Icon(Icons.location_pin, size: 20,color: Colors.lightBlue,),
                                 SelectableText.rich(  TextSpan (
                                   style: DefaultTextStyle.of(context).style,
                                   children: <TextSpan>[
                                     const TextSpan(text: " Chambo",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),

                                   ],),

                                 ),
                               ],),
                               Text("Av.18 de Marzo y Joaquín Gavilanes"),

                               Row(children: [
                                 Icon(Icons.local_phone, size: 20,color: Colors.lightBlue,),
                                    SelectableText.rich(  TextSpan (
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                    const TextSpan(text: " 0992562727",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15), ),

                                    ],), ),
                               ],)



                              // Text("Cel:0992562727", style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                               /* Row( children:[
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

                              ),*/

                               //Text(admin.descripcion),
                             ]),
                       )

                     ],),


                   /* child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
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
                                    'An ${snapshot.error} occurred',
                                    style: const TextStyle(fontSize: 18, color: Colors.red),
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                final data = snapshot.data;
                                return Center(
                                  child:
                                  ListTile(
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                                    title: Text(data!.nombre.toString()),
                                    subtitle: Text(data!.descripcion_corta.toString()),

                                    trailing:  CloseButton(
                                      onPressed: (){
                                       // context.
                                       context.pop();
                                       // Navigator.of(context).pop();
                                     /// Navigator.pop(context);
                                    },),
                                   // onTap:() ,

                                    /*Row(
                              children: [
                                IconButton(onPressed: () {Navigator.pop();}, icon: Icon(Icons.favorite)),
                                //IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                               // IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                                ],
                            ),*/
                                  ),
                                  /*Text(
                                    data!.nombre.toString(),
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.normal ),textAlign: TextAlign.justify,
                                  ),*/
                                );
                              }
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                            // Usamos una fila para ordenar los botones del card
                            Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            ElevatedButton (onPressed: () => {}, child: Text('Ver más')),
                            //ElevatedButton (onPressed: () => {}, child: Text('Cancelar'))
                            ],
                            )
                            /*  SizedBox(
                                width:200 ,
                                  height: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                  Container(
                                    color: Colors.transparent,
                                    //padding: EdgeInsets.all(2),
                                    padding: EdgeInsets.fromLTRB(10,10,20,10),
                                    child: Text("FastSystems"),

                                    /*  //---sirva el host
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
                                                'An ${snapshot.error} occurred',
                                                style: const TextStyle(fontSize: 18, color: Colors.red),
                                              ),
                                            );
                                          } else if (snapshot.hasData) {
                                            final data = snapshot.data;
                                            return Center(
                                              child: Text(
                                                data!.nombre.toString(),
                                                style: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.normal ),textAlign: TextAlign.justify,
                                              ),
                                            );
                                          }
                                        }

                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },

                                    ),*/ //---sirva el host

                                  ),
                                    ElevatedButton(
                                      onPressed: () {
                                        //context.goNamed("HomeUsuarios");
                                        //Navigator.push( context, MaterialPageRoute(builder: (context) => webViewContainer()),);
                                      },
                                      style: ElevatedButton.styleFrom(fixedSize: const Size(5, 5), backgroundColor:Colors.red,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2),),alignment: Alignment(200,-10 )
                                      ),
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.white,
                                            size: 10,
                                          ),
                                         // SizedBox(
                                           // width:2,
                                            // height: 50,
                                         // ),
                                          //Text("Usuarios", style:TextStyle(fontSize:20, color:Colors.white ), textAlign: TextAlign.center, ),
                                        ],),)

    ],
    ),
    ),
*/
                            ],
                            ),*/
                 ),
    ),
          //ExamplePopup(marker),
           ),
         //popupController:
         ),

         ),
       ],
     ),
      //tileProvider: NetworkTileProvider(),
       ],
       //

      ),
          //),
    );

  }
}

    // markers: _markers,),,key:null,),

         //MarkerLayer(markers: _markers, rotateAlignment: Alignment.center),

       /* nonRotatedChildren: [

          MarkerClusterLayerOptions(
              builder: (context, markers){
            return Container( alignment: Alignment.center, decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
            child: Text('${markers.length}'),);
            },size: Size(50, 50)),

        ]*/

     // ),

/*

TileLayer(
            minZoom: 2,
            maxZoom: 18,
            minNativeZoom:2 ,
            maxNativeZoom: 18,
            //backgroundColor: Colors.black,
            // errorImage: ,
           // urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            urlTemplate: ('https://www.openstreetmap.org/#map=19/-1.73296/-78.59704'),
           //*wmsOptions: WMSTileLayerOptions(
             /* baseUrl: 'https://www.openstreetmap.org/#map=19/-1.73296/-78.59704.png',
             // layers: const ['s2cloudless-2021_3857'],
            ),*/
            subdomains: ['a', 'b', 'c'],
          ),
    RichAttributionWidget(
        popupInitialDisplayDuration: const Duration(seconds: 5),
        attributions: [
          TextSourceAttribution(
            'Sentinel-2 cloudless - https://s2maps.eu by EOX IT Services GmbH',
            onTap: () => launchUrl(Uri.parse('https://www.openstreetmap.org/#map=19/-1.73296/-78.59704')),
          ),
          const TextSourceAttribution(
            'Modified Copernicus Sentinel data 2021',
          ),
TextSourceAttribution(
    'Rendering: EOX::Maps',
    onTap: () =>
    launchUrl(Uri.parse('https://www.openstreetmap.org/#map=19/-1.73296/-78.59704/')),
    ),
    ],
      ),
          //MarkerLayer(markers: _markers),
        ],
      MarkerClusterLayerOptions(
        maxClusterRadius: 190,
        disableClusteringAtZoom: 16,
        size: Size(50, 50),
        fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
        markers: _markers,
        polygonOptions: PolygonOptions(
            borderColor: Colors.blueAccent,
            color: Colors.black12,
            borderStrokeWidth: 3),
        popupOptions: PopupOptions(
            popupSnap: PopupSnap.mapTop,
            popupController: _popupController,
            popupBuilder: (_, marker) => Container(
              color: Colors.amberAccent,
              child: Text('Popup'),
            )),
        builder: (context, markers) {
          return Container(
            alignment: Alignment.center,
            decoration:
            BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
            child: Text('${markers.length}'),
          );
        },
      ),
      */
*/


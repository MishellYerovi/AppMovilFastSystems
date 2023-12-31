
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fastsystems_app2/Otros/playE.dart';
import 'package:fastsystems_app2/verifConexionInternet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Modelo/imagenesNoticias.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();


}

class _HomeState extends State<Home> {
  late Future <List<Imagenes>> futureNoticias;
  var list;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {

    setState(() {
      //Main("si");
      //print("home si");
    });
    super.initState();
    futureNoticias = fetchNoticias();
    refreshList();
    showStatusBar();

  }
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  Future showStatusBar() async
  {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      extendBodyBehindAppBar: true,
      //backgroundColor: Colors.lightBlueAccent,
      //backgroundColor: Colors.white60,
      backgroundColor: Colors.white,
      appBar: AppBar(

        //flexibleSpace: Container(height: 10),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    )) ,
       title:const Image(
         image: AssetImage('assets/logos/logo_letras.png'),
         fit: BoxFit.fitWidth,
         height: 30,
         width: 160,
       ),
       /* Text("FastSystems",style: TextStyle(
             fontWeight: FontWeight.bold,
            color: Colors.blue,
           // fontStyle: FontStyle.italic
      ),  textAlign: TextAlign.left,),*/
      //toolbarHeight: 2,
        elevation: 5,
        shadowColor: Colors.black45,
        backgroundColor: Colors.white,
        leading: Container(
          //color:Colors.white,
          padding: EdgeInsets.all(5),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white)
          ),
          child: Image.asset('assets/icon.png', fit: BoxFit.fill),
        ),

        //Image.asset('assets/icon.png', fit: BoxFit.fitHeight),
        //actions:[Image.asset('assets/icon.png', fit: BoxFit.fill)],
      ),
      body:
      //Carousel(),
      list == null
      ?
      RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child:
        ListView(

          children: <Widget>[
      SizedBox(

       // width: double.infinity,
       // height: double.infinity,
        child: SingleChildScrollView(
      padding: EdgeInsets.all(5),
       child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const WarningWidgetValueNotifier(),
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              // verticalDirection: VerticalDirection.down,
           Align(
             alignment: Alignment.topRight,
             child: OutlinedButton(onPressed: () {

               context.goNamed("HomeLogInAdministrador");
              //print("Administrador");
          }, child: Text("Admin", style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: Colors.deepPurpleAccent),),
                style: OutlinedButton.styleFrom(
                  //fixedSize: const Size(130, 10),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                //BorderRadiusTween(begin:borderRadius: BorderRadius.circular(10), end:50),
                //RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
    ),
      ),
          ),
           ),

              SizedBox(
                height: 220,
                child: FutureBuilder(
                  future:  fetchNoticias(),
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
                         /* child: Text(
                            "Error en el servidor",
                            //' ${snapshot.error} ',
                            style: const TextStyle(fontSize: 18, color: Colors.red),
                          ),*/
                         /* child: Image(
                            //image: AssetImage('assets/redesSociales/whatsapp2.png'),
                            image: AssetImage('assets/NoticiasPortal/noticiaEstatica.png'),
                            fit: BoxFit.contain,
                            height: 220,
                          ),*/
                          child: Container(
                            //height: 220,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                            // margin: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image:AssetImage('assets/NoticiasPortal/noticiaEstatica.png'),

                              ),

                            ),
                            //child:Image.network(_listImagenes(data!)[itemIndex] as String,fit: BoxFit.cover ),

                            //_listImagenes(data!)[itemIndex],

                            // _listImagenes(data!)[itemIndex],

                          ) ,

                        );
                      } else if (snapshot.hasData) {
                        final data = snapshot.data;
                        if(data!.isEmpty){Text("No existen datos");}
                        //print("longitud future" +data!.length.toString());
                        //em.id=data!.id.toString();
                        return

                          ListView(
                              shrinkWrap: true,
                              children:[
                                _listImagenes(data).length != 0?
                                CarouselSlider.builder(
                                  itemCount:_listImagenes(data).length ,
                                  itemBuilder:(BuildContext context, int itemIndex, int pageViewIndex) =>
                                      Container(
                                        margin: EdgeInsets.all(6.0),
                                        // margin: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(_listImagenes(data)[itemIndex]),

                                            ),

                                          ),
                                          //child:Image.network(_listImagenes(data!)[itemIndex] as String,fit: BoxFit.cover ),

                                            //_listImagenes(data!)[itemIndex],

                                             // _listImagenes(data!)[itemIndex],

                                  ) ,
                                 /* items: [
                                    _listImagenes(data!),
                                  ],*/
                                  //Slider Container properties
                                  //options: CarouselOptions(
                                    options:CarouselOptions(
                                    height: 220.0,
                                    enlargeCenterPage: true,
                                    autoPlay: true,
                                    aspectRatio: 9 / 16,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration: Duration(milliseconds: 700),
                                    viewportFraction: 0.8,
                                  ),)
                                : Container( alignment: Alignment.topCenter, child:Text("No existen noticias")),
                              ],
                          );
                      }
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },)



              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {
                    _launchSocialMediaAppIfInstalled(
                        url: 'https://www.facebook.com/fastsystems.ec/',//Facebook
                    );
                  }, icon: const Image(
                    //color: Colors.white,
                    //                     //colorBlendMode: Colors.white,
                    image: AssetImage('assets/redesSociales/facebook_.png'),
                    fit: BoxFit.cover,
                    //height: 40,
                  ),
                    iconSize: 40,
                    splashRadius: 20,
                    splashColor:Colors.deepPurple,
                    hoverColor: Colors.transparent,
                    highlightColor:Colors.transparent ,
                    focusColor:Colors.transparent ,
                    //const Icon(Icons.facebook, color:Colors.blue, size:40)
                  ),

                  IconButton(onPressed: () {
                    _launchSocialMediaAppIfInstalled(
                      url: 'https://www.instagram.com/fastsystems_internet/', // Facebook
                    );
                  }, icon:
                  const Image(
                    image: AssetImage('assets/redesSociales/instagram_.png'),
                    fit: BoxFit.fitHeight,
                    //height: 60,
                  ),
                    //const Icon(Icons.insta, color:Colors.blue, size:40)
                    iconSize: 40,
                    splashRadius: 20,
                    splashColor:Colors.deepPurple,
                    hoverColor: Colors.transparent,
                    highlightColor:Colors.transparent ,
                    focusColor:Colors.transparent ,

                  ),
                  IconButton(onPressed: () {
                    _launchSocialMediaAppIfInstalled(
                      url: 'https://wa.link/1f0hbc/', // Facebook
                    );
                  }, icon:
                  const Image(
                    image: AssetImage('assets/redesSociales/whatsapp_.png'),
                    fit: BoxFit.contain,
                    //height: 60,
                  ),
                    iconSize: 40,
                    splashRadius: 20,
                    //splashColor:Colors.deepPurple,
                    hoverColor: Colors.transparent,
                    highlightColor:Colors.deepPurple,
                    focusColor:Colors.transparent ,
                    //const Icon(Icons.insta, color:Colors.blue, size:40)
                  ),
                ],
              ),
              Card(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                elevation: 5,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),),
                color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // _pages[_selectedTab],
                    Container(
                        color:Colors.transparent,

                        // margin: EdgeInsets.symmetric(horizontal: 21.0),
                        //margin: const EdgeInsets.all(10),
                        margin: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                        child: Center(
                            child: Container(

                                height: 140,
                                width: 140,
                                decoration:BoxDecoration(
                                 // color:Colors.transparent,
                                  //color:Colors.white,
                                  color:Colors.grey,
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
                                child: ElevatedButton(
                                  onPressed: () {

                                    context.goNamed("HomeUsuarios");
                                    //Navigator.push( context, MaterialPageRoute(builder: (context) => webViewContainer()),);
                                    },
                                  style: ElevatedButton.styleFrom(fixedSize: const Size(140, 140), backgroundColor:Colors.indigo,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))

                                  ),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    runAlignment:WrapAlignment.center,
                                    direction: Axis.vertical,
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
                                    ],),)
                            ))),
                    Container(
                        color:Colors.transparent,

                        margin: const EdgeInsets.fromLTRB(0, 20, 10, 10),
                        // margin: EdgeInsets.symmetric(horizontal: 15.0),
                        // margin: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                        child: Center(
                            child: Container(

                                height: 140,
                                width: 140,

                                decoration:BoxDecoration(
                                  color:Colors.grey,
                                  //color:Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.greenAccent,
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
                                    //Navigator.push( context, MaterialPageRoute(builder: (context) => webViewContainer()),);
                                    context.goNamed("HomeServicios");
                                   // context.pushNamed("HomeServicios"); //*******************
                                   // GoRouter.of(context).pushNamed("HomeServicios");
                                    },
                                  style: ElevatedButton.styleFrom(alignment:Alignment.center,fixedSize: const Size(140, 140), backgroundColor: Colors.greenAccent,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                  ),
                                  child:

                                  Center(child:Wrap(
                                    //spacing: -10,
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    runAlignment:WrapAlignment.center,
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Icon(
                                        Icons.home_repair_service_rounded,
                                        color: Colors.white,
                                        grade:0.25,
                                        size: 80.0,
                                      ),
                                      SizedBox(
                                        width:10,
                                        // height: 50,
                                      ),
                                      Text("Servicios", style:TextStyle(fontSize:20, color:Colors.white), textAlign: TextAlign.center, ),
                                    ],
                                  ),),
                                )
                            )
                        )
                    ),
                  ]
              ),




              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Container(
                        color:Colors.transparent,
                        margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        // margin: EdgeInsets.symmetric(horizontal: 21.0),
                        //margin: const EdgeInsets.all(10),
                        // margin: const EdgeInsets.fromLTRB(30, 30, 5, 10),
                        child: Center(
                            child: Container(

                                height: 140,
                                width: 140,

                                decoration:BoxDecoration(
                                  //color:Colors.grey.shade300,
                                  //color:Colors.white,
                                  color:Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.lightBlueAccent,
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
                                   // context.goNamed("HomeConfiguraciones");
                                    context.goNamed("HomeRouterPage");

                                    //Navigator.push( context, MaterialPageRoute(builder: (context) =>menu_configuraciones()),);

                                    },
                                  style: ElevatedButton.styleFrom(fixedSize: const Size(140, 140), backgroundColor:Colors.lightBlueAccent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                  ),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    runAlignment:WrapAlignment.center,
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Icon(
                                        Icons.router_outlined,
                                        color: Colors.white,
                                        size: 90.0,
                                      ),
                                      SizedBox(
                                        width:10,
                                        // height: 50,
                                      ),
                                      Text("Router", style:TextStyle(fontSize:20, color:Colors.white), textAlign: TextAlign.center, ),
                                    ],
                                  ),
                                )
                            )
                        )
                    ),
                    Container(
                        color:Colors.transparent,
                        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),


                        // margin: EdgeInsets.symmetric(horizontal: 15.0),
                        // margin: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                        child: Center(
                            child: Container(

                                height: 140,
                                width: 140,

                                decoration:BoxDecoration(
                                  //color:Colors.grey.shade300,
                                  //color:Colors.white,
                                  color:Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.lightGreenAccent,
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
                                   //context.goNamed("HomeOtrosServicios");
                                   // Navigator.push( context, MaterialPageRoute(builder: (context) => playLinkEntretenimiento()),);
                                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                      //builder: (context) =>  playLinkEntretenimiento(),));
                                        builder: (context) =>  VideoPlayerPage(),));
                                    },
                                  style: ElevatedButton.styleFrom(fixedSize: const Size(140, 140), backgroundColor: Colors.lightGreenAccent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                  ),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    runAlignment:WrapAlignment.center,
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Icon(
                                        Icons.live_tv,
                                        color: Colors.white,
                                        size: 90.0,
                                      ),
                                      SizedBox(
                                        width:10,
                                        // height: 50,
                                      ),
                                      Text("Tv", style:TextStyle(fontSize:30, color:Colors.white), textAlign: TextAlign.center, ),
                                    ],
                                  ),
                                )
                            )
                        )
                    ),
                  ]
              ),
                  SizedBox(height: 20,),
                ],

              ),),
              //  ),

            ]

        ),
    ),
      ),
         ]),
      ): Center(child: CircularProgressIndicator()),
    );
  }
  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(milliseconds: 20));
    setState(() {
    });
    return null;
  }
  List<String> _listImagenes(data) {

    List<String> imagenes=[];
    //print("tamaño"+data.length.toString());
    for(var img in data)
    {
      imagenes.add(
          img.imagen
          //Image.network(img.imagen,fit: BoxFit.fill),
        /*Container(
          margin: EdgeInsets.all(6.0),
          // margin: const EdgeInsets.fromLTRB(6, 6, 6, 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(img.imagen),
              fit: BoxFit.cover,

            ),),),*/
       /* Card(child:
        Column(
          children: [
            Image.network(img.imagen),
            Padding(
                padding:const EdgeInsets.all(8.0),
                child: Text(img.id)
            ),
          ],
        ),
        ),
*/

        /*CarouselSlider(
          items: [
            Image.network(img.imagen),
           ],
          //Slider Container properties
          options: CarouselOptions(
            height: 220.0,

            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 9 / 16,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),),*/

      );
    }
    return imagenes;
  }

  Future<void> _launchSocialMediaAppIfInstalled({
  required String url,
  }) async {
    try {
      bool launched = await launchUrl(Uri.parse(url) ); // Launch the app if installed!

      if (!launched) {
        launchUrl(Uri.parse(url)); // Launch web view if app is not installed!
      }
    } catch (e) {
      launchUrl(Uri.parse(url)); // Launch web view if app is not installed!
    }
  }
}
/*      CarouselSlider(
                      items: [
                        //1st Image of Slider
                        Container(
                          margin: EdgeInsets.all(6.0),
                          // margin: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage("https://images.unsplash.com/photo-1579649554660-463ed1d72831?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmViZSUyMGtvYWxhfGVufDB8fDB8fHww&w=1000&q=80"),
                              fit: BoxFit.cover,

                            ),),),

                        //2nd Image of Slider
                        Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage("https://images.unsplash.com/photo-1579649554660-463ed1d72831?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmViZSUyMGtvYWxhfGVufDB8fDB8fHww&w=1000&q=80"),
                              fit: BoxFit.cover,
                            ),),),

                        //3rd Image of Slider
                        Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage("https://images.unsplash.com/photo-1579649554660-463ed1d72831?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmViZSUyMGtvYWxhfGVufDB8fDB8fHww&w=1000&q=80"),
                              fit: BoxFit.cover,
                            ),),),

                        //4th Image of Slider
                        Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage("https://images.unsplash.com/photo-1579649554660-463ed1d72831?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmViZSUyMGtvYWxhfGVufDB8fDB8fHww&w=1000&q=80"),
                              fit: BoxFit.cover,
                            ),),),

                        //5th Image of Slider
                        Container(

                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage("https://images.unsplash.com/photo-1579649554660-463ed1d72831?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmViZSUyMGtvYWxhfGVufDB8fDB8fHww&w=1000&q=80"),
                              fit: BoxFit.cover,
                            ),),),],
                      //Slider Container properties
                      options: CarouselOptions(
                        height: 220.0,

                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 9 / 16,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),)*/
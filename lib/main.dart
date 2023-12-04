import 'package:fastsystems_app2/menuConfiguraciones.dart';

import 'package:fastsystems_app2/webViewContainerUser.dart';
import 'package:fastsystems_app2/webViewContainerRouter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'menuNavigationBar.dart';


void main()async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,overlays:[]);
    SystemChrome.setPreferredOrientations([

      DeviceOrientation.portraitUp,
     // DeviceOrientation.portraitDown,
    ]).then((value) => runApp(
      MaterialApp(

        debugShowCheckedModeBanner:false,
        //home:BottomNavBar(),//iniciar con el menu
        //home:AppNavigation();

        routes:{
          '/':(context)=>const Home(),
          //'/ubicacionEmpresa':(context)=>ubicacionPage(),
          //'/informacionEmpresa':(context)=>homePage(),
          '/webViewContainer':(context)=>webViewContainer(),
          '/ipAddress':(context)=>menu_configuraciones(),
          '/webViewContainerRouter':(context)=>webViewContainerRouter(""),

        },
      ),
    ));
    await FlutterDownloader.initialize(
        debug: true, // optional: set false to disable printing logs to console
      ignoreSsl: true
    );

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /*runApp(
    MaterialApp(

      debugShowCheckedModeBanner:false,
      routes:{
        '/':(context)=>Home(),
        '/ubicacionEmpresa':(context)=>ubicacionPage(),
        '/informacionEmpresa':(context)=>aboutPage(),
        '/webViewContainer':(context)=>webViewContainer(),
      },
    ),
  );*/
  FlutterNativeSplash.remove();

}

class Home extends StatefulWidget{
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();

  int? identifica(idMedia)
  {
    int id=idMedia;
    return id;
  }
}
class _HomeState  extends State <Home>{
@override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      /*ebugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,*/
      extendBody: true,
/*
      appBar: AppBar(
       // title: Text("FastSystems"),
        toolbarHeight: 20,
        elevation: 5,
        shadowColor: Colors.lightBlue,
        backgroundColor: Colors.white,
      ),*/
     body:content(),

    );
}

  Widget content()
  {
    return MaterialApp.router (
      routerConfig: AppNavigation.router,
      debugShowCheckedModeBanner: false,
    );
  }

}







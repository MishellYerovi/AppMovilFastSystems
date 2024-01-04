import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:fastsystems_app2/verifConexionInternet.dart';
import 'package:flutter/material.dart';
import 'package:keep_screen_on/keep_screen_on.dart';

import '../Modelo/enlacesTV.dart';


enum Source { Network }

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late CustomVideoPlayerController _customVideoPlayerController;
  late Future <List<enlacesTVPlay>> futureLinks;
  Source currentSource = Source.Network;

  Uri videoUri = Uri.parse(
      "https://redirector.rudo.video/hls-video/c54ac2799874375c81c1672abb700870537c5223/ecuavisa/ecuavisa.smil/playlist.m3u8?PlaylistM3UCL");
  //String assetVideoPath = "assets/videos/whale.mp4";
  var list;
  var refreshKey = GlobalKey<RefreshIndicatorState>();


  late bool isLoading = true;
  //bool fullscreen = false;
  //bool fullscreen2 = false;
  @override
  void initState() {
    super.initState();
    initializeVideoPlayer(currentSource);
    //fullscreen=_customVideoPlayerController.customVideoPlayerSettings.enterFullscreenOnStart;
    //fullscreen2=;
    //print("fullscreen controller"+fullscreen.toString());
    //print("fullscreen2 controller"+fullscreen2.toString());
    futureLinks=fetchEnlacesTV();
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    //print("se apaga la pantalla");
    KeepScreenOn.turnOff(); //Turn off automatic Screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //fullscreen=_customVideoPlayerController.customVideoPlayerSettings.enterFullscreenOnStart;
    //fullscreen2=_VideoPlayerPageState().fullscreen;
    //print("fullscreen controller w"+fullscreen.toString());
    //print("fullscreen2 controller w "+fullscreen2.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar:AppBar(
        backgroundColor: Colors.white,
        title:// Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          //children: [
           // Text("Tv", style: TextStyle(color: Colors.blue),),
            const Image(
              image: AssetImage('assets/icon.png'),
              fit: BoxFit.fill,
              height: 50,
            ),

         // ],
       // ),

        shape: const RoundedRectangleBorder(

            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:
      list == null
          ?
      RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,

      child: isLoading
          ? const Center(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WarningWidgetValueNotifier(),
              Image(
                image: AssetImage('assets/icon.png'),
                fit: BoxFit.fitHeight,
                height: 80,
                alignment: Alignment.center,
              ),
              SizedBox(height: 16.0),
              Text("Cargando..."),

            ],
               ),



        /*CircularProgressIndicator(
          color: Colors.red,
        ),*/
      ),)
          :
      ListView(
          //padding: EdgeInsets.fromLTRB(20, 100,20, 100),
          children:[
      SizedBox(
        child: Padding(
        padding:const EdgeInsets.fromLTRB(10, 0, 10, 0),
       //fullscreen ? EdgeInsets.zero : const EdgeInsets.only(top: 32.0),
        child:
           Column(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

                  const WarningWidgetValueNotifier(),
                  const SizedBox(height: 20),
               // _customVideoPlayerController.videoPlayerController.videoPlayerOptions?.allowBackgroundPlayback,
                  CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController,
                ),
                  const SizedBox(height: 30),
                  const Text("Canales de televisión", style: TextStyle(fontSize:18,fontWeight: FontWeight.bold, color: Colors.blue)),
                  const SizedBox(height: 5),
                  _listaDeCanales(),
            ],
      ),

    ),
    ),
     ]),
         ):const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _listaDeCanales() {
    //fullscreen=_customVideoPlayerController.customVideoPlayerSettings.enterFullscreenOnStart;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        ListView(
          shrinkWrap: true,
          children:[
            FutureBuilder(
              future:  fetchEnlacesTV(),
              builder: (BuildContext context,snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) { //Este estado indica que el futuro se está resolviendo actualmente y recibiremos el resultado en breve.
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.indigoAccent,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) { //Esto denota la finalización del futuro.
                  if (snapshot.hasError) {
                    return Center(
                      child:

                      /*Text(
                        ' ${snapshot.error} ',
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),*/

                          Text(
                           // ' ${snapshot.error} ',
                            "Sin información",
                            style: const TextStyle(fontSize: 18, color: Colors.blue),
                          ),

                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    //print("longitud future" +data!.length.toString());
                    //em.id=data!.id.toString();
                    return
                      data?.length != 0?
                      Card(
                          //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          elevation: 5,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),),
                          color: Colors.lightBlueAccent,
                        //height: 240,
                         // child:Scrollbar(
                             // radius: const Radius.circular(50),
                              //thumbVisibility: true,
                              //trackVisibility: true,
                              //scrollbarOrientation: ScrollbarOrientation.top,
                              child:ListView(
                                padding: const EdgeInsets.all(30),
                                shrinkWrap: true,
                                children:

                                //  Padding(padding:EdgeInsets.all(8.0)), //Espacio
                                _listEnlcesTV(data!),

                              )
                          //)
                      )
                          : Container( alignment: Alignment.center, child:const Text("No existe información"));
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: "Cargando...",
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),

                  ),
                );
              },)
          ],
        ),

      ],
    );
  }
  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(milliseconds: 20));
    setState(() {
    });
    return null;
  }
  void initializeVideoPlayer(Source source) {
    setState(() {

      isLoading = true;
      // Keep the screen on.
      KeepScreenOn.turnOn();
      //print("Se activa para mantener activa la pantalla");
      //
     //fullscreen=_customVideoPlayerController.customVideoPlayerSettings.enterFullscreenOnStart;
    });
    VideoPlayerController _videoPlayerController;

   /* if (source == Source.Asset) {
     // _videoPlayerController = VideoPlayerController.asset(assetVideoPath)
        ..initialize().then((value) {
          setState(() {
            isLoading = false;
          });
        });
    } else */if (source == Source.Network) {
      _videoPlayerController = VideoPlayerController.networkUrl(videoUri)
        ..initialize().then((value) {
          setState(() {
            isLoading = false;
          });
        });
    } else {
      return;
    }
    _customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: _videoPlayerController);

  }

  List<Widget>  _listEnlcesTV(data) {
    List<Widget> listTV=[];
    //print("tamaño"+data.length.toString());
    for(var enlaces in data)
    {
      listTV.add(
        Card(
          //margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          elevation: 3,
          color: Colors.white,
          shadowColor: Colors.lightBlue,
          surfaceTintColor: Colors.lightBlueAccent,
          child:
          Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              //const Padding(padding:EdgeInsets.all(8.0)),
              //Cargar Imagen - Lista
              //Image.network(admin.imagen),
              const Padding(padding:EdgeInsets.all(8.0)), //Espacio
              ListTile(
                title: Text(enlaces.nombreEnlace, style: const TextStyle(fontWeight: FontWeight.bold),),
                // subtitle: Text(enlaces.enlace),
                trailing:
                IconButton(onPressed: () {

                  setState(() {
                    _customVideoPlayerController.dispose();
                    videoUri=Uri.parse(enlaces.enlace) ;
                    currentSource = Source.Network;
                    initializeVideoPlayer(currentSource);
                    _customVideoPlayerController.videoPlayerController.play();
                    //_customVideoPlayerController.playedOnceNotifier;
                    //_customVideoPlayerController.customVideoPlayerSettings.playOnlyOnce;
                  });
                 // print("reproductor");
                  //print("enlace:"+enlaces.enlace);
                  //reproducirCanal(enlaces.enlace);
                  //editarFormAdmi;n(admin.id, admin.nombreAdmin, admin.emailAdmin);
                }, icon: const Icon(Icons.play_circle_outline_outlined, color:Colors.blue, size:40)),

              ),


              const Padding(padding:EdgeInsets.all(8.0) ), //ESPACIO
            ],
          ),
        ),

      );
    }
    return listTV;
  }
}

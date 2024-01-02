import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

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

  late bool isLoading = true;
  bool fullscreen = false;
  bool fullscreen2 = false;
  @override
  void initState() {
    super.initState();
    initializeVideoPlayer(currentSource);
    fullscreen=_customVideoPlayerController.customVideoPlayerSettings.enterFullscreenOnStart;
    //fullscreen2=;
    //print("fullscreen controller"+fullscreen.toString());
    //print("fullscreen2 controller"+fullscreen2.toString());
    futureLinks=fetchEnlacesTV();
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fullscreen=_customVideoPlayerController.customVideoPlayerSettings.enterFullscreenOnStart;
    fullscreen2=_VideoPlayerPageState().fullscreen;
    //print("fullscreen controller w"+fullscreen.toString());
    //print("fullscreen2 controller w "+fullscreen2.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.white,
        title: const Image(
          image: AssetImage('assets/icon.png'),
          fit: BoxFit.fitHeight,
          height: 50,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/icon.png'),
              fit: BoxFit.fitHeight,
              height: 50,
            ),
            SizedBox(height: 16.0),
            Text("Cargando..."),
          ],
        ),
        /*CircularProgressIndicator(
          color: Colors.red,
        ),*/
      )
          :
      ListView(
          //padding: EdgeInsets.fromLTRB(20, 100,20, 100),
          children:[
      SizedBox(
    child: Padding(
    padding:

   fullscreen ? EdgeInsets.zero : const EdgeInsets.only(top: 32.0),
    child:
           Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
            CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController,

            ),

            _sourceButtons(),
        ],
      ),

    ),
    ),
     ]),
    );
  }

  Widget _sourceButtons() {
    fullscreen=_customVideoPlayerController.customVideoPlayerSettings.enterFullscreenOnStart;
    return Column(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      color: Colors.white,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) { //Esto denota la finalización del futuro.
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        ' ${snapshot.error} ',
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    //print("longitud future" +data!.length.toString());
                    //em.id=data!.id.toString();
                    return
                      data?.length != 0?
                      Container(
                        //height: 240,
                          child:Scrollbar(
                              radius: const Radius.circular(50),
                              //thumbVisibility: true,
                              trackVisibility: true,
                              //scrollbarOrientation: ScrollbarOrientation.top,
                              child:ListView(
                                padding: const EdgeInsets.all(10),
                                shrinkWrap: true,
                                children:
                                //  Padding(padding:EdgeInsets.all(8.0)), //Espacio
                                _listEnlcesTV(data!),

                              )))
                          : Container( alignment: Alignment.center, child:const Text("No existe información"));
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: "Cargando...",
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),

                  ),
                );
              },)
          ],
        ),


       /* MaterialButton( ---- ListView para canales
          color: Colors.red,
          child: const Text(
            "Otro canal",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {

            setState(() {
              _customVideoPlayerController.dispose();
              videoUri=Uri.parse("https://playout.cdn.cartoonnetwork.com.br/playout_04/playlist.m3u8" ) ;
              currentSource = Source.Network;
              initializeVideoPlayer(currentSource);
            });
          },
        ),*/



       /* MaterialButton(
          color: Colors.red,
          child: const Text(
            "Asset",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            setState(() {
              currentSource = Source.Network;
              initializeVideoPlayer(currentSource);
            });
          },
        ),*/
      ],
    );
  }

  void initializeVideoPlayer(Source source) {
    setState(() {
      isLoading = true;
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
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          elevation: 15,
          color: Colors.white,
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
                  });
                 // print("reproductor");
                  //print("enlace:"+enlaces.enlace);
                  //reproducirCanal(enlaces.enlace);
                  //editarFormAdmi;n(admin.id, admin.nombreAdmin, admin.emailAdmin);
                }, icon: const Icon(Icons.play_circle_outline_outlined, color:Colors.deepPurpleAccent, size:40)),

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



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:flutter/material.dart' hide Router;
import 'home.dart';
import 'main.dart';
import 'menuNavigationBar.dart';


class playLinkEntretenimiento extends StatefulWidget {
  const playLinkEntretenimiento({super.key});

  @override
  State<playLinkEntretenimiento> createState() => _playLinkEntretenimientoState();
}

class _playLinkEntretenimientoState extends State<playLinkEntretenimiento> {
  List<String> myList =[];


  bool fullscreen = false;
  //Main verificar=new Main("");
  Future verif() async{
    Main("si");
  }

@override
  void initState() {
    setState(() {
     // print("verificar set state");
      verif();
      //myList.add("https://redirector.rudo.video/hls-video/c54ac2799874375c81c1672abb700870537c5223/ecuavisa/ecuavisa.smil/playlist.m3u8?PlaylistM3UCL");
      //myList.add("2018");
     /* MaterialApp.router (
        routerConfig:AppNavigation.router2 ,
        debugShowCheckedModeBanner: false,
      );*/
    });
   // GoRouter.of(.)

    super.initState();
   // idM.identifica(idMedia);
    //idM.identifica(idMedia);
  }


  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: fullscreen == false
          ? AppBar(
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
      )
          : null,
      body:

      ListView(

         // padding: EdgeInsets.fromLTRB(20, 100,20, 100),
          children:[
      SizedBox(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         // SizedBox(height: 10.0),
      Padding(
        padding:
        fullscreen ? EdgeInsets.zero : const EdgeInsets.only(top: 32.0),
        child: YoYoPlayer(
          aspectRatio: 16 / 9,
          url:
         "https://vivo.canaloncelive.tv/alivepkgr3/ngrp:cepro_all/playlist.m3u8",//canal 11 Mexico
          //"https://redirector.rudo.video/hls-video/c54ac2799874375c81c1672abb700870537c5223/ecuavisa/ecuavisa.smil/playlist.m3u8?PlaylistM3UCL", //ecuavisa
          //"https://playout.cdn.cartoonnetwork.com.br/playout_04/playlist.m3u8", //cartoon
          allowCacheFile: true,
          onCacheFileCompleted: (files) {
            print('Cached file length ::: ${files?.length}');

            if (files != null && files.isNotEmpty) {
              for (var file in files) {
                print('File path ::: ${file.path}');
              }
            }
          },
         // onFastForward: ,
          onCacheFileFailed: (error) {
            print('Cache file error ::: $error');
          },
          videoStyle: const VideoStyle(
            qualityStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            fullscreenIcon: Icon(
              Icons.fullscreen_rounded,
              size: 40.0,
              color: Colors.blueAccent
            ),
            forwardAndBackwardBtSize: 30.0,
            playButtonIconSize: 40.0,
            playIcon: Icon(
              Icons.play_circle_outline_outlined,
              size: 40.0,
              color: Colors.white,
            ),
            pauseIcon: Icon(
              Icons.pause_circle_outline_outlined,
              size: 40.0,
              color: Colors.white,
            ),
            videoQualityPadding: EdgeInsets.all(5.0),
            //showLiveDirectButton: true,
            // enableSystemOrientationsOverride: false,
           // forwardIcon : Icon(Icons.skip_next),
           // backwardIcon : Icon(Icons.skip_previous),
          ),

         /* onFastForward: (value) {
          "https://playout.cdn.cartoonnetwork.com.br/playout_04/playlist.m3u8";
            //onFastForward?.call(value);
          },
          onRewind: (value) {
            "https://vivo.canaloncelive.tv/alivepkgr3/ngrp:cepro_all/playlist.m3u8";
            //onRewind?.call(value);
          },*/
          videoLoadingStyle: const VideoLoadingStyle(
            loading: Center(
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
                  Text("Cargando el video..."),
                ],
              ),
            ),
          ),
          onFullScreen: (value) {
            setState(() {
              if (fullscreen != value) {
                fullscreen = value;
              }

            });
          },
        ),
      ),
           /*Padding(padding: fullscreen ? EdgeInsets.zero : const EdgeInsets.only(top: 32.0),
             child:Text("hola2"),
           )*/

           /* FutureBuilder(
              future:  fetchAdministrador(),
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
                                _listAdministradores(data!),

                              )))
                          : Container( alignment: Alignment.center, child:const Text("No existen administradores"));
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: "Cargando...",
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),

                  ),
                );
              },)*/
       ]),
    ),
     ]),

    );
  }


}

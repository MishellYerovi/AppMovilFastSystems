

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

  bool fullscreen = false;
  //Main verificar=new Main("");
  Future verif() async{
    Main("si");
    //Navigator.pushReplacement(context, playLinkEntretenimiento() as Route<Object?> );
    //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    //context.pushReplacementNamed("HomeAdminMenu");
    print("verificar asincrono");
  }

  /*Future hide() async{
    //FullScreen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  // to hide only bottom bar:
  SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

// to hide only status bar:
  SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

// to hide both:
  SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);

  }*/
 /* Uri uri = Uri.parse("https://youtu.be/ENHYOYm-kUE");
  //MediaSource mediaSource = buildMediaSource(uri);
  DataSource.Factory dataSourceFactory =
  new DefaultHttpDataSourceFactory(Util.getUserAgent(this, "app-name"));
  HlsMediaSource hlsMediaSource =
  new HlsMediaSource.Factory(dataSourceFactory).createMediaSource(uri);
  player = ExoPlayerFactory.newSimpleInstance(this);
  player.setPlayWhenReady(playWhenReady);
  player.seekTo(currentWindow, playbackPosition);*/

  // Create a player instance.

  // Prepare the player with the media source.
  //player.prepare(mediaSource);
  //flutter pub add better_player_hls
@override
  void initState() {
    setState(() {
     // print("verificar set state");
      verif();
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
      body: Padding(
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
              Icons.fullscreen_outlined,
              size: 40.0,
              color: Colors.white
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
            // showLiveDirectButton: true,
            // enableSystemOrientationsOverride: false,
          ),
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

    );
  }


}

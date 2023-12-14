import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Modelo/download.dart';
import 'constantes/const.dart';
void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  /*await FlutterDownloader.initialize(
      debug: true, // optional: set false to disable printing logs to console
      ignoreSsl: true,
  );*/
  FlutterDownloader.registerCallback((id, status, progress) { });
  //await Permission.storage.request();
  runApp(const webViewContainer());
}

class webViewContainer extends StatefulWidget {
  const webViewContainer({super.key});

  @override
  State<webViewContainer> createState() => _webViewContainerState();
}
List<String> split(Pattern pattern) {

  throw UnimplementedError();
}


class _webViewContainerState extends State<webViewContainer> {
  ReceivePort _port = ReceivePort();
  Future<void> main() async {
    /*await FlutterDownloader.initialize(
        debug: true, // optional: set false to disable printing logs to console
        ignoreSsl: true
    );*/
    //ReceivePort _port = ReceivePort();
    /*IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus.fromInt((data[1]));
      int progress = data[2];
      setState((){ });
    }
    );
   // FlutterDownloader.registerCallback(downloadCallback);
    FlutterDownloader.registerCallback(downloadCallback);*/
  }


@override
  void initState() {
  super.initState();
  IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
  _port.listen((dynamic data) {
    String id = data[0];
    DownloadTaskStatus status = DownloadTaskStatus.fromInt((data[1]));
    int progress = data[2];
    setState((){ });
  }
  );
  // FlutterDownloader.registerCallback(downloadCallback);
  FlutterDownloader.registerCallback(downloadCallback);
   // main();

  }
@override
void dispose() {
  IsolateNameServer.removePortNameMapping('downloader_send_port');
  super.dispose();
}
@pragma('vm:entry-point')
static downloadCallback(String id, int status, int progress) {
  final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
  print("id=$id");
  print("status=$status");
  print("progress=$progress");
  //sleep(500000 as Duration);
  send!.send([id, status, progress]);
}
  late InAppWebViewController _webViewController;
  //final controller=WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
  //..loadRequest(Uri.parse('http://pagos.fastsystems.ec:8090/cliente/login'));
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        useOnDownloadStart: true, //======================Very Important
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(

        useHybridComposition: true,
        supportMultipleWindows: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // extendBodyBehindAppBar: true,
      //extendBody: false,
      //extendBodyBehindAppBar: true,
      // extendBody: true,
      extendBody: false,
      //  backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          /*shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(2),
              )),*/
          //toolbarHeight: 0,
          elevation: 5,
          shadowColor: Colors.blueAccent,
          backgroundColor: Colors.blueAccent,
          title: Text(("Portal Usuarios")),
          /*actions: [
          Icon(null),
        ],*/
        ),
        body:
       // ListView(
          //  children: <Widget>[
        SizedBox(

            //width: double.infinity,
            //height: double.infinity,
            child:
        Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
         Expanded(
           flex:1,
           child:
               Center(
                 child: Container(
                   color: Colors.transparent,
                          //margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                       // decoration: BoxDecoration(border: Border.all(color: Colors.transparent)

                        child: InAppWebView(
                            gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                       // initialUrlRequest:URLRequest( url: Uri.parse('https://www.librocristiano.com.ar/amar-es-para-valientes-itiel-arroyo')),

                          //initialUrlRequest:URLRequest( url: Uri.parse('http://www.pdf995.com/samples/pdf.pdf')),///'
                           initialUrlRequest:URLRequest( url: Uri.parse('$portalCliente')),
                          initialOptions: InAppWebViewGroupOptions(

                            crossPlatform: InAppWebViewOptions(
                              useOnDownloadStart: true,
                              allowFileAccessFromFileURLs: true,
                              allowUniversalAccessFromFileURLs: true,
                              useShouldOverrideUrlLoading: true,
                              useOnLoadResource: true,
                              disableVerticalScroll: true,
                              transparentBackground: true,

                          //    useOnLoadResource: true,
                            //  useShouldOverrideUrlLoading: true,
                             // javaScriptEnabled: true,
                            ),), onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                      },

                          //  onLoadStart:   (controller, url) async {
                            //                               //main();
                          //onLoadStart: ,

                       onDownloadStartRequest: (controller, url) async {

                             //print (runtimeType.toString());
                             // main();
                            //main();
                            //await  FlutterDownloader.registerCallback(downloadCallback);
                            /*await  FlutterDownloader.registerCallback((id, status, progress) {

                              //downloadCallback(id,status as DownloadTaskStatus,progress);
                            });*/
                            var urlParametros=url.toString().split(",");
                            var urlModificada= urlParametros[0].replaceAll("{url:", "");
                            //final status = await Permission.storage.request();
                            final permission = await storagePermission();
                            debugPrint('permission : $permission');
                            //var memoria= await getExternalStorageDirectory();
                            final taskId;

                            try {
                            if (permission) {


                               taskId= await FlutterDownloader.enqueue(

                             // url:  "$urlModificada",
                                 url:url.url.toString(),
                               timeout:1000000,
                                allowCellular: true,
                                saveInPublicStorage: true,
                                savedDir: (await getExternalStorageDirectory())!.path,
                                requiresStorageNotLow: true,
                                showNotification: true, // show download progress in status bar (for Android)
                                openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                                fileName: "Doc_FastSystems8"

                             ).then((value)  {

                             var duration = const Duration(seconds: 2);
                             print('Start sleeping');
                             sleep(duration);
                             print('2 seconds has passed');
                              //print("value="+value.toString());
                                         print("completed");
                                    });

                                    } else {
                                       setState(() {
                                    print("failed");
                                    });
                                    print('Permission Denied');
                                    }


                                    } on FlutterDownloaderException catch (err) {
                            print('Failed to enqueue. Reason: ${err.message}');
                                      }
                            //await FlutterDownloader.registerCallback(downloadCallback);

                            //await FlutterDownloader.registerCallback(downloadCallback);
                                  }//Download
                        ),),),

    ),

    Container(
      alignment: Alignment.bottomCenter,
     // padding: EdgeInsets.all(20),
      height: 70,
      //width: 40,
      color: Colors.blueAccent

    ),
    ]),

    )
    //]),
    );

  }
  /*downloadCallback(
      String id,
      DownloadTaskStatus status ,
      int progress,
  //int st=DownloadTaskStatus status as int,
      ) {
    print(
      'Callback on background isolate: '
          'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status as int , progress]);
  }*/
  Future<bool> storagePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
    debugPrint('releaseVersion : ${androidInfo.version.release}');
    final int androidVersion = int.parse(androidInfo.version.release);
    bool havePermission = false;

    if (androidVersion >= 13) {
      final request = await [
        Permission.videos,
        Permission.notification,
        //Permission.photos,
        //Permission.manageExternalStorage,
       // Permission.notification,
        //Permission.storage,
        //..... as needed
      ].request(); //import 'package:permission_handler/permission_handler.dart';
      havePermission = request.values.every((status) => status == PermissionStatus.granted);
      print( androidVersion );
      print( havePermission);
    } else {
      final status = await Permission.storage.request();
      havePermission = status.isGranted;
    }

    if (!havePermission) {
      // if no permission then open app-setting
      await openAppSettings();
    }

    return havePermission;
  }
}
/* Directory? tempDir =
        await getExternalStorageDirectory();
        setState(() {});
        print(
            "onDownload ${url.url.toString()}\n ${tempDir!.path}");
        await FlutterDownloader.enqueue(
          url: url.url.toString(),
          fileName: url.suggestedFilename, //================File Name
          savedDir: tempDir.path,
          showNotification: true,
          requiresStorageNotLow: false,
          openFileFromNotification: true,
          saveInPublicStorage: true,
        );*/

/*onDownloadStartRequest: (InAppWebViewController controller, url) async {
        print("onDownloadStart $url");
        final taskId = await FlutterDownloader.enqueue(
          url:'http://pagos.fastsystems.ec:8090/cliente/login',
          savedDir: (await getExternalStorageDirectory())!.path,
          showNotification: true, // show download progress in status bar (for Android)
          openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        );
      },*/
//))
//])),);
/*
    onDownloadStartRequest: (controller, url)
    async { Directory? tempDir =
    await getExternalStorageDirectory();
    setState(() {});
    print(
    "onDownload ${url.url.toString()}\n ${tempDir!.path}");
    await FlutterDownloader.enqueue(
    url: url.url.toString(),
    fileName: url.suggestedFilename, //================File Name
    savedDir: tempDir.path,
    showNotification: true,
    requiresStorageNotLow: false,
    openFileFromNotification: true,
    saveInPublicStorage: true,
    );
    },
      */





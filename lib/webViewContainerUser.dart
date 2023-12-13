import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

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
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true, // optional: set false to disable printing logs to console
      ignoreSsl: false
  );
  FlutterDownloader.registerCallback((id, status, progress) { });
  await Permission.storage.request();
  runApp(webViewContainer());
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

@override
  void initState() {

  IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
  _port.listen((dynamic data) {
    String id = data[0];
    DownloadTaskStatus status = DownloadTaskStatus.fromInt((data[1]));
    int progress = data[2];
    setState((){ });
  }
  );

 // FlutterDownloader.registerCallback( downloadCallback as DownloadCallback);
    super.initState();
  }
/*@override
void dispose() {
  IsolateNameServer.removePortNameMapping('downloader_send_port');
  super.dispose();
}
  /*static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }*/
//@pragma('vm:entry-point')
static voiddownloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
  send!.send([id, status , progress]);
}*/

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
                           // onLoadStart: ,
                          onDownloadStartRequest: (controller, url) async {
                            //onLoadStart: (controller, url) async {
                              //FlutterDownloader.initialize();
                            //  FlutterDownloader.registerCallback(downloadCallback as DownloadCallback);
                            //sleep(3000 as Duration);
                           // final String u=url.toString();
                           // final newValue = u.replaceAll("&d=.pdf", "");
                              
                              var urlParametros=url.toString().split(",");
                           // print("link:hola2"+url.toString());
                          //  print(urlParametros);
                           //=arr[0].split("{url:");
                             // print(arr2[0]);
                            var urlModificada= urlParametros[0].replaceAll("{url:", "");
                                //.replaceAll("-", "");
                             // print(urlModificada);
                          //  print("link:hola2"+ url!.host.toString());
                            var datos=
                           // var arr = string.split('-');
                            //final taskId =
                            await FlutterDownloader.enqueue(
                              //url: url.data.uri,

                              url: "$urlModificada",
                              //url: url.path,
                                 //url:"http://pagos.fastsystems.ec:8090/cliente/ajax/viewdoc?token=WUhQQUlqdEVEc1IvYjdmb2piMkgzUT09&id=9273&action=invoice&d=.pdf" ,
                                fileName: "DOC_fastsystems4",
                                allowCellular: true,
                                saveInPublicStorage: true,
                                savedDir: (await getExternalStorageDirectory())!.path,
                                timeout:10000,
                                showNotification: true, // show download progress in status bar (for Android)
                                openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                            // );



                             // print("ondownloadstart $url");

                            //  print("value: $newValue");
                             /* onDownloadStartRequest: (controller, url)
                              async {
                                final String u=url.toString();
                                final newValue = u.replaceAll("&d=.pdf", "");
                            Directory? tempDir =
                              await getExternalStorageDirectory();
                              setState(() {});
                              print("onDownload ${url.toString()}\n ${tempDir!.path}");
                                  //"onDownload ${url}\n ${tempDir!.path}");
                              await FlutterDownloader.enqueue(
                                url: newValue,
                                //timeout: 1000,
                                fileName: url.suggestedFilename, //================File Name
                                savedDir: tempDir.path,
                                showNotification: true,
                                requiresStorageNotLow: false,
                                openFileFromNotification: true,
                                saveInPublicStorage: true,
                              );*/

                              /*final String url_files = "$url"  ;

                              void _launchurl_files() async =>
                                  await canLaunchUrlString(newValue)? await launchUrlString(newValue) : throw 'could not launch $url_files';
                              _launchurl_files();
                              */



                            ); }


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





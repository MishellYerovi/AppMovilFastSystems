import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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


class _webViewContainerState extends State<webViewContainer> {


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

      extendBody: true,
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
                       // initialUrlRequest:URLRequest( url: Uri.parse('https://bibliaenpdf.com/')),

                          initialUrlRequest:URLRequest( url: Uri.parse('http://pagos.fastsystems.ec:8090/cliente/login')),
                            //initialUrlRequest:URLRequest( url: Uri.parse('https://canales.online/embed/eventos/?r=aHR0cHM6Ly9ibGFja2ZhY2Uud29ybGQvc3Rhcl9qd3AuaHRtbD9nZXQ9aHR0cHM6Ly9saXZlLWZ0Yy1uYS1zb3V0aC0yLm1lZGlhLnN0YXJvdHQuY29tL2NsdDIvdmEwMS9zdGFycGx1cy9ldmVudC8yMDIzLzExLzI4L05hdmJhaG9yX1VaQl92c19BbF9IaWxhbF9fMjAyMzExMjhfMTcwMTE4MTIwNTAzMi9jdHItYWxsLWNvbXBsZXRlLm0zdTgmaW1nPWh0dHBzOi8vcHJvZC1yaXBjdXQtZGVsaXZlcnkuZGlzbmV5LXBsdXMubmV0L3YxL3ZhcmlhbnQvc3Rhci9DRjdBMzMxOTIyRDQ4RUU2MEY1OEFGQ0ZBMkUxOTM1QTlCRjY1NDNBNTY1NkYyQTYzRkI1ODY2ODk1Q0JCRDlEL3NjYWxlP3dpZHRoPTE5MjAmYXNwZWN0UmF0aW89MS43OCZmb3JtYXQ9anBlZyZrZXk9YjkyNzZkOTUxODE5NDJmOTllZmMyZmY4M2M5NWY1OTgma2V5Mj1mNDJlY2IzMjFiZTI2MmU4YjAyY2E2YjNkYTE1NzRhMw')),
                          initialOptions: InAppWebViewGroupOptions(

                            crossPlatform: InAppWebViewOptions(
                              useOnDownloadStart: true,
                              allowFileAccessFromFileURLs: true,
                              allowUniversalAccessFromFileURLs: true,
                              useShouldOverrideUrlLoading: true,
                              disableVerticalScroll: false,
                              transparentBackground: false,
                          //    useOnLoadResource: true,
                            //  useShouldOverrideUrlLoading: true,
                              //javaScriptEnabled: true,
                            ),), onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                      },
                          onDownloadStartRequest: (controller, url) async {
                           // final String u=url.toString();
                           // final newValue = u.replaceAll("&d=.pdf", "");
                            final taskId = await FlutterDownloader.enqueue(
                                url: "$url" ,
                                fileName: "DOC",

                                savedDir: (await getExternalStorageDirectory())!.path,
                                showNotification: true, // show download progress in status bar (for Android)
                                openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                            // );
                              saveInPublicStorage: true,

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







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
  runApp(webViewContainerRouter(""));
}

class webViewContainerRouter extends StatefulWidget {

  String router;
  webViewContainerRouter(this.router);

  @override
  State<webViewContainerRouter> createState() => _webViewContainerRouterState();
}


class _webViewContainerRouterState extends State<webViewContainerRouter> {


  late InAppWebViewController _webViewController;
  //final controller=WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
  //..loadRequest(Uri.parse('http://pagos.fastsystems.ec:8090/cliente/login'));
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        useOnDownloadStart: true, //para descargar archivos
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

        appBar: AppBar(
         // toolbarHeight: 40,
          elevation: 5,
          shadowColor: Colors.lightBlueAccent,
          backgroundColor: Colors.lightBlueAccent,
          title: Text(("Cambiar contraseña")),
          /*actions: [
          Icon(null),
        ],*/
        ),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[ Expanded(
            child:
            Container(

              child:

              InAppWebView(
                //initialUrlRequest:URLRequest( url: Uri.parse('https://bibliaenpdf.com/')),
                //Llama el argumento ip router de la clase ipAddress
                 initialUrlRequest:URLRequest( url: Uri.parse('http://'+ widget.router.toString()+'/')),
                // initialUrlRequest:URLRequest( url: Uri.parse('http://172.16.0.5')),

                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      useOnDownloadStart: true,
                  allowFileAccessFromFileURLs: true,
                  allowUniversalAccessFromFileURLs: true,
                  useShouldOverrideUrlLoading: true,
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
                      timeout: 3000,
                        showNotification: true, // show download progress in status bar (for Android)
                        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                    // );
                        saveInPublicStorage: true,
                      allowCellular: true,

                    );

                 }),
            ),
    ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      // padding: EdgeInsets.all(20),
                      height: 70,
                      //width: 40,
                      color: Colors.lightBlueAccent

                  ),
                ])));



  }
}




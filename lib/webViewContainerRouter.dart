

import 'dart:io';

import 'package:fastsystems_app2/verifConexionInternet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_info_plugin_plus/wifi_info_plugin_plus.dart';

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true, // optional: set false to disable printing logs to console
      ignoreSsl: false
  );
  FlutterDownloader.registerCallback((id, status, progress) { });
  await Permission.storage.request();
*/

  runApp(webViewContainerRouter());
}

class webViewContainerRouter extends StatefulWidget {

  //late String router;
  //webViewContainerRouter(this.router);

  @override
  State<webViewContainerRouter> createState() => _webViewContainerRouterState();


}


class _webViewContainerRouterState extends State<webViewContainerRouter> {
  Future<String?>getData() async {
    final info = NetworkInfo();
    //var wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    //var wifiIP = await info.getWifiIP(); // 192.168.1.1
    var wifiIP2 = await info.getWifiGatewayIP(); // 192.168.0.1 //Obtiene la puerta de enlace
    //print("puerta de enlace"+wifiIP2!);
    var wifiName = await info.getWifiName();
    return wifiIP2;

  }

  //Obtener informacion del router


  //String routerName;
  //String routerB;
 // WifiInfoWrapper? _wifiObject;  //example

  //Progreso de Carga
  late PullToRefreshController pullToRefreshController;
 InAppWebViewController? _webViewController;

  //InAppWebViewController? webViewController;
  double progress = 0;
// String urlModificada="";
  String router="";
  //Variables para Refrescar la página
  var list;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

@override
  void initState() {
  getData().then((value) {
    //setState(() {
      setState(() {
        router = value!;
      });
   // });
  });
  refreshList();
  //initPlatformState();

  super.initState();
  pullToRefreshController = PullToRefreshController(
    options: PullToRefreshOptions(
      color: Colors.blue,
    ),
    onRefresh: () async {
      if (Platform.isAndroid) {
        _webViewController?.reload();
      } else if (Platform.isIOS) {
        _webViewController?.loadUrl(
            urlRequest: URLRequest(url: await _webViewController?.getUrl()));
      }
    },
  );


  }
 /* Future<void> initPlatformState() async {
    WifiInfoWrapper? wifiObject;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}
    if (!mounted) return;

    setState(() {
      _wifiObject= wifiObject;
    });

  }*/



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
   // sleep(5000 as Duration);
   // print ("url:"+urlModificada);
  String r=router.toString();
    print ("router:"+router.toString());
    //Progreso de Carga

    return Scaffold(
  backgroundColor: Colors.white,
        appBar: AppBar(
         // toolbarHeight: 40,
          elevation: 5,
          shadowColor: Colors.lightBlueAccent,
          backgroundColor: Colors.lightBlueAccent,
          title: const Text(("Router")),
          /*actions: [
          Icon(null),
        ],*/
        ),
        body:
    //list == null
    //? RefreshIndicator(
    //key: refreshKey,
    //onRefresh: refreshList,
    //child:
   // r!=""?

        // ListView(
          // children: [


         SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,


                children: <Widget>[
                  const WarningWidgetValueNotifier(),
                  progress < 1.0
                      ? LinearProgressIndicator(value: progress, color: Colors.green,)
                      : Container(),
                  //const Text('Verifique su conexión'),
                 // const Text(''),
                  //const Text(''),
                  Expanded(
                    child:
                        Container(
                         // padding: EdgeInsets.fromLTRB(0, 0, 0, 65),
                          child:
                              r!=""?
                          InAppWebView(
                            initialUrlRequest:URLRequest( url: Uri.parse('http://$r/')),
                            //Llama el argumento ip router de la clase ipAddress
                            // initialUrlRequest:URLRequest( url: Uri.parse(urlModificada)),

                            // initialUrlRequest:URLRequest( url: Uri.parse('http://172.16.0.5')),
                            /*onLoadHttpError: (InAppWebViewController controller, Uri? url,
                                int i, String s) async {
                              /** instead of printing the console message i want to render a static page or display static message **/
                              webViewController?.loadFile(
                                  assetFilePath: "assets/icon.png");
                            } ,*/
                            pullToRefreshController: pullToRefreshController,
                              initialOptions: InAppWebViewGroupOptions(

                                crossPlatform: InAppWebViewOptions(

                                  useOnDownloadStart: true,
                              horizontalScrollBarEnabled: false,
                              allowFileAccessFromFileURLs: true,
                              verticalScrollBarEnabled: false,
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

                             },
                            onLoadStop: (controller, url) async {
                              pullToRefreshController.endRefreshing();
                              setState(() {
                                r=router;
                               // urlModificada=urlModificada;
                               // url =urlModificada as Uri? ;
                                //urlController.text = this.url;
                              });
                            },
                            onLoadError: (controller, url, code, message) {
                              pullToRefreshController.endRefreshing();
                              setState(() {
                              });
                            },
                            onProgressChanged: (controller, progress) {
                              if (progress == 100) {
                                pullToRefreshController.endRefreshing();
                               // urlModificada=urlModificada;
                              }
                              setState(() {
                                this.progress = progress / 100;

                              //  urlModificada=urlModificada;
                                //urlOrigen ;
                                //=urlOrigen;
                               // urlController.text = this.url;
                              });
                            },

                             ):Container(
                                padding: const EdgeInsets.all(16),
                                //height: 60,
                                color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.router_rounded, size: 80,),
                                    const SizedBox(width: 8),
                                    const Text('Sin información del router'),
                                    const Text('Verifique que no esté activado los datos móviles'),
                                  ],
                                ),

                              ),

                        ),

    ),
                  SizedBox(height: 10,),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        child: Icon(Icons.arrow_back),
                        onPressed: () {
                          _webViewController?.goBack();
                        },
                      ),
                      ElevatedButton(
                        child: Icon(Icons.arrow_forward),
                        onPressed: () {
                          _webViewController?.goForward();
                        },
                      ),
                      ElevatedButton(
                        child: Icon(Icons.refresh),
                        onPressed: () {
                          getData().then((value) {
                            //setState(() {
                            setState(() {
                              router = value!;
                              r=router.toString();
                            });
                            // });
                          });

                          _webViewController?.reload();

                        },
                      ),
                    ],
                  ),
                 SizedBox(height: 20,),

                 Container(
                      alignment: Alignment.bottomCenter,
                      // padding: EdgeInsets.all(20),
                      height: 60,
                      //width: 40,
                      color: Colors.lightBlueAccent

                  ),

                ]))


         //])

    /*Center(
          child:
          Container(
            margin: EdgeInsets.all(20),
            child:
            Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Compruebe su conexión a internet"),
                Text("o conéctese a una red Wi-Fi"),
                /*ElevatedButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    getData().then((value) {
                      //setState(() {
                    // setState(() {
                     //   router = value!;
                      });
                      // });
                    //});
                   // r=router;
                   // _webViewController?.reload();
                  },
                ),*/
              ],
            ),
          ),
        ),*/

    //):Center(child: CircularProgressIndicator()),
    );



  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(milliseconds: 20));
    setState(() {
    });
    return null;
  }
}




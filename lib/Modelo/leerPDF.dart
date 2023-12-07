import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:raised_buttons/raised_buttons.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class cLeerPdf extends StatefulWidget {
  const cLeerPdf({super.key});

  @override
  State<cLeerPdf> createState() => _cLeerPdfState();
}
class PermissionHelper {
  static Future<bool> requestStoragePermissions() async {
    var status = await Permission.storage.status;
    log("=> storage permission satus: $status");
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    return status == PermissionStatus.granted;
  }
}
class _cLeerPdfState extends State<cLeerPdf> {
//PermissionHelper permiso= PermissionHelper();
String assetPDFPath="";
String urllPdfPath="";
 /*final int REQUEST_EXTERNAL_STORAGE = 1;
String PERMISSIONS_STORAGE (){
  Manifest.permission.READ_EXTERNAL_STORAGE,
  Manifest.permission.WRITE_EXTERNAL_STORAGE
};*/

Future<void> requestpersmission() async {
  await Permission.manageExternalStorage.request();

 // ermissionhandler().requestpermissions([permissiongroup.storage]);
}
 @override
  void initState() {


   requestpersmission();

    getFileFromAsset("assets/MANUALEQUIPOS.pdf").then((f)
    {
      setState(() {
        assetPDFPath=f.path;
        print(urllPdfPath.toString());
      });
    });

    getFileFromUrl("http://www.pdf995.com/samples/pdf.pdf").then((f)
    {
      setState(() {
        urllPdfPath=f.path;
        print("get:"+urllPdfPath.toString());
      });
    });
   super.initState();
  }

  Future<File> getFileFromAsset(String asset)async
  {
    try{
      var data= await rootBundle.load(asset);
      var bytes= data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      //File file = File("${dir.path}/MANUALEQUIPOS.pdf");
      File file = File("${dir.path}/MANUALEQUIPOS.pdf");

      print(file.toString());
      File assetFile= await file.writeAsBytes(bytes);
      return assetFile;
    }catch(e)
    {
      throw Exception("Error al abrir el archivo asset");
    }
  }

 Future<File> getFileFromUrl(String url)async
  {
  try{
    var data= await http.get(Uri.parse(url));
    var bytes= data.bodyBytes;
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/MANUALEQUIPOS.pdf");
    print(file.toString());
    File urlFile= await file.writeAsBytes(bytes);
    return urlFile;
  }catch(e)
  {
    throw Exception("Error al abrir el archivo asset");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('PDF Viewer'),
        ),

        body:
        //Center(
            //child:
            pdfViewPage(path: urllPdfPath),//assetPDFPath
         /* child:Builder(
            builder: (context)=>
                //context.goNamed("PDF");
                /*Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //RaisedButtons(key, text: text, onPressed: onPressed, fontSize: fontSize)
               /* RaisedButton(
                  color:Colors.amber;
                  child: Text("Abrir Url");
                ),*/
              ],
            ),*/
          ),*/
       // ),


    );

  }

}
class pdfViewPage extends StatefulWidget {
  final String path;
  const pdfViewPage({super.key, required this.path});

  @override
  State<pdfViewPage> createState() => _pdfViewPageState();
}

class _pdfViewPageState extends State<pdfViewPage> {

  late PDFViewController _pdfViewController;
  int _totalPages=0;
  int _currentPage=0;
  bool pdfReady=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Documento prueba")),
      body:
      Stack(
        children: [
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            onError: (e)
            {
              print(e);
            },
            onRender: (_pages)
            {
               setState(() {
                 _totalPages=_pages!;
                 pdfReady=true;
               });
            },
            onViewCreated: (PDFViewController vc)
            {
              _pdfViewController=vc;
            },
            /*onPageChanged: (int ){

            },*/
           onPageChanged: (int? page, int? total )
            {

            },
           onPageError: (page, e)
            {

            },

          ),
      !pdfReady?Center(child:CircularProgressIndicator(),):Offstage()
        ],

      ),

      floatingActionButton:Row(
        children: [
          _currentPage>0?FloatingActionButton.extended(
            backgroundColor: Colors.red,
              label:Text("Ir a ${_currentPage-1}"),
              onPressed: ()
      {
        _currentPage-=1;
        _pdfViewController.setPage(_currentPage);
      }
              
             ):Offstage(),

          _currentPage<0?FloatingActionButton.extended(
              backgroundColor: Colors.red,
              label:Text("Ir a ${_currentPage+1}"),
              onPressed: ()
              {
                _currentPage+=1;
                _pdfViewController.setPage(_currentPage);
              }

          ):Offstage(),

      ],
    )
      ,
    );
  }
}

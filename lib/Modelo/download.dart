import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';


class TestClass{
  static void callback(String id, int status , int progress) {
    print("status=$id");
    print("status=$status");
    print("progress=$progress");
    //sleep(500000 as Duration);
    var duration = const Duration(seconds:5 );
    print('Start sleeping');
    sleep(duration);
    print('10 seconds has passed');
    //print("value="+value.toString());
    print("completed");

  }
 /* static void downloadCallback(String id, int status, int progress)
  {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
   send?.send([id, status, progress]);
  }*/
  }
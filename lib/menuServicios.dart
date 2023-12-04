
import 'package:flutter/material.dart';


class menuServicios extends StatefulWidget {
  const menuServicios({super.key});

  @override
  State<menuServicios> createState() => _menuServiciosState();
}

class _menuServiciosState extends State<menuServicios> {


  @override
  Widget build(BuildContext context) {
  return  Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(" Servicios"),
      ),
      body: Center(
        child: Text('Services Page',style: TextStyle(fontWeight: FontWeight.bold),),
      ),

    );
  }
}

import 'package:flutter/material.dart';

class MenuOtrosServicios extends StatefulWidget {
  const MenuOtrosServicios({super.key});

  @override
  State<MenuOtrosServicios> createState() => _MenuOtrosServiciosState();
}

class _MenuOtrosServiciosState extends State<MenuOtrosServicios> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Otros Servicios"),
      ),
      body: Center(
        child: Text('Others Services Page',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}

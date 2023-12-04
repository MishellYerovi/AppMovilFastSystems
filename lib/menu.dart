//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//import 'package:fastsystems_app2/ubicacion.dart';
//import 'package:flutter/material.dart';

/*class Menu  extends StatefulWidget {
  const Menu ({super.key});

  @override
  State<Menu> createState() => _MenuState();
}


class _MenuState extends State<Menu> {
  int _selectedTab=0;
  final List <Widget>_pages=[
  ubicacionPage(), ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        child:_pages[_selectedTab],
      ),
      bottomNavigationBar:CurvedNavigationBar(
        index: _selectedTab,
        height: 60,
        items: <Widget>
          [
            _builNavItem(Icons.home, _selectedTab==0),
            _builNavItem(Icons.favorite, _selectedTab==1),
            _builNavItem(Icons.person, _selectedTab==2),

        ],
        //Color de fondo de íconos
        buttonBackgroundColor: Colors.white,
        //Color de fondo detrás de la barra
        backgroundColor: Colors.transparent,
        //curva de animación
        animationDuration: Duration(milliseconds: 300),
        onTap: (index){
          setState(() {
            _selectedTab=index;
          });
        }

      ),
    );

  }Widget _builNavItem(IconData icon, bool isSelected)
  {
    return Icon(icon, size: 30, color:isSelected ? Colors.red:Colors.amber,);
  }


}
*/
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({
    required this.navigationShell,
    super.key,
  });
  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {

  int selectedIndex = 1;

  void _goBranch(int index) {


    /*if(index==1)
      {
        GoRouter.of(context).refresh();
        GoRouter.of(context).pushReplacement("/home");}
    if(index==0)
    { GoRouter.of(context).pushNamed("About");
      GoRouter.of(context).pushReplacement("/about");}
    if(index==2)
    {  GoRouter.of(context).pushReplacement("/ubicacion");}*/

    //GoRouter.of(context).refresh();
  //  widget.navigationShell.hashCode;

    widget.navigationShell.goBranch(
      index,

      initialLocation: index == widget.navigationShell.currentIndex,

    );

    //GoRouter.of(context).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(context.namedLocation('Player'));
          },
          backgroundColor: Colors.deepPurpleAccent,
          child: const Icon(Icons.play_arrow)),*/
      bottomNavigationBar:

      CurvedNavigationBar(
       // key: _bottomNavigationKey,
       //
        height: 75.0,
        items: <Widget>[
          Icon(Icons.business, size: 30,color: Colors.grey.shade800,),
          Icon(Icons.home, size: 30,color: Colors.grey.shade800,),
          Icon(Icons.location_on, size: 30,color: Colors.grey.shade800,),
        ],

        //Color de fondo detrás de la barra
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.white,
        //animationCurve: Curves.easeInOut,
        animationCurve: Curves.easeInOutCirc,
        //curva de animación
        animationDuration: Duration(milliseconds: 800),
        onTap: (index) {

          setState(() {
            selectedIndex = index;
          });
          setState(() {

          });
            _goBranch(selectedIndex);
        },
       // letIndexChange: (index) => true,
        //selectedIndex: selectedIndex,
        index: selectedIndex,
      ),
       /*SlidingClippedNavBar(

        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          setState(() {
            selectedIndex = index;
          });
          _goBranch(selectedIndex);
        },
        iconSize: 30,
        activeColor: Colors.lightBlueAccent,
        fontSize: 20,
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.business,
            title: 'Sobre nosotros',
          ),
          BarItem(
            icon: Icons.home,
            title: 'Inicio',
          ),
          BarItem(
            icon: Icons.location_on,
            title: 'Ubícanos',
          ),
        ],
      ),*/
    );
  }

}
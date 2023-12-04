import 'package:flutter/material.dart';

class popMenu extends StatefulWidget {
  const popMenu({super.key});

  @override
  State<popMenu> createState() => _popMenuState();
}

class _popMenuState extends State<popMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PopupMenuButton(
// add icon, by default "3 dot" icon
// icon: Icon(Icons.book)
            itemBuilder: (context){
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("My Account"),
                ),

                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Settings"),
                ),

                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Logout"),
                ),
              ];
            },
            onSelected:(value){
              if(value == 0){
                print("My account menu is selected.");
              }else if(value == 1){
                print("Settings menu is selected.");
              }else if(value == 2){
                print("Logout menu is selected.");
              }
            }
        )

    );
  }
}



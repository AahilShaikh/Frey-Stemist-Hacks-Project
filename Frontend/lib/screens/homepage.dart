import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: Container(
            width: MediaQuery.of(context).size.width-40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(image: AssetImage("assets/images/beach.jpg"), fit: BoxFit.cover)
            ),
            child: Text("Welcome Back", style: Theme.of(context).textTheme.headline1,),
          ),
        )
      ],
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    floatingActionButton: FabCircularMenu(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.travel_explore),
          tooltip: "Create a new trip",
          onPressed: (){

          },
        ),
        IconButton(
          icon: Icon(Icons.add_location_alt),
          tooltip: "Add a new activity",
          onPressed: (){

          }
        )
      ]
    ),
    );
  }
}



 
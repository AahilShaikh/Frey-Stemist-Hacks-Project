import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/widgets/button.dart';

import 'apiScrap.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/beach.jpg"),
                      fit: BoxFit.cover)),
              child: Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 2,
            ),
            SizedButtion(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApiScrap()),
                    ),
                text: "Demo Scraping",
                width: 150,
                height: 75,
                fontSize: 20),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FabCircularMenu(children: <Widget>[
        IconButton(
          icon: Icon(Icons.travel_explore),
          tooltip: "Create a new trip",
          onPressed: () {},
        ),
        IconButton(
            icon: Icon(Icons.add_location_alt),
            tooltip: "Add a new activity",
            onPressed: () {})
      ]),
    );
  }
}

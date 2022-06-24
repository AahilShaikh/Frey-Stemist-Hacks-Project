import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';


class ApiScrap extends StatefulWidget {
  const ApiScrap({Key? key}) : super(key: key);

  @override
  State<ApiScrap> createState() => _ApiScrap();
}

class _ApiScrap extends State<ApiScrap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Test"),
      ),
      body: Center(
        child:
        Column(
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
            Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
}

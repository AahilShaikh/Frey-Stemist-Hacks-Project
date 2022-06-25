import 'package:flutter/material.dart';
import 'package:hackathon/widgets/button.dart';
import '../widgets/firestoreStream.dart';
import 'apiScrap.dart';
import 'more_detail.dart';

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
                  image: DecorationImage(image: AssetImage("assets/images/beach.jpg"), fit: BoxFit.cover)),
              child: Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Streaming(
              whatData: 'test',
              height: 300,
              stream: 'test',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MoreDetail()),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            SizedButton(
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
    );
  }
}

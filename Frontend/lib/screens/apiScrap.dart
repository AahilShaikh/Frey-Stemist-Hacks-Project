import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../widgets/clearAppBar.dart';

class ApiScrap extends StatefulWidget {
  const ApiScrap({Key? key}) : super(key: key);

  @override
  State<ApiScrap> createState() => _ApiScrap();
}

class _ApiScrap extends State<ApiScrap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: clearAppBar(
          text: '534',
          fontSize: 20,
        ),
      ),
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
                color: Colors.blue,
              ),
              child: Text(
                "Data Goes here",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}

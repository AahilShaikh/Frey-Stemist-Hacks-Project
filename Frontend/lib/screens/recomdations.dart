import 'package:flutter/material.dart';

import '../widgets/clearAppBar.dart';

class Recomdations extends StatefulWidget {
  const Recomdations({Key? key}) : super(key: key);

  @override
  _RecomdationsState createState() => _RecomdationsState();
}

class _RecomdationsState extends State<Recomdations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: clearAppBar(
          text: 'Recommendations',
          fontSize: 20,
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("data"),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/clearAppBar.dart';
import '../widgets/showOneFirestore.dart';

class Recomdations extends StatefulWidget {
  const Recomdations({Key? key}) : super(key: key);

  @override
  _RecomdationsState createState() => _RecomdationsState();
}

class _RecomdationsState extends State<Recomdations> {
  late String data1;
  late String data2;
  late String data3;
  late String data4;
  late String data5;

  getData1() async {
    data1 = "Loading.....";
    data2 = "Loading.....";
    data3 = "Loading.....";
    data4 = "Loading.....";
    data5 = "Loading.....";

    final firestoreInstance = FirebaseFirestore.instance;

    firestoreInstance
        .collection("Trips")
        .doc("demo")
        .get()
        .then((stuff) {

        data1 = stuff['Name'];
        data2 = stuff['Location'];
        data3 = stuff['Date'];
        data4 = stuff['Time'];
        data5 = stuff['Price'];
        setState(() {});
    });
  }

  @override
  void initState() {
    getData1();

  }

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
            Text(data1),
            Text(data2),
            Text(data3),
            Text(data4),
            Text(data5),
          ],
        ),
      ),
    );
  }
}

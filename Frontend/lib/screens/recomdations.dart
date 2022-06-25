import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/widgets/RowDisplay.dart';

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

    firestoreInstance.collection("Trips").doc("demo").get().then((stuff) {
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
    if (data1 == "Loading.....")
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: clearAppBar(
            text: 'Recommendations',
            fontSize: 20,
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
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
            Spacer(),
            Expanded(
              flex: 20,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: new BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(color: Colors.white, width: 10),
                  borderRadius: BorderRadius.all(Radius.elliptical(100, 50)),
                ),
                child: Column(
                  children: [
                    Spacer(),
                    RowText(text: "What Event?", fontSize: 20, text2: data1),
                    Divider(
                      thickness: 4,
                      color: Colors.white,
                    ),
                    Spacer(),
                    RowText(text: "Where?", fontSize: 20, text2: data2),
                    Divider(
                      thickness: 4,
                      color: Colors.white,
                    ),
                    Spacer(),
                    RowText(text: "Date?", fontSize: 20, text2: data3),
                    Divider(
                      thickness: 4,
                      color: Colors.white,
                    ),
                    Spacer(),
                    RowText(text: "Time?", fontSize: 20, text2: data4),
                    Divider(
                      thickness: 4,
                      color: Colors.white,
                    ),
                    Spacer(),
                    RowText(text: "Cost?", fontSize: 20, text2: data5),
                    Divider(
                      thickness: 4,
                      color: Colors.white,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

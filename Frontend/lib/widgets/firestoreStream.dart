import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SizedButtion extends StatelessWidget {
  SizedButtion({required this.stream, required this.height, required this.whatData});

  final String stream;
 final double height;
 final String whatData;

@override
  Widget build(BuildContext context) {

  final Stream<QuerySnapshot> data =
  FirebaseFirestore.instance.collection(stream).snapshots();

  return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: height,
        child: StreamBuilder<QuerySnapshot>(
          stream: data,
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                  height: 250, width: 250, child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Text('Error');
            }
            final display = snapshot.requireData;
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: display.size,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        display.docs[index][whatData].toString(),
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ));
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

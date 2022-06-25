import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon/screens/more_detail.dart';
import 'package:hackathon/widgets/activity.dart';

class StreamOne extends StatelessWidget {
  StreamOne({required this.stream, required this.height, required this.whatData, required this.whatDoc});

  final String stream;
  final double height;
  final String whatData;
  final String whatDoc;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> data = FirebaseFirestore.instance.collection(stream).doc(whatDoc) as Stream<QuerySnapshot<Object?>>;

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
              return const SizedBox(height: 250, width: 250, child: CircularProgressIndicator());
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
                      child: Activity(color: Colors.blue, title: display.docs[index][whatData].toString(), moreActivity: MoreDetail(),)
                  );
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

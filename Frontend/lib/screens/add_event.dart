import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String? _currentTrip;
  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: firebase.collection('Users').doc(user!.email).collection("Trips").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).textTheme.headline1!.color as Color),
          ));
        }
        QuerySnapshot query = snapshot.data as QuerySnapshot;
        List<String> trips = [];
        query.docs.forEach((element) {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;
          trips.add(data["tripID"]);
        });

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                  isDense: true,
                  isExpanded: true,
                  hint: Text('Choose Event'),
                  underline: Container(
                    height: 0,
                    color: Theme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  value: _currentTrip,
                  items: trips.map<DropdownMenuItem<dynamic>>((dynamic value) {
                    return DropdownMenuItem<dynamic>(
                      value: value,
                      child: Text(
                        "Event: $value",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    );
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      
                    });
                  }),
            ),
          ),
        );
      },
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uuid/uuid.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({Key? key}) : super(key: key);

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  late TextEditingController _tripNameController;
  late TextEditingController _emailController;
  List<String> emails = [];
  var uuid = Uuid();
  late final String tripID;
  @override
  void initState() {
    _tripNameController = TextEditingController();
    _emailController = TextEditingController();
    tripID = uuid.v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseFirestore.instance;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${_tripNameController.text}",
            style: Theme.of(context).textTheme.headline1,
          ),
          Row(
            children: [
              Expanded(child: AutoSizeText("Enter your trip's name: ", style: TextStyle(color: Colors.black),)),
              Expanded(
                child: TextField(
                  controller: _tripNameController,
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("Add people to the trip")),
              Expanded(
                child: TextField(
                  controller: _emailController,
                  onSubmitted: (String email) {
                    setState(() {
                      emails.add(email);
                    });
                    _emailController.clear();
                  },
                ),
              )
            ],
          ),
          Expanded(
            child: AnimatedList(
              scrollDirection: Axis.horizontal,
              initialItemCount: 0,
              itemBuilder: (context, index, Animation<double> animation) {
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(emails[index].substring(0, 1)),
                    ),
                    Text(
                      emails[index],
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              SetOptions options = SetOptions(merge: true);
              for (String email in emails) {
                firebase.collection("Users").doc(email).collection("Trips").doc(tripID).set({"Trip ID": tripID, "Name" : _tripNameController.text}, options);
              }
              firebase.collection("Trips").doc(tripID).set({"Trip ID": tripID, "Name" : _tripNameController.text}, options);
              Navigator.pop(context);
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}

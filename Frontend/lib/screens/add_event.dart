import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/acivity_type.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  ActivityType? type;
  String? _currentTrip;
  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    return Column(
      children: [
        FutureBuilder(
          future: firebase.collection('Users').doc(user!.email).collection("Trips").get(),
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
              print(data);
              trips.add(data["Name"]);
            });

            return Flexible(
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
                            "$value",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        );
                      }).toList(),
                      onChanged: (dynamic newValue) {
                        setState(() {
                          _currentTrip = newValue;
                        });
                      }),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  
                  setState(() {
                    type = ActivityType.Flight;
                  });
                },
                child: CircleAvatar(
                  minRadius: 30,
                  backgroundColor: type == ActivityType.Flight ? Colors.pink.shade200 : Colors.pink,
                  child: FaIcon(
                    FontAwesomeIcons.planeUp,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  
                  setState(() {
                    type = ActivityType.Dining;
                  });
                },
                child: CircleAvatar(
                  minRadius: 30,
                  backgroundColor: type == ActivityType.Dining ? Colors.blue.shade200 : Colors.blue,
                  child: FaIcon(FontAwesomeIcons.utensils, color: Colors.white),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  
                  setState(() {
                    type = ActivityType.Home;
                  });
                },
                child: CircleAvatar(
                  minRadius: 30,
                  backgroundColor: type == ActivityType.Home ? Colors.orange.shade200 : Colors.orange,
                  child: FaIcon(FontAwesomeIcons.house, color: Colors.white),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  
                  setState(() {
                    type = ActivityType.Event;
                  });
                },
                child: CircleAvatar(
                  minRadius: 30,
                  backgroundColor: type == ActivityType.Event ? Colors.green.shade200 : Colors.green,
                  child: FaIcon(FontAwesomeIcons.calendar, color: Colors.white),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        if(type == ActivityType.Flight)
          FlightQuestions()
        
      ],
    );
  }
}

class FlightQuestions extends StatefulWidget {
  FlightQuestions({Key? key}) : super(key: key);

  @override
  State<FlightQuestions> createState() => _FlightQuestionsState();
}

class _FlightQuestionsState extends State<FlightQuestions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

      ],
    );
  }
}

class DiningQuestions extends StatefulWidget {
  DiningQuestions({Key? key}) : super(key: key);

  @override
  State<DiningQuestions> createState() => _DiningQuestionsState();
}

class _DiningQuestionsState extends State<DiningQuestions> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class EventQuestions extends StatefulWidget {
  EventQuestions({Key? key}) : super(key: key);

  @override
  State<EventQuestions> createState() => _EventQuestionsState();
}

class _EventQuestionsState extends State<EventQuestions> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SleepingOptionsQuestions extends StatefulWidget {
  SleepingOptionsQuestions({Key? key}) : super(key: key);

  @override
  State<SleepingOptionsQuestions> createState() => _SleepingOptionsQuestionsState();
}

class _SleepingOptionsQuestionsState extends State<SleepingOptionsQuestions> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
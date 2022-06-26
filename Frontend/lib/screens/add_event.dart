import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackathon/widgets/TextQuestion.dart';
import 'package:uuid/uuid.dart';

import '../constants/activity_type.dart';
import '../widgets/date_time_selector.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  ActivityType? type;
  String? _currentTrip;
  Map<String, dynamic> trips = {};
  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
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
                query.docs.forEach((element) {
                  Map<String, dynamic> data = element.data() as Map<String, dynamic>;
                  print(data);
                  trips[data["Name"]] = data["Trip ID"];
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
                          items: trips.keys.toList().map<DropdownMenuItem<dynamic>>((dynamic value) {
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
            if (type == ActivityType.Flight)
              FlightQuestions(tripID: trips[_currentTrip])
            else if (type == ActivityType.Dining)
              DiningQuestions(tripID: trips[_currentTrip])
            else if (type == ActivityType.Home)
              GeneralReminder(tripID: trips[_currentTrip])
            else if (type == ActivityType.Event)
              EventQuestions(tripID: trips[_currentTrip])
            else
              Text(
                "Choose An Activity Type",
                style: TextStyle(fontSize: 30, color: Colors.black),
              )
          ],
        ),
      ),
    );
  }
}

class FlightQuestions extends StatefulWidget {
  final String tripID;
  FlightQuestions({Key? key, required this.tripID}) : super(key: key);

  @override
  State<FlightQuestions> createState() => _FlightQuestionsState();
}

class _FlightQuestionsState extends State<FlightQuestions> {
  late TextEditingController _flightNumber;
  late TextEditingController _arrivalAirport;
  late TextEditingController _departureAirport;
  late TextEditingController _title;

  var uuid = Uuid();
  late final String eventID;
  @override
  void initState() {
    eventID = uuid.v1();

    super.initState();
    _flightNumber = TextEditingController();
    _departureAirport = TextEditingController();
    _arrivalAirport = TextEditingController();
    _title = TextEditingController();
  }

  @override
  void dispose() {
    _flightNumber.dispose();
    _arrivalAirport.dispose();
    _departureAirport.dispose();
    super.dispose();
  }

  DateTime departureDate = DateTime.now();
  DateTime arrivalDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Add a Flight", style: TextStyle(fontSize: 30, color: Colors.black)),
        TextQuestion(question: "Title", controller: _title),
        TextQuestion(question: "Flight Number", controller: _flightNumber),
        DateTimeSelector(dateTime: departureDate, title: "Departure Date: "),
        DateTimeSelector(dateTime: arrivalDate, title: "Arrival Date: "),
        TextQuestion(
          question: "Departure Airport",
          controller: _arrivalAirport,
        ),
        TextQuestion(question: "Arrival Airport", controller: _departureAirport),
        TextButton(
          child: Text("Save"),
          onPressed: () {
            FirebaseFirestore.instance.collection("Trips").doc(widget.tripID).collection("Events").doc(eventID).set({
              "Event Type": "Flight",
              "Flight Number": _flightNumber.text,
              "Departure Time": departureDate,
              "Arrival Time": arrivalDate,
              "Title": _title.text
            }, SetOptions(merge: true));
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class DiningQuestions extends StatefulWidget {
  final tripID;
  DiningQuestions({Key? key, required this.tripID}) : super(key: key);

  @override
  State<DiningQuestions> createState() => _DiningQuestionsState();
}

class _DiningQuestionsState extends State<DiningQuestions> {
  DateTime date = DateTime.now();
  late TextEditingController location;
  late TextEditingController _title;
  var uuid = Uuid();
  late final String eventID;

  @override
  void initState() {
    eventID = uuid.v1();
    super.initState();
    location = TextEditingController();
    _title = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Add Dining", style: TextStyle(fontSize: 30, color: Colors.black)),
        TextQuestion(
          question: "Title: ",
          controller: _title,
        ),
        TextQuestion(
          question: "Title:",
          controller: _title,
        ),
        DateTimeSelector(dateTime: date, title: "Date: "),
        TextQuestion(question: "Location", controller: location),
        TextButton(
          child: Text("Save"),
          onPressed: () {
            FirebaseFirestore.instance
                .collection("Trips")
                .doc(widget.tripID)
                .collection("Events")
                .doc(eventID)
                .set({"Event Type": "Dining", "Date": date, "Title": _title.text}, SetOptions(merge: true));
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class EventQuestions extends StatefulWidget {
  final String tripID;
  EventQuestions({Key? key, required this.tripID}) : super(key: key);

  @override
  State<EventQuestions> createState() => _EventQuestionsState();
}

class _EventQuestionsState extends State<EventQuestions> {
  DateTime date = DateTime.now();
  late TextEditingController location;
  late TextEditingController _title;

  var uuid = Uuid();
  late final String eventID;

  @override
  void initState() {
    eventID = uuid.v1();
    super.initState();
    location = TextEditingController();
    _title = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Add An Activity", style: TextStyle(fontSize: 30, color: Colors.black)),
        TextQuestion(
          question: "Title: ",
          controller: _title,
        ),
        DateTimeSelector(dateTime: date, title: "Date: "),
        TextQuestion(question: "Location", controller: location),
        TextButton(
          child: Text("Save"),
          onPressed: () {
            FirebaseFirestore.instance
                .collection("Trips")
                .doc(widget.tripID)
                .collection("Events")
                .doc(eventID)
                .set({"Event Type": "Dining", "Date": date, "Title": _title.text}, SetOptions(merge: true));
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class GeneralReminder extends StatefulWidget {
  final String tripID;
  GeneralReminder({Key? key, required this.tripID}) : super(key: key);

  @override
  State<GeneralReminder> createState() => _GeneralReminderState();
}

class _GeneralReminderState extends State<GeneralReminder> {
  DateTime date = DateTime.now();
  late TextEditingController location;
  late TextEditingController _title;

  var uuid = Uuid();
  late final String eventID;

  @override
  void initState() {
    eventID = uuid.v1();
    super.initState();
    location = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Add A General Reminder", style: TextStyle(fontSize: 30, color: Colors.black)),
        TextQuestion(question: "Title: ", controller: _title,),
        DateTimeSelector(dateTime: date, title: "Date: "),
        TextQuestion(question: "Location", controller: location),
        TextButton(
          child: Text("Save"),
          onPressed: () {
            FirebaseFirestore.instance
                .collection("Trips")
                .doc(widget.tripID)
                .collection("Events")
                .doc(eventID)
                .set({"Event Type": "Dining", "Date": date, "Title": _title.text}, SetOptions(merge: true));
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

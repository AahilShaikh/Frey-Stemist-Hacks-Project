import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/event.dart';
import '../widgets/activity.dart';
import 'more_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> trips = {};
  String? _currentTrip;
  List<String> images = ["assets/images/beach.jpg", "assets/images/london.webp", "assets/images/sunset.jpg"];
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(image: AssetImage("assets/images/beach.jpg"), fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Welcome Back",
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Users').doc(user!.email).collection("Trips").snapshots(),
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

                return Padding(
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
                );
              },
            ),
            if (_currentTrip != null)
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Trips").doc(trips[_currentTrip]).collection("Events").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  QuerySnapshot query = snapshot.data as QuerySnapshot;
                  List<Event> events = [];
                  query.docs.forEach((element) {
                    Map<String, dynamic> data = element.data() as Map<String, dynamic>;
                    // if (data["Event Type"] == "Flight") {
                    //   data.remove("Event Type");
                    //   events.add(Event(title: data["Title"], data: data));
                    // } else if (data["Event Type"] == "Dining") {
                    //   data.remove("Event Type");
                    //   events.add(Event(title: data['Title'], data: data));
                    // }

                    data.remove("Event Type");
                    events.add(Event(title: data['Title'], data: data));
                  });
                  // events.sort((a, b) {
                  //   a.data
                  // });
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return Activity(
                        color: Colors.white,
                        title: events[index].title,
                        moreActivity: MoreDetail(),
                        data: events[index].data,
                        imagePath: images[index % images.length],
                      );
                    },
                  );
                },
              ),
            Spacer(
              flex: 1,
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}

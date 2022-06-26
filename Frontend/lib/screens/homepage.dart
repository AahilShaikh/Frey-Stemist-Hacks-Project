import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/screens/recomdations.dart';
import 'package:hackathon/widgets/button.dart';
import '../models/event.dart';
import '../services/HttpRequestDemo.dart';
import '../widgets/activity.dart';
import '../widgets/clearAppBar.dart';
import '../widgets/firestoreStream.dart';
import 'apiScrap.dart';
import 'auth/login.dart';
import 'more_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> trips = {};
  String? _currentTrip;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: clearAppBarWithButtion(
          text: '',
          fontSize: 1,
          whaticon: Icons.backspace_outlined,
          onPressed: () {
            ///TODO: Add a proper sign out idk how to do this yet so do the on pressed
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/beach.jpg"),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Welcome Back",
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Spacer(),
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
                  if (data["Event Type"] == "Flight") {
                    data.remove("Event Type");
                    events.add(Event(title: data["Title"], data: data));
                  }
                });

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Activity(color: Colors.white, title: events[index].title, moreActivity: MoreDetail());
                  },
                );
              },
            ),
            Spacer(
              flex: 1,
            ),
            SizedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Reccomendations()),
              ),
              text: "Travel\n Recommendations",
              width: 200,
              height: 75,
              fontSize: 15,
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

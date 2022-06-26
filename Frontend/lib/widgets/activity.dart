import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Activity extends StatefulWidget {
  final Color color;
  final String title;
  final Widget moreActivity;
  Map<String, dynamic>? data;
  final String? imagePath;
  Activity({Key? key, required this.color, required this.title, required this.moreActivity, this.data, this.imagePath}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {

  DateFormat dateFormat = DateFormat("MM/dd/yyyy HH:mm:ss");
  
  @override
  Widget build(BuildContext context) {
    widget.data!.remove("Title");
    widget.data!.forEach((key, value) {
      if (value is Timestamp) {
        widget.data![key] = dateFormat.format(value.toDate());
      }
    });
    List<String> keys = widget.data!.keys.toList();
    List<dynamic> values = widget.data!.values.toList();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget.moreActivity));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            // height: 150,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.all(Radius.circular(20)), boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        // height: 150,
                        width: (MediaQuery.of(context).size.width - 30) / 2,
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          widget.imagePath ?? "",
                          fit: BoxFit.cover,
                          height: 150,
                          width: (MediaQuery.of(context).size.width - 30) / 2,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(3, 0), // changes position of shadow
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 30) / 2,
                  child: Column(
                    children: [
                      Text(widget.title, style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [Text("${keys[index]}: "), Text("${values[index]}")],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

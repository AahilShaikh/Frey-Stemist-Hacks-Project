import 'package:flutter/material.dart';

class Activity extends StatefulWidget {
  final Color color;
  final String title;
  final Widget moreActivity;
  Activity({Key? key, required this.color, required this.title, required this.moreActivity}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget.moreActivity));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: 150,
          width: MediaQuery.of(context).size.width-40,
          decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
          ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 150,
                  width: (MediaQuery.of(context).size.width - 40)/2,
                  child: Image.asset("assets/images/beach.jpg", scale: 2,),
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
                )
              ),
              Row(
                children: [
                  Text(widget.title, style: TextStyle(fontSize: 30, color: Colors.black)),
                  
                ],
              ),
            ],
          )
        
        ),
      ),
    );
  }
}

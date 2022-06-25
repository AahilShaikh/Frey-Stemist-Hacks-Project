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
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Text(widget.title, style: TextStyle(fontSize: 30)),
            
          ],
        )
      ),
    );
  }
}

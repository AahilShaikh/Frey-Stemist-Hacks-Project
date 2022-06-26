import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class DateTimeSelector extends StatefulWidget {
  final String title;
  DateTime dateTime;
  DateTimeSelector({Key? key, required this.dateTime, required this.title}) : super(key: key);

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context, DateTime selectedDate) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, TimeOfDay selectedTime) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  DateTime combineDateTime(TimeOfDay time, DateTime date) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.title),
        Text("${widget.dateTime.month}/${widget.dateTime.day}/${widget.dateTime.year} at ${widget.dateTime.hour}:${widget.dateTime.minute}"),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.calendar),
          onPressed: () {
            _selectDate(context, date).then((value) {
              print(date);
              _selectTime(context, time).then((value) {
                setState(() {
                  widget.dateTime = combineDateTime(time, date);
                });
              });
            });
          },
        )
      ],
    );
  }
}

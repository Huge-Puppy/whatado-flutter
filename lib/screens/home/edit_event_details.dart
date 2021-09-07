import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:whatado/models/event.dart';
import 'package:whatado/widgets/appbars/event_app_bar.dart';
import 'package:whatado/widgets/input/my_text_field.dart';

class EditEventDetails extends StatefulWidget {
  final Event event;
  EditEventDetails({required this.event});

  @override
  State<StatefulWidget> createState() => _EditEventDetailsState();
}

class _EditEventDetailsState extends State<EditEventDetails> {
  late bool expanded;

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController dateController;
  late TextEditingController timeController;

  final headingStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final headingSpacing = 10.0;
  final padding = 30.0;
  final sectionSpacing = 35.0;
  final dateFormat = DateFormat('dd MMMM, yyyy');
  final timeFormat = DateFormat('jm');

  @override
  void initState() {
    super.initState();
    expanded = false;
    titleController = TextEditingController(text: widget.event.title);
    descriptionController =
        TextEditingController(text: widget.event.description);
    locationController = TextEditingController(text: widget.event.location);
    dateController =
        TextEditingController(text: dateFormat.format(widget.event.time));
    timeController =
        TextEditingController(text: timeFormat.format(widget.event.time));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EventAppBar(event: widget.event, inEdit: true),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: sectionSpacing),
            Text('TITLE', style: headingStyle),
            SizedBox(height: headingSpacing),
            MyTextField(
              controller: titleController,
              hintText: 'Enter title',
            ),
            SizedBox(height: sectionSpacing),
            Text('DESCRIPTION', style: headingStyle),
            SizedBox(height: headingSpacing),
            MyTextField(
              controller: descriptionController,
              hintText: 'Enter description',
              maxLines: null,
            ),
            SizedBox(height: sectionSpacing),
            Text('LOCATION', style: headingStyle),
            SizedBox(height: headingSpacing),
            MyTextField(
              controller: locationController,
              hintText: 'Enter location',
            ),
            SizedBox(height: sectionSpacing),
            Text('TIME', style: headingStyle),
            SizedBox(height: headingSpacing),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    controller: dateController,
                    onTap: () => DatePicker.showDatePicker(context,
                        onConfirm: (time) =>
                            dateController.text = dateFormat.format(time),
                        minTime: DateTime.now(),
                        maxTime: DateTime.now().add(Duration(days: 100))),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Date',
                      hintStyle: TextStyle(fontSize: 13),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    controller: timeController,
                    onTap: () => DatePicker.showTime12hPicker(
                      context,
                      onConfirm: (time) =>
                          timeController.text = timeFormat.format(time),
                      currentTime: DateTime.now(),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Time',
                      isDense: true,
                      hintStyle: TextStyle(fontSize: 13),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: sectionSpacing),
          ]),
        )));
  }
}
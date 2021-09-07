import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatado/models/event.dart';
import 'package:whatado/screens/profile/user_profile.dart';
import 'package:whatado/widgets/appbars/event_app_bar.dart';
import 'package:whatado/widgets/buttons/rounded_arrow_button.dart';

class EventDetails extends StatefulWidget {
  final Event event;
  EventDetails({required this.event});

  @override
  State<StatefulWidget> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late bool expanded;
  @override
  void initState() {
    super.initState();
    expanded = false;
  }

  @override
  Widget build(BuildContext context) {
    final headingStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final headingSpacing = 10.0;
    final padding = 30.0;
    final sectionSpacing = 35.0;
    final circleSpacing = 10.0;
    final dateFormat = DateFormat('dd MMMM, yyyy HH:mm');
    final circleRadius = (MediaQuery.of(context).size.width -
            padding * 2.0 -
            circleSpacing * 2.0) /
        6.0;

    return Scaffold(
        appBar: EventAppBar(event: widget.event),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: sectionSpacing),
            Text('DESCRIPTION', style: headingStyle),
            SizedBox(height: headingSpacing),
            Text(widget.event.description),
            SizedBox(height: sectionSpacing),
            Text('LOCATION', style: headingStyle),
            SizedBox(height: headingSpacing),
            Text(widget.event.location),
            SizedBox(height: sectionSpacing),
            Text('TIME', style: headingStyle),
            SizedBox(height: headingSpacing),
            Text(dateFormat.format(widget.event.time)),
            SizedBox(height: sectionSpacing),
            Text('ORGANIZER', style: headingStyle),
            SizedBox(height: headingSpacing),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.event.creator.imageUrl),
                ),
                SizedBox(width: 20),
                Text(widget.event.creator.name)
              ],
            ),
            SizedBox(height: sectionSpacing),
            Text('ATTENDEES', style: headingStyle),
            SizedBox(height: headingSpacing),
            Wrap(
              spacing: circleSpacing,
              runSpacing: circleSpacing,
              children: !expanded && widget.event.invited.length > 5
                  ? [
                      ...widget.event.invited
                          .map((eventUser) => InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserProfile(
                                            initialUserData: eventUser))),
                                child: CircleAvatar(
                                    radius: circleRadius,
                                    backgroundImage:
                                        NetworkImage(eventUser.imageUrl)),
                              ))
                          .toList()
                          .take(5),
                      InkWell(
                          onTap: () => setState(() => expanded = !expanded),
                          child: CircleAvatar(
                            radius: circleRadius,
                            child: Text('+${widget.event.invited.length - 5}',
                                style: TextStyle(fontSize: 28)),
                            backgroundColor: Colors.grey[200],
                          ))
                    ]
                  : widget.event.invited
                      .map((eventUser) => InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile(
                                        initialUserData: eventUser))),
                            child: CircleAvatar(
                                radius: circleRadius,
                                backgroundImage:
                                    NetworkImage(eventUser.imageUrl)),
                          ))
                      .toList(),
            ),
            SizedBox(height: sectionSpacing),
            RoundedArrowButton(
                onPressed: null,
                text: '${widget.event.wannagoIds.length} people wannago'),
            SizedBox(height: 50),
          ]),
        )));
  }
}
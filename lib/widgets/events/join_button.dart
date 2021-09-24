import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatado/models/event.dart';
import 'package:whatado/providers/graphql/events_provider.dart';
import 'package:whatado/state/home_state.dart';
import 'package:whatado/state/user_state.dart';

class JoinButton extends StatelessWidget {
  final Event event;
  JoinButton({required this.event});
  @override
  Widget build(BuildContext context) {
    final homeState = Provider.of<HomeState>(context);
    final userState = Provider.of<UserState>(context);
    return ElevatedButton(
        onPressed: () async {
          try {
            if (userState.user == null) return;
            final provider = EventsGqlProvider();
            final result = await provider.addWannago(
                eventId: event.id, userId: userState.user!.id);
            // update the event
            if (result.ok) homeState.updateEvent(result.data as Event);
          } catch (e) {
            print(e.toString());
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
            backgroundColor: MaterialStateProperty.all(Color(0xffe85c3f))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Join', style: TextStyle(fontSize: 15)),
            Icon(Icons.add, size: 15),
          ],
        ));
  }
}

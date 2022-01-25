import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whatado/models/event.dart';
import 'package:whatado/providers/graphql/events_provider.dart';
import 'package:whatado/providers/graphql/user_provider.dart';
import 'package:whatado/screens/home/edit_event_details.dart';
import 'package:whatado/screens/profile/user_profile.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:whatado/state/edit_event_state.dart';
import 'package:whatado/state/home_state.dart';
import 'package:whatado/state/user_state.dart';

class EventTopBar extends StatelessWidget {
  final Event event;
  EventTopBar({required this.event});

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    final homeState = Provider.of<HomeState>(context);
    return Row(children: [
      InkWell(
        onTap: () => event.creator.id == userState.user?.id
            ? homeState.bottomBarPageNo = 3
            : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfile(user: event.creator)))
                .then((_) async {
                await Future.delayed(Duration(milliseconds: 500));
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: Colors.grey[50],
                  statusBarColor: Colors.transparent,
                ));
              }),
        child: CircleAvatar(
          radius: 17,
          backgroundImage: NetworkImage(event.creator.photoUrls.first),
        ),
      ),
      SizedBox(width: 10),
      Text(event.creator.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      Spacer(),
      Text(timeago.format(event.createdAt, locale: 'en_short'),
          style: TextStyle(color: Colors.grey)),
      if (event.creator.id == userState.user?.id)
        PopupMenuButton(
            onSelected: (value) async {
              if (value == 'edit') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                          create: (context) => EditEventState(event),
                          child: EditEventDetails(event: event)),
                    ));
              }
              if (value == 'delete') {
                final provider = EventsGqlProvider();
                await provider.deleteEvent(event.id);
                homeState.removeEvent(event);
              }
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(children: [
                      Icon(Icons.edit_outlined, size: 30),
                      SizedBox(width: 10),
                      Text('edit')
                    ]),
                    value: 'edit',
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.delete_outlined,
                            color: Colors.red, size: 30),
                        SizedBox(width: 10),
                        Text('delete', style: TextStyle(color: Colors.red))
                      ],
                    ),
                    value: 'delete',
                  )
                ])
      else
        PopupMenuButton(
            onSelected: (value) async {
              final userProvider = UserGqlProvider();
              final eventProvider = EventsGqlProvider();
              if (value == 'report') {
                await userProvider.flagUser(event.creator.id);
                await eventProvider.flagEvent(event.creator.id);
                homeState.removeEvent(event);
              }
              if (value == 'block') {
                final result = await userProvider.blockUser(event.creator.id);
                if (result.ok) {
                  await eventProvider.flagEvent(event.creator.id);
                  await userState.getUser();
                  homeState.removeEvent(event);
                }
              }
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(children: [
                      Icon(Icons.report_outlined, size: 30),
                      SizedBox(width: 10),
                      Text('report')
                    ]),
                    value: 'report',
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.block_outlined, color: Colors.red, size: 30),
                        SizedBox(width: 10),
                        Text('block', style: TextStyle(color: Colors.red))
                      ],
                    ),
                    value: 'block',
                  )
                ]),
    ]);
  }
}

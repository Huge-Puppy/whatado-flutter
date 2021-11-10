import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatado/models/event.dart';
import 'package:whatado/models/wannago.dart';
import 'package:whatado/providers/graphql/events_provider.dart';
import 'package:whatado/screens/profile/user_profile.dart';
import 'package:whatado/state/home_state.dart';
import 'package:whatado/widgets/appbars/default_app_bar.dart';

class SelectWannago extends StatefulWidget {
  final Event event;
  SelectWannago({required this.event});
  @override
  State<StatefulWidget> createState() => _SelectWannagoState();
}

class _SelectWannagoState extends State<SelectWannago> {
  late bool loading;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final homeState = Provider.of<HomeState>(context);
    Future<void> decide(Wannago w, bool accepted) async {
      setState(() => loading = true);
      final provider = EventsGqlProvider();
      if (accepted) {
        await provider.deleteWannago(wannagoId: w.id);
        final result = await provider.addInvite(
            eventId: widget.event.id, userId: w.user.id);
        if (result.data != null) {
          widget.event.wannago.remove(w);
          homeState.updateEvent(result.data as Event);
          homeState.updateMyEvent(result.data as Event);
        }
      } else {
        final result =
            await provider.updateWannago(wannagoId: w.id, declined: true);
        print(result.ok);
        print(result.errors);
        if (result.ok) {
          final i = widget.event.wannago.indexOf(w);
          widget.event.wannago[i].declined = true;
          homeState.updateEvent(widget.event);
          homeState.updateMyEvent(widget.event);
        }
      }
      setState(() => loading = false);
    }

    return Scaffold(
      appBar: DefaultAppBar(title: 'Invite'),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: widget.event.wannago
                  .where((w) => !w.declined)
                  .map((wannago) => ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserProfile(user: wannago.user))),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(wannago.user.photoUrls.first),
                        ),
                        title: Text(wannago.user.name),
                        trailing: Container(
                          width: 200,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () async =>
                                      await decide(wannago, false),
                                  icon: Icon(Icons.clear)),
                              IconButton(
                                  onPressed: () async =>
                                      await decide(wannago, true),
                                  icon: Icon(Icons.check))
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}

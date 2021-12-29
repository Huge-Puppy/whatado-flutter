import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatado/models/event_user.dart';
import 'package:whatado/screens/profile/user_profile.dart';

class UserListItem extends StatelessWidget {
  final EventUser user;
  UserListItem(this.user);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserProfile(user: user)))
          .then((_) async {
        await Future.delayed(Duration(milliseconds: 500));
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor: Colors.grey[50],
          statusBarColor: Colors.transparent,
        ));
      }),
      child: Expanded(
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrls.first),
              radius: 25,
            ),
            SizedBox(width: 15),
            Text(user.name, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
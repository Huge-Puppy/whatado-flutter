import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatado/screens/profile/create_group.dart';
import 'package:whatado/state/search_state.dart';
import 'package:whatado/state/user_state.dart';
import 'package:whatado/widgets/buttons/rounded_arrow_button.dart';
import 'package:whatado/widgets/events/shadow_box.dart';
import 'package:whatado/widgets/general/dark_divider.dart';
import 'package:whatado/widgets/groups/group_list_item.dart';

class SearchGroups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchState>(context);
    final userState = Provider.of<UserState>(context);
    int groupsLength = searchState.filteredGroups?.length ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          RoundedArrowButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroup())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_add),
                  SizedBox(width: 10),
                  Text('Create Group', style: TextStyle(fontSize: 20))
                ],
              )),
          SizedBox(height: 20),
          Flexible(
            child: ShadowBox(
              padding: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Text('Suggested Groups',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DarkDivider(),
                  ),
                  getMainWidget(searchState, userState, groupsLength),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget getMainWidget(SearchState searchState, UserState userState, groupsLength) {
    if (searchState.groupsLoading || searchState.filteredGroups == null) {
      return Container(height: 200, child: Center(child: CircularProgressIndicator()));
    }
    if (searchState.filteredGroups!.isEmpty) {
      return Container(height: 200, child: Center(child: Text('No groups to list')));
    }
    return Flexible(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: groupsLength,
          itemBuilder: (context, i) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
                child: GroupListItem(
                    noPadding: true,
                    showButton: true,
                    group: searchState.filteredGroups![i],
                    requested: userState.user!.requestedGroups
                        .any((g) => g.id == searchState.filteredGroups![i].id),
                    member: userState.user!.groups
                        .any((g) => g.id == searchState.filteredGroups![i].id)));
          }),
    );
  }
}

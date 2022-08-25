import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geojson/geojson.dart';
import 'package:provider/provider.dart';
import 'package:whatado/constants.dart';
import 'package:whatado/graphql/mutations_graphql_api.graphql.dart';
import 'package:whatado/models/event_user.dart';
import 'package:whatado/models/group.dart';
import 'package:whatado/models/group_icon.dart';
import 'package:whatado/providers/graphql/group_provider.dart';
import 'package:whatado/state/home_state.dart';
import 'package:whatado/state/user_state.dart';
import 'package:whatado/utils/list_tools.dart';
import 'package:whatado/widgets/appbars/saving_app_bar.dart';
import 'package:whatado/widgets/general/generic_page.dart';
import 'package:whatado/widgets/input/my_text_field.dart';

class EditGroupDetails extends StatefulWidget {
  final Group group;
  EditGroupDetails({required this.group});
  @override
  State<StatefulWidget> createState() => _EditGroupDetailsState();
}

class _EditGroupDetailsState extends State<EditGroupDetails> {
  late List<PublicUser> selectedFriends = [];
  late List<PublicUser> defaultFriends;
  late TextEditingController groupNameController;
  late TextEditingController groupLocationController;
  late bool loading = false;
  late bool changeIcon = false;
  late bool screened;
  GeoJsonPoint? coordinates;
  List<GroupIcon>? groupIcons;
  GroupIcon? selectedIcon;
  late bool iconsLoading = true;

  @override
  initState() {
    super.initState();
    selectedIcon = widget.group.icon;
    coordinates = widget.group.location;
    screened = widget.group.screened;
    defaultFriends = List<PublicUser>.from(widget.group.users);
    groupNameController = TextEditingController(text: widget.group.name);
    groupNameController.addListener(() => setState(() {}));
    groupLocationController = TextEditingController();
    groupLocationController.addListener(() => setState(() {}));
    init();
  }

  Future<void> init() async {
    final provider = GroupGqlProvider();
    final result = await provider.groupIcons();
    setState(() {
      groupIcons = result.data;
      iconsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    final homeState = Provider.of<HomeState>(context);
    final headingStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    List<PublicUser> groupList = [...defaultFriends, ...homeState.selectedUsers];
    return GenericPage(
      appBar: SavingAppBar(
          title: 'Edit Group',
          disabled: loading ||
              (groupNameController.text == widget.group.name &&
                  selectedIcon?.id == widget.group.id &&
                  screened == widget.group.screened &&
                  coordinates == widget.group.location),
          buttonTitle: 'SAVE',
          onSave: () async {
            setState(() => loading = true);
            final response = await GroupGqlProvider().updateGroup(GroupFilterInput(
                id: widget.group.id,
                groupIconId: selectedIcon?.id ?? widget.group.id,
                location: coordinates ?? widget.group.location,
                screened: screened,
                name: groupNameController.text,
                userIds: [...groupList.map((u) => u.id)]));
            homeState.setSelectedGroup([]);
            if (response.ok) {
              await userState.getUser();
              BotToast.showText(text: 'Successfully edited group');
            } else {
              BotToast.showText(text: 'Error editing group');
            }
            setState(() => loading = false);
            Navigator.popUntil(context, (route) => route.isFirst);
          }),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Name', style: headingStyle),
              SizedBox(height: 20),
              MyTextField(
                hintText: 'Group Name',
                controller: groupNameController,
                validator: (val) => (val?.isEmpty ?? true) ? 'please enter a name' : null,
              ),
              SizedBox(height: 20),
              if (selectedIcon != null) ...[
                Row(
                  children: [
                    Container(
                        height: 75,
                        width: 75,
                        child: CachedNetworkImage(imageUrl: selectedIcon!.url)),
                    SizedBox(width: 20),
                    TextButton(
                        onPressed: () => setState(() => changeIcon = !changeIcon),
                        child: Text(changeIcon ? 'Hide Icons' : 'Change Icon'))
                  ],
                ),
                SizedBox(height: 20)
              ],
              if (iconsLoading) Center(child: CircularProgressIndicator()),
              if (!iconsLoading && (selectedIcon == null || changeIcon))
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: groupIcons
                              ?.map((i) => InkWell(
                                    onTap: () => setState(() => selectedIcon = i),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      height: 75,
                                      width: 75,
                                      child: CachedNetworkImage(
                                        imageUrl: i.url,
                                      ),
                                    ),
                                  ))
                              .toList() ??
                          [Text('no icons available')],
                    )),
              Row(
                children: [
                  Switch(
                    onChanged: (newVal) => setState(() => screened = newVal),
                    value: screened,
                    activeColor: AppColors.primary,
                  ),
                  SizedBox(width: 20),
                  Text(screened ? 'Screen Group Members' : 'Anyone Can Join'),
                ],
              ),
            ],
          )),
    );
  }
}

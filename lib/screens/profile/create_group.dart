import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/geopoint.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:whatado/constants.dart';
import 'package:whatado/graphql/mutations_graphql_api.graphql.dart';
import 'package:whatado/models/event_user.dart';
import 'package:whatado/models/group_icon.dart';
import 'package:whatado/models/interest.dart';
import 'package:whatado/providers/graphql/group_provider.dart';
import 'package:whatado/providers/graphql/interest_provider.dart';
import 'package:whatado/services/service_provider.dart';
import 'package:whatado/state/user_state.dart';
import 'package:whatado/utils/extensions/text.dart';
import 'package:whatado/utils/logger.dart';
import 'package:whatado/widgets/appbars/saving_app_bar.dart';
import 'package:whatado/widgets/events/shadow_box.dart';
import 'package:whatado/widgets/general/generic_page.dart';
import 'package:whatado/widgets/input/labeled_outline_text_field.dart';
import 'package:whatado/widgets/interests/combined_interest_search.dart';
import 'package:whatado/widgets/users/user_list_item.dart';

class CreateGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  late List<PublicUser> selectedFriends = [];
  late TextEditingController groupNameController = TextEditingController();
  late TextEditingController groupLocationController = TextEditingController();
  late TextEditingController interestTextController = TextEditingController();
  late bool loading = false;
  late bool iconsLoading = true;
  late bool changeIcon = false;
  late bool screened = true;
  late bool private = true;
  late String displayLocation = '';
  late List<Interest> selectedInterests = [];
  late List<Interest> customInterests = [];
  GeoJsonPoint? coordinates;
  List<Interest>? interests;
  List<GroupIcon>? groupIcons;
  GroupIcon? selectedIcon;

  @override
  void initState() {
    super.initState();
    groupNameController.addListener(() => setState(() {}));
    groupLocationController.addListener(() => setState(() {}));
    interestTextController.addListener(() => setState(() {}));
    init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userState = Provider.of<UserState>(context, listen: false);
      setState(() => interests = userState.user?.interests ?? []);
    });
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
    return GenericPage(
      appBar: SavingAppBar(
          title: 'Create Group',
          disabled: loading ||
              coordinates == null ||
              groupLocationController.text.isEmpty ||
              selectedIcon == null ||
              groupNameController.text.isEmpty,
          buttonTitle: 'CREATE',
          onSave: () async {
            setState(() => loading = true);
            final interestsProvider = InterestGqlProvider();
            final interests = await interestsProvider.create(interestsText: [
              ...(customInterests.map((i) => i.title).toList()),
            ]);
            final relatedInterestIds = List<int>.from(
                [...(interests.data ?? []), ...(selectedInterests.map((i) => i.id).toList())]);
            final response = await GroupGqlProvider().createGroup(GroupInput(
                displayLocation: displayLocation,
                private: private,
                relatedInterestIds: relatedInterestIds,
                name: groupNameController.text,
                location: coordinates!,
                screened: screened,
                groupIconId: selectedIcon!.id,
                owner: userState.user!.id,
                userIds: [userState.user!.id, ...selectedFriends.map((u) => u.id)]));
            if (response.ok) {
              await userState.getUser();
              BotToast.showText(text: 'Successfully created group.');
            } else {
              BotToast.showText(text: 'Failed to create group. Please try again later.');
            }
            setState(() => loading = false);
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                LabeledOutlineTextField(
                  label: 'Group Name',
                  hintText: 'Enter Group Name',
                  controller: groupNameController,
                  validator: (val) => (val?.isEmpty ?? true) ? 'please enter a name' : null,
                ),
                SizedBox(height: 20),
                ShadowBox(
                  child: Row(
                    children: [
                      CupertinoSwitch(
                        onChanged: (newVal) => setState(() => screened = newVal),
                        value: screened,
                        activeColor: AppColors.primary,
                      ),
                      SizedBox(width: 20),
                      Text(screened ? 'Screen Group Members' : 'Anyone Can Join').semibold(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ShadowBox(
                  child: Row(
                    children: [
                      CupertinoSwitch(
                        onChanged: (newVal) => setState(() => private = newVal),
                        value: private,
                        activeColor: AppColors.primary,
                      ),
                      SizedBox(width: 20),
                      Text(private ? 'Private Group' : 'Public Group').semibold(),
                    ],
                  ),
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
                          child: Text(changeIcon ? 'Hide Icons' : 'Change Icon').semibold())
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
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        color: coordinates == null ? AppColors.unfocused : AppColors.primary,
                      ),
                      borderRadius: BorderRadius.circular(AppRadii.button)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Location', style: TextStyle(color: Colors.grey[700])),
                          //   SizedBox(width: 5),
                          //   Tooltip(
                          //     showDuration: Duration(seconds: 3),
                          //     preferBelow: false,
                          //     triggerMode: TooltipTriggerMode.tap,
                          //     margin: EdgeInsets.symmetric(horizontal: 50),
                          //     padding: EdgeInsets.all(8),
                          //     message: "Location is only visible for invited event members.",
                          //     child: Icon(Icons.help_outline, size: 15, color: Colors.grey[700]),
                          //   ),
                        ],
                      ),
                      TypeAheadFormField(
                        direction: AxisDirection.up,
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            borderRadius: BorderRadius.circular(AppRadii.button), offsetX: 30),
                        noItemsFoundBuilder: (context) => SizedBox.shrink(),
                        loadingBuilder: (context) => SizedBox.shrink(),
                        suggestionsBoxVerticalOffset: 40,
                        onSuggestionSelected: (Map<String, dynamic> place) async {
                          groupLocationController.text = place['description'];
                          final location = await placesService.placeDetails(place['place_id']);
                          if (location['geometry']['location']['lat'] == null ||
                              location['geometry']['location']['lng'] == null) {
                            BotToast.showText(
                                text: 'Invalid location; please make another selection.');
                            groupLocationController.text = '';
                          }
                          coordinates = GeoJsonPoint(
                              geoPoint: GeoPoint(
                                  latitude: location['geometry']['location']['lat'],
                                  longitude: location['geometry']['location']['lng']));

                          final parsedLocation = parse(location['adr_address']);
                          final locality = parsedLocation.getElementsByClassName('locality');
                          final region = parsedLocation.getElementsByClassName('region');
                          final country = parsedLocation.getElementsByClassName('country-name');
                          displayLocation = locality.isEmpty
                              ? region.isEmpty
                                  ? country.isEmpty
                                      ? 'N/A'
                                      : country.first.innerHtml
                                  : region.first.innerHtml
                              : locality.first.innerHtml;
                          setState(() {
                            coordinates = coordinates;
                            displayLocation = displayLocation;
                          });
                        },
                        suggestionsCallback: (String pattern) async {
                          final result =
                              await placesService.findPlace(pattern, userState.user?.location);
                          return result;
                        },
                        itemBuilder: (context, Map<String, dynamic> place) =>
                            ListTile(title: Text(place['description'])),
                        textFieldConfiguration: TextFieldConfiguration(
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter location',
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          controller: groupLocationController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                if (interests == null)
                  Center(child: CircularProgressIndicator())
                else
                  CombinedInterestSearch(
                      textController: interestTextController,
                      interests: interests!,
                      customInterests: customInterests,
                      selectedInterests: selectedInterests,
                      addCustomInterest: (Interest i) {
                        customInterests.add(i);
                        setState(() => customInterests = customInterests);
                      },
                      addInterest: (Interest i) {
                        selectedInterests.add(i);
                        setState(() => selectedInterests = selectedInterests);
                      },
                      removeCustomInterest: (Interest i) {
                        customInterests.remove(i);
                        setState(() => customInterests = customInterests);
                      },
                      removeInterest: (Interest i) {
                        selectedInterests.remove(i);
                        setState(() => selectedInterests = selectedInterests);
                      },
                      tooltipMessage: 'What interests does the group focus on?'),
                SizedBox(height: 20),
                // if (friends == null || friends.isEmpty)
                //   Expanded(child: Center(child: Text('no friends'))),
                // if (friends != null && friends.isNotEmpty)
                //   Expanded(
                //     child: ListView.builder(
                //         itemCount: friends.length,
                //         itemBuilder: (context, i) {
                //           PublicUser friend = friends[i];
                //           return InkWell(
                //             onTap: () {
                //               if (selectedFriends.contains(friend)) {
                //                 selectedFriends.remove(friend);
                //               } else {
                //                 selectedFriends.add(friend);
                //               }
                //               setState(() => selectedFriends = selectedFriends);
                //             },
                //             child: Padding(
                //               padding: const EdgeInsets.symmetric(vertical: 8.0),
                //               child: IgnorePointer(
                //                   child: UserListItem(
                //                 friend,
                //                 selected: selectedFriends.contains(friend),
                //               )),
                //             ),
                //           );
                //         }),
                //   )
              ],
            )),
      ),
    );
  }
}

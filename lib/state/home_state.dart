import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/geopoint.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:whatado/graphql/mutations_graphql_api.graphql.dart';
import 'package:whatado/models/ad.dart';
import 'package:whatado/models/chat.dart';
import 'package:whatado/models/event.dart';
import 'package:whatado/models/event_user.dart';
import 'package:whatado/models/forum.dart';
import 'package:whatado/models/public_event.dart';
import 'package:whatado/providers/graphql/chat_provider.dart';
import 'package:whatado/providers/graphql/events_provider.dart';
import 'package:whatado/providers/graphql/forums_provider.dart';
import 'package:whatado/graphql/queries_graphql_api.dart';
import 'package:whatado/providers/graphql/user_provider.dart';
import 'package:whatado/services/service_provider.dart';
import 'package:whatado/utils/logger.dart';

enum MySortType {
  mine,
  invited,
  current,
  past,
}

class HomeState extends ChangeNotifier {
  int _appBarPageNo;
  int _bottomBarPageNo;
  int _skip;
  bool _favoritesEmpty;
  bool _othersEmpty;
  bool? _locationPermission;
  DateTime? _selectedDate;
  SortType _sortType;
  MySortType _mySortType;

  GlobalKey showcase_1;
  GlobalKey showcase_2;
  GlobalKey showcase_3;
  GlobalKey showcase_4;

  RefreshController refreshController;
  RefreshController myEventsRefreshController;
  PageController homePageController;
  ScrollController allEventsScrollController;
  ScrollController myProfileScrollController;

  StreamSubscription? appBarResetSub;
  StreamController? appBarResetController;
  List<PublicEvent>? allEvents;
  List<PublicEvent>? otherEvents;
  List<Ad>? allAds;
  List<Event>? myEvents;
  List<Forum>? myForums;
  List<Map<String, dynamic>>? lastMessages;

  // for group selection
  List<PublicUser> selectedUsers;

  HomeState()
      : _appBarPageNo = 0,
        _bottomBarPageNo = 0,
        _skip = 0,
        _favoritesEmpty = false,
        _othersEmpty = false,
        showcase_1 = GlobalKey(),
        showcase_2 = GlobalKey(),
        showcase_3 = GlobalKey(),
        showcase_4 = GlobalKey(),
        selectedUsers = [],
        otherEvents = [],
        homePageController = PageController(keepPage: true),
        allEventsScrollController = ScrollController(),
        myProfileScrollController = ScrollController(),
        refreshController = RefreshController(initialRefresh: false),
        myEventsRefreshController = RefreshController(initialRefresh: false),
        _sortType = SortType.newest,
        _mySortType = MySortType.current {
    allEventsScrollController.addListener(() async {
      if (allEventsScrollController.position.atEdge &&
          allEventsScrollController.position.pixels != 0) {
        await getNewEvents();
      }
    });
    appBarResetController = StreamController<int>();
    appBarResetSub = appBarResetController?.stream.listen((val) {
      _appBarPageNo = 0;
      if (homePageController.hasClients)
        homePageController.animateTo(0,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      notifyListeners();
    });
  }

  Future<void> load() async {
    await getNewEvents();
    final myEvents = await getMyEvents();
    if (myEvents == null || myEvents.isEmpty) {
      myForums = [];
      lastMessages = [];
    } else {
      await getMyForums();
    }
  }

  Future<bool> loadLocation() async {
    if (locationService.locationData != null &&
        locationService.locationData!.latitude != null &&
        locationService.locationData!.longitude != null) {
      _locationPermission = true;
      notifyListeners();
      UserGqlProvider provider = UserGqlProvider();
      final result = await provider.updateUser(UserFilterInput(
          location: GeoJsonPoint(
              geoPoint: GeoPoint(
                  latitude: locationService.locationData!.latitude!,
                  longitude: locationService.locationData!.longitude!))));
      return result.ok;
    }
    _locationPermission = false;
    notifyListeners();
    return false;
  }

  @override
  void dispose() {
    allEventsScrollController.dispose();
    homePageController.dispose();
    refreshController.dispose();
    myEventsRefreshController.dispose();
    appBarResetController?.close();
    appBarResetSub?.cancel();
    super.dispose();
  }

  bool? get locationPermission => _locationPermission;
  set locationPermission(bool? newStatus) {
    _locationPermission = newStatus;
    notifyListeners();
  }

  MySortType get mySortType => _mySortType;

  set mySortType(MySortType myEventSortType) {
    _mySortType = myEventSortType;
    notifyListeners();
  }

  SortType get sortType => _sortType;
  set sortType(SortType sortType) {
    _sortType = sortType;
    notifyListeners();
  }

  int get appBarPageNo => _appBarPageNo;
  set appBarPageNo(int newPageNo) {
    _appBarPageNo = newPageNo;
    notifyListeners();
  }

  int get bottomBarPageNo => _bottomBarPageNo;
  set bottomBarPageNo(int newPageNo) {
    _bottomBarPageNo = newPageNo;
    appBarResetController?.add(_bottomBarPageNo);
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? beginDateIndex) {
    if (_selectedDate != beginDateIndex) {
      allEvents = null;
      otherEvents = null;
      _skip = 0;
    }
    _selectedDate = beginDateIndex;
    notifyListeners();
  }

  void turnPage(int newPageNo) {
    if ((this.appBarPageNo - newPageNo).abs() == 1) {
      this
          .homePageController
          .animateToPage(newPageNo, duration: Duration(milliseconds: 200), curve: Curves.easeInOut)
          .then((_) => notifyListeners());
    } else {
      homePageController.jumpToPage(newPageNo);
    }
    notifyListeners();
  }

  Future<void> otherEventsRequest() async {
    final query = EventsGqlProvider();
    final start = _selectedDate ?? DateTime.now();
    final end = _selectedDate?.add(Duration(days: 1)) ?? DateTime.now().add(Duration(days: 1000));
    // events related to interests are empty, get others
    final response = await query.otherEvents(start, end, 20, _skip, _sortType);
    _skip += response.data?.length ?? 0;
    if ((response.data?.length ?? 0) < 20) {
      _othersEmpty = true;
      _skip = 0;
    }
    if (otherEvents == null)
      otherEvents = response.data ?? [];
    else
      otherEvents!.addAll(response.data ?? []);
  }

  Future<void> getNewEvents() async {
    final query = EventsGqlProvider();
    final start = _selectedDate ?? DateTime.now();
    final end = _selectedDate?.add(Duration(days: 1)) ?? DateTime.now().add(Duration(days: 1000));
    if (_favoritesEmpty && !_othersEmpty) {
      await otherEventsRequest();
    } else if (!_favoritesEmpty) {
      // get events related to interests
      final response = await query.events(start, end, 20, _skip, _sortType);
      _skip += response.data?.length ?? 0;
      if (allEvents == null) {
        allEvents = response.data ?? [];
      } else {
        allEvents!.addAll(response.data ?? []);
      }
      if ((response.data?.length ?? 0) < 20) {
        _favoritesEmpty = true;
        _skip = 0;
        await otherEventsRequest();
      }
    }
    allAds = [];
    notifyListeners();
  }

  Future<List<Event>?> getMyEvents() async {
    final query = EventsGqlProvider();
    final response = await query.myEvents();
    myEvents = response.data ?? [];
    notifyListeners();
    return myEvents;
  }

  Future<List<Forum>?> getMyForums() async {
    final query = ForumsGqlProvider();
    final response = await query.myForums(myEvents?.map((event) => event.id).toList() ?? []);
    myForums = response.data ?? [];
    await getFirstChats();
    notifyListeners();
    return myForums;
  }

  Future<List<Map<String, dynamic>>?> getFirstChats() async {
    final chatQuery = ChatGqlProvider();
    if (myForums == null) return [];
    final List<Map<String, dynamic>> tempChats = [];
    await Future.wait(myForums!.map((forum) async {
      final response = await chatQuery.lastChat(forum.id);
      tempChats.add({'forumId': forum.id, 'chat': response.data});
    }));
    lastMessages = tempChats;
    notifyListeners();
    sortForumsChats();
    return tempChats;
  }

  void sortForumsChats() {
    lastMessages?.sort((a, b) {
      if (a['chat'] == null && b['chat'] == null) return 0;
      if (a['chat'] == null) return 1;
      if (b['chat'] == null) return -1;
      return b['chat']?.createdAt.compareTo(a['chat'].createdAt);
    });
    myForums?.sort((a, b) =>
        lastMessages
            ?.indexWhere((obj) => obj['forumId'] == a.id)
            .compareTo(lastMessages?.indexWhere((obj) => obj['forumId'] == b.id) ?? 1) ??
        0.compareTo(1));
    notifyListeners();
  }

  Future<void> myEventsRefresh() async {
    try {
      final result = await getMyEvents();
      if ((result?.length ?? 0) > 0) await getMyForums();
      myEventsRefreshController.refreshCompleted();
    } catch (e) {
      logger.e(e);
      myEventsRefreshController.refreshFailed();
    }
  }

  Future<void> allEventsRefresh() async {
    try {
      allEvents = null;
      otherEvents = [];
      _skip = 0;
      _favoritesEmpty = false;
      _othersEmpty = false;
      await getNewEvents();
      refreshController.refreshCompleted();
    } catch (e) {
      logger.e(e);
      refreshController.refreshFailed();
    }
  }

  Future<Chat?> getLastChat(int forumId) async {
    final chatQuery = ChatGqlProvider();
    final chatResult = await chatQuery.lastChat(forumId);
    return chatResult.data;
  }

  void updateEvent(PublicEvent event) {
    int index = allEvents?.indexWhere((val) => val.id == event.id) ?? -1;
    if (index == -1) {
      index = otherEvents?.indexWhere((val) => val.id == event.id) ?? -1;
      if (index == -1) {
        return;
      }
      otherEvents![index] = event;
      notifyListeners();
      return;
    }
    allEvents![index] = event;
    notifyListeners();
  }

  void removeEvent(int eventId) {
    if (allEvents?.any((event) => event.id == eventId) ?? false)
      allEvents?.removeWhere((event) => event.id == eventId);
    if (otherEvents?.any((event) => event.id == eventId) ?? false)
      otherEvents?.removeWhere((event) => event.id == eventId);
    if (myEvents?.any((event) => event.id == eventId) ?? false) {
      myEvents?.removeWhere((event) => event.id == eventId);
      myForums?.removeWhere((forum) => forum.eventId == eventId);
    }
    notifyListeners();
  }

  void updateMyEvent(Event event) {
    final int myindex = myEvents?.indexWhere((val) => val.id == event.id) ?? -1;
    if (myindex == -1) {
      return;
    }
    myEvents![myindex] = event;
    notifyListeners();
  }

  void accessForum(Forum forum) {
    final int myindex = myForums?.indexWhere((val) => val.id == forum.id) ?? -1;
    if (myindex == -1) {
      return;
    }
    forum.userNotification.lastAccessed = DateTime.now();
    myForums![myindex] = forum;
    notifyListeners();
  }

  void updateForum(Forum forum) {
    final int i = myForums?.indexWhere((val) => val.id == forum.id) ?? -1;
    if (i == -1) {
      return;
    }
    myForums![i] = forum;
    notifyListeners();
  }

  void resetGroupSelection() {
    selectedUsers = [];
    notifyListeners();
  }

  void setSelectedGroup(List<PublicUser> newSelectedUsers) {
    selectedUsers = newSelectedUsers;
    notifyListeners();
  }
}

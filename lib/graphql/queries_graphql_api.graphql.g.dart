// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'queries_graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlaggedChats$Query$FlaggedChats$Nodes$Author
    _$FlaggedChats$Query$FlaggedChats$Nodes$AuthorFromJson(
        Map<String, dynamic> json) {
  return FlaggedChats$Query$FlaggedChats$Nodes$Author()
    ..id = json['id'] as int
    ..username = json['username'] as String
    ..profilePhotoUrl = json['profilePhotoUrl'] as String;
}

Map<String, dynamic> _$FlaggedChats$Query$FlaggedChats$Nodes$AuthorToJson(
        FlaggedChats$Query$FlaggedChats$Nodes$Author instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profilePhotoUrl': instance.profilePhotoUrl,
    };

FlaggedChats$Query$FlaggedChats$Nodes
    _$FlaggedChats$Query$FlaggedChats$NodesFromJson(Map<String, dynamic> json) {
  return FlaggedChats$Query$FlaggedChats$Nodes()
    ..id = json['id'] as int
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as String)
    ..text = json['text'] as String
    ..author = FlaggedChats$Query$FlaggedChats$Nodes$Author.fromJson(
        json['author'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FlaggedChats$Query$FlaggedChats$NodesToJson(
        FlaggedChats$Query$FlaggedChats$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'text': instance.text,
      'author': instance.author.toJson(),
    };

FlaggedChats$Query$FlaggedChats$Errors
    _$FlaggedChats$Query$FlaggedChats$ErrorsFromJson(
        Map<String, dynamic> json) {
  return FlaggedChats$Query$FlaggedChats$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$FlaggedChats$Query$FlaggedChats$ErrorsToJson(
        FlaggedChats$Query$FlaggedChats$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

FlaggedChats$Query$FlaggedChats _$FlaggedChats$Query$FlaggedChatsFromJson(
    Map<String, dynamic> json) {
  return FlaggedChats$Query$FlaggedChats()
    ..ok = json['ok'] as bool?
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map((e) => FlaggedChats$Query$FlaggedChats$Nodes.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => FlaggedChats$Query$FlaggedChats$Errors.fromJson(
            e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FlaggedChats$Query$FlaggedChatsToJson(
        FlaggedChats$Query$FlaggedChats instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'nodes': instance.nodes?.map((e) => e.toJson()).toList(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

FlaggedChats$Query _$FlaggedChats$QueryFromJson(Map<String, dynamic> json) {
  return FlaggedChats$Query()
    ..flaggedChats = FlaggedChats$Query$FlaggedChats.fromJson(
        json['flaggedChats'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FlaggedChats$QueryToJson(FlaggedChats$Query instance) =>
    <String, dynamic>{
      'flaggedChats': instance.flaggedChats.toJson(),
    };

User$Query$User$Nodes _$User$Query$User$NodesFromJson(
    Map<String, dynamic> json) {
  return User$Query$User$Nodes()
    ..id = json['id'] as int
    ..bio = json['bio'] as String
    ..profilePhotoUrl = json['profilePhotoUrl'] as String
    ..photoUrls = json['photoUrls'] as String
    ..username = json['username'] as String;
}

Map<String, dynamic> _$User$Query$User$NodesToJson(
        User$Query$User$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'photoUrls': instance.photoUrls,
      'username': instance.username,
    };

User$Query$User$Errors _$User$Query$User$ErrorsFromJson(
    Map<String, dynamic> json) {
  return User$Query$User$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$User$Query$User$ErrorsToJson(
        User$Query$User$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

User$Query$User _$User$Query$UserFromJson(Map<String, dynamic> json) {
  return User$Query$User()
    ..ok = json['ok'] as bool?
    ..nodes = json['nodes'] == null
        ? null
        : User$Query$User$Nodes.fromJson(json['nodes'] as Map<String, dynamic>)
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => User$Query$User$Errors.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$User$Query$UserToJson(User$Query$User instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'nodes': instance.nodes?.toJson(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

User$Query _$User$QueryFromJson(Map<String, dynamic> json) {
  return User$Query()
    ..user = User$Query$User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$User$QueryToJson(User$Query instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };

Events$Query$Events$Nodes _$Events$Query$Events$NodesFromJson(
    Map<String, dynamic> json) {
  return Events$Query$Events$Nodes()
    ..id = json['id'] as int
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as String)
    ..updatedAt = fromGraphQLDateTimeToDartDateTime(json['updatedAt'] as String)
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..creator = EventFieldsMixin$Creator.fromJson(
        json['creator'] as Map<String, dynamic>)
    ..invited = (json['invited'] as List<dynamic>)
        .map(
            (e) => EventFieldsMixin$Invited.fromJson(e as Map<String, dynamic>))
        .toList()
    ..wannago = (json['wannago'] as List<dynamic>)
        .map(
            (e) => EventFieldsMixin$Wannago.fromJson(e as Map<String, dynamic>))
        .toList()
    ..time = fromGraphQLDateTimeToDartDateTime(json['time'] as String)
    ..location = json['location'] as String
    ..pictureUrl = json['pictureUrl'] as String?
    ..relatedInterests = (json['relatedInterests'] as List<dynamic>)
        .map((e) => EventFieldsMixin$RelatedInterests.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..filterLocation = json['filterLocation'] as String
    ..filterRadius = (json['filterRadius'] as num).toDouble()
    ..filterGender = _$enumDecode(_$GenderEnumMap, json['filterGender'],
        unknownValue: Gender.artemisUnknown)
    ..filterAge = json['filterAge'] as String;
}

Map<String, dynamic> _$Events$Query$Events$NodesToJson(
        Events$Query$Events$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'updatedAt': fromDartDateTimeToGraphQLDateTime(instance.updatedAt),
      'title': instance.title,
      'description': instance.description,
      'creator': instance.creator.toJson(),
      'invited': instance.invited.map((e) => e.toJson()).toList(),
      'wannago': instance.wannago.map((e) => e.toJson()).toList(),
      'time': fromDartDateTimeToGraphQLDateTime(instance.time),
      'location': instance.location,
      'pictureUrl': instance.pictureUrl,
      'relatedInterests':
          instance.relatedInterests.map((e) => e.toJson()).toList(),
      'filterLocation': instance.filterLocation,
      'filterRadius': instance.filterRadius,
      'filterGender': _$GenderEnumMap[instance.filterGender],
      'filterAge': instance.filterAge,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$GenderEnumMap = {
  Gender.both: 'BOTH',
  Gender.female: 'FEMALE',
  Gender.male: 'MALE',
  Gender.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

Events$Query$Events$Errors _$Events$Query$Events$ErrorsFromJson(
    Map<String, dynamic> json) {
  return Events$Query$Events$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$Events$Query$Events$ErrorsToJson(
        Events$Query$Events$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

Events$Query$Events _$Events$Query$EventsFromJson(Map<String, dynamic> json) {
  return Events$Query$Events()
    ..ok = json['ok'] as bool?
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map((e) =>
            Events$Query$Events$Nodes.fromJson(e as Map<String, dynamic>))
        .toList()
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) =>
            Events$Query$Events$Errors.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$Events$Query$EventsToJson(
        Events$Query$Events instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'nodes': instance.nodes?.map((e) => e.toJson()).toList(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

Events$Query _$Events$QueryFromJson(Map<String, dynamic> json) {
  return Events$Query()
    ..events =
        Events$Query$Events.fromJson(json['events'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Events$QueryToJson(Events$Query instance) =>
    <String, dynamic>{
      'events': instance.events.toJson(),
    };

EventFieldsMixin$Creator _$EventFieldsMixin$CreatorFromJson(
    Map<String, dynamic> json) {
  return EventFieldsMixin$Creator()
    ..id = json['id'] as int
    ..username = json['username'] as String
    ..profilePhotoUrl = json['profilePhotoUrl'] as String;
}

Map<String, dynamic> _$EventFieldsMixin$CreatorToJson(
        EventFieldsMixin$Creator instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profilePhotoUrl': instance.profilePhotoUrl,
    };

EventFieldsMixin$Invited _$EventFieldsMixin$InvitedFromJson(
    Map<String, dynamic> json) {
  return EventFieldsMixin$Invited()
    ..id = json['id'] as int
    ..username = json['username'] as String
    ..profilePhotoUrl = json['profilePhotoUrl'] as String;
}

Map<String, dynamic> _$EventFieldsMixin$InvitedToJson(
        EventFieldsMixin$Invited instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profilePhotoUrl': instance.profilePhotoUrl,
    };

EventFieldsMixin$Wannago$User _$EventFieldsMixin$Wannago$UserFromJson(
    Map<String, dynamic> json) {
  return EventFieldsMixin$Wannago$User()
    ..id = json['id'] as int
    ..username = json['username'] as String
    ..profilePhotoUrl = json['profilePhotoUrl'] as String;
}

Map<String, dynamic> _$EventFieldsMixin$Wannago$UserToJson(
        EventFieldsMixin$Wannago$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profilePhotoUrl': instance.profilePhotoUrl,
    };

EventFieldsMixin$Wannago _$EventFieldsMixin$WannagoFromJson(
    Map<String, dynamic> json) {
  return EventFieldsMixin$Wannago()
    ..id = json['id'] as int
    ..declined = json['declined'] as bool
    ..user = EventFieldsMixin$Wannago$User.fromJson(
        json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventFieldsMixin$WannagoToJson(
        EventFieldsMixin$Wannago instance) =>
    <String, dynamic>{
      'id': instance.id,
      'declined': instance.declined,
      'user': instance.user.toJson(),
    };

EventFieldsMixin$RelatedInterests _$EventFieldsMixin$RelatedInterestsFromJson(
    Map<String, dynamic> json) {
  return EventFieldsMixin$RelatedInterests()..id = json['id'] as int;
}

Map<String, dynamic> _$EventFieldsMixin$RelatedInterestsToJson(
        EventFieldsMixin$RelatedInterests instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

DateRangeInput _$DateRangeInputFromJson(Map<String, dynamic> json) {
  return DateRangeInput(
    endDate: fromGraphQLDateTimeToDartDateTime(json['endDate'] as String),
    startDate: fromGraphQLDateTimeToDartDateTime(json['startDate'] as String),
  );
}

Map<String, dynamic> _$DateRangeInputToJson(DateRangeInput instance) =>
    <String, dynamic>{
      'endDate': fromDartDateTimeToGraphQLDateTime(instance.endDate),
      'startDate': fromDartDateTimeToGraphQLDateTime(instance.startDate),
    };

EventUserPreview$Query$UsersById$Errors
    _$EventUserPreview$Query$UsersById$ErrorsFromJson(
        Map<String, dynamic> json) {
  return EventUserPreview$Query$UsersById$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$EventUserPreview$Query$UsersById$ErrorsToJson(
        EventUserPreview$Query$UsersById$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

EventUserPreview$Query$UsersById$Nodes
    _$EventUserPreview$Query$UsersById$NodesFromJson(
        Map<String, dynamic> json) {
  return EventUserPreview$Query$UsersById$Nodes()
    ..id = json['id'] as int
    ..profilePhotoUrl = json['profilePhotoUrl'] as String
    ..username = json['username'] as String;
}

Map<String, dynamic> _$EventUserPreview$Query$UsersById$NodesToJson(
        EventUserPreview$Query$UsersById$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'username': instance.username,
    };

EventUserPreview$Query$UsersById _$EventUserPreview$Query$UsersByIdFromJson(
    Map<String, dynamic> json) {
  return EventUserPreview$Query$UsersById()
    ..ok = json['ok'] as bool?
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => EventUserPreview$Query$UsersById$Errors.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map((e) => EventUserPreview$Query$UsersById$Nodes.fromJson(
            e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$EventUserPreview$Query$UsersByIdToJson(
        EventUserPreview$Query$UsersById instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
      'nodes': instance.nodes?.map((e) => e.toJson()).toList(),
    };

EventUserPreview$Query _$EventUserPreview$QueryFromJson(
    Map<String, dynamic> json) {
  return EventUserPreview$Query()
    ..usersById = EventUserPreview$Query$UsersById.fromJson(
        json['usersById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventUserPreview$QueryToJson(
        EventUserPreview$Query instance) =>
    <String, dynamic>{
      'usersById': instance.usersById.toJson(),
    };

HelloQuery$Query _$HelloQuery$QueryFromJson(Map<String, dynamic> json) {
  return HelloQuery$Query()..hello = json['hello'] as String;
}

Map<String, dynamic> _$HelloQuery$QueryToJson(HelloQuery$Query instance) =>
    <String, dynamic>{
      'hello': instance.hello,
    };

Me$Query$Me$Nodes _$Me$Query$Me$NodesFromJson(Map<String, dynamic> json) {
  return Me$Query$Me$Nodes()
    ..id = json['id'] as int
    ..profilePhotoUrl = json['profilePhotoUrl'] as String
    ..photoUrls = json['photoUrls'] as String
    ..email = json['email'] as String
    ..verified = json['verified'] as bool
    ..username = json['username'] as String
    ..birthday = fromGraphQLDateTimeToDartDateTime(json['birthday'] as String)
    ..bio = json['bio'] as String
    ..interests = (json['interests'] as List<dynamic>)
        .map((e) =>
            UserFieldsMixin$Interests.fromJson(e as Map<String, dynamic>))
        .toList()
    ..myEvents = (json['myEvents'] as List<dynamic>)
        .map(
            (e) => UserFieldsMixin$MyEvents.fromJson(e as Map<String, dynamic>))
        .toList()
    ..chatNotifications = (json['chatNotifications'] as List<dynamic>)
        .map((e) => UserFieldsMixin$ChatNotifications.fromJson(
            e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$Me$Query$Me$NodesToJson(Me$Query$Me$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'photoUrls': instance.photoUrls,
      'email': instance.email,
      'verified': instance.verified,
      'username': instance.username,
      'birthday': fromDartDateTimeToGraphQLDateTime(instance.birthday),
      'bio': instance.bio,
      'interests': instance.interests.map((e) => e.toJson()).toList(),
      'myEvents': instance.myEvents.map((e) => e.toJson()).toList(),
      'chatNotifications':
          instance.chatNotifications.map((e) => e.toJson()).toList(),
    };

Me$Query$Me$Errors _$Me$Query$Me$ErrorsFromJson(Map<String, dynamic> json) {
  return Me$Query$Me$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$Me$Query$Me$ErrorsToJson(Me$Query$Me$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

Me$Query$Me _$Me$Query$MeFromJson(Map<String, dynamic> json) {
  return Me$Query$Me()
    ..ok = json['ok'] as bool?
    ..nodes = json['nodes'] == null
        ? null
        : Me$Query$Me$Nodes.fromJson(json['nodes'] as Map<String, dynamic>)
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => Me$Query$Me$Errors.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$Me$Query$MeToJson(Me$Query$Me instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'nodes': instance.nodes?.toJson(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

Me$Query _$Me$QueryFromJson(Map<String, dynamic> json) {
  return Me$Query()
    ..me = Me$Query$Me.fromJson(json['me'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Me$QueryToJson(Me$Query instance) => <String, dynamic>{
      'me': instance.me.toJson(),
    };

UserFieldsMixin$Interests _$UserFieldsMixin$InterestsFromJson(
    Map<String, dynamic> json) {
  return UserFieldsMixin$Interests()
    ..id = json['id'] as int
    ..title = json['title'] as String;
}

Map<String, dynamic> _$UserFieldsMixin$InterestsToJson(
        UserFieldsMixin$Interests instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

UserFieldsMixin$MyEvents _$UserFieldsMixin$MyEventsFromJson(
    Map<String, dynamic> json) {
  return UserFieldsMixin$MyEvents()..id = json['id'] as int;
}

Map<String, dynamic> _$UserFieldsMixin$MyEventsToJson(
        UserFieldsMixin$MyEvents instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UserFieldsMixin$ChatNotifications _$UserFieldsMixin$ChatNotificationsFromJson(
    Map<String, dynamic> json) {
  return UserFieldsMixin$ChatNotifications()
    ..notifications = json['notifications'] as int
    ..muted = json['muted'] as bool;
}

Map<String, dynamic> _$UserFieldsMixin$ChatNotificationsToJson(
        UserFieldsMixin$ChatNotifications instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'muted': instance.muted,
    };

ForumsByEventId$Query$ForumsByEventId$Errors
    _$ForumsByEventId$Query$ForumsByEventId$ErrorsFromJson(
        Map<String, dynamic> json) {
  return ForumsByEventId$Query$ForumsByEventId$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ForumsByEventId$Query$ForumsByEventId$ErrorsToJson(
        ForumsByEventId$Query$ForumsByEventId$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

ForumsByEventId$Query$ForumsByEventId$Nodes$UserNotifications
    _$ForumsByEventId$Query$ForumsByEventId$Nodes$UserNotificationsFromJson(
        Map<String, dynamic> json) {
  return ForumsByEventId$Query$ForumsByEventId$Nodes$UserNotifications()
    ..id = json['id'] as int
    ..notifications = json['notifications'] as int
    ..muted = json['muted'] as bool;
}

Map<String, dynamic>
    _$ForumsByEventId$Query$ForumsByEventId$Nodes$UserNotificationsToJson(
            ForumsByEventId$Query$ForumsByEventId$Nodes$UserNotifications
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'notifications': instance.notifications,
          'muted': instance.muted,
        };

ForumsByEventId$Query$ForumsByEventId$Nodes$Event
    _$ForumsByEventId$Query$ForumsByEventId$Nodes$EventFromJson(
        Map<String, dynamic> json) {
  return ForumsByEventId$Query$ForumsByEventId$Nodes$Event()
    ..id = json['id'] as int;
}

Map<String, dynamic> _$ForumsByEventId$Query$ForumsByEventId$Nodes$EventToJson(
        ForumsByEventId$Query$ForumsByEventId$Nodes$Event instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

ForumsByEventId$Query$ForumsByEventId$Nodes
    _$ForumsByEventId$Query$ForumsByEventId$NodesFromJson(
        Map<String, dynamic> json) {
  return ForumsByEventId$Query$ForumsByEventId$Nodes()
    ..id = json['id'] as int
    ..userNotifications = (json['userNotifications'] as List<dynamic>)
        .map((e) =>
            ForumsByEventId$Query$ForumsByEventId$Nodes$UserNotifications
                .fromJson(e as Map<String, dynamic>))
        .toList()
    ..event = ForumsByEventId$Query$ForumsByEventId$Nodes$Event.fromJson(
        json['event'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ForumsByEventId$Query$ForumsByEventId$NodesToJson(
        ForumsByEventId$Query$ForumsByEventId$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userNotifications':
          instance.userNotifications.map((e) => e.toJson()).toList(),
      'event': instance.event.toJson(),
    };

ForumsByEventId$Query$ForumsByEventId
    _$ForumsByEventId$Query$ForumsByEventIdFromJson(Map<String, dynamic> json) {
  return ForumsByEventId$Query$ForumsByEventId()
    ..ok = json['ok'] as bool?
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => ForumsByEventId$Query$ForumsByEventId$Errors.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map((e) => ForumsByEventId$Query$ForumsByEventId$Nodes.fromJson(
            e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ForumsByEventId$Query$ForumsByEventIdToJson(
        ForumsByEventId$Query$ForumsByEventId instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
      'nodes': instance.nodes?.map((e) => e.toJson()).toList(),
    };

ForumsByEventId$Query _$ForumsByEventId$QueryFromJson(
    Map<String, dynamic> json) {
  return ForumsByEventId$Query()
    ..forumsByEventId = ForumsByEventId$Query$ForumsByEventId.fromJson(
        json['forumsByEventId'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ForumsByEventId$QueryToJson(
        ForumsByEventId$Query instance) =>
    <String, dynamic>{
      'forumsByEventId': instance.forumsByEventId.toJson(),
    };

FlaggedEvents$Query$FlaggedEvents$Nodes
    _$FlaggedEvents$Query$FlaggedEvents$NodesFromJson(
        Map<String, dynamic> json) {
  return FlaggedEvents$Query$FlaggedEvents$Nodes()
    ..id = json['id'] as int
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as String)
    ..updatedAt = fromGraphQLDateTimeToDartDateTime(json['updatedAt'] as String)
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..creator = EventFieldsMixin$Creator.fromJson(
        json['creator'] as Map<String, dynamic>)
    ..invited = (json['invited'] as List<dynamic>)
        .map(
            (e) => EventFieldsMixin$Invited.fromJson(e as Map<String, dynamic>))
        .toList()
    ..wannago = (json['wannago'] as List<dynamic>)
        .map(
            (e) => EventFieldsMixin$Wannago.fromJson(e as Map<String, dynamic>))
        .toList()
    ..time = fromGraphQLDateTimeToDartDateTime(json['time'] as String)
    ..location = json['location'] as String
    ..pictureUrl = json['pictureUrl'] as String?
    ..relatedInterests = (json['relatedInterests'] as List<dynamic>)
        .map((e) => EventFieldsMixin$RelatedInterests.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..filterLocation = json['filterLocation'] as String
    ..filterRadius = (json['filterRadius'] as num).toDouble()
    ..filterGender = _$enumDecode(_$GenderEnumMap, json['filterGender'],
        unknownValue: Gender.artemisUnknown)
    ..filterAge = json['filterAge'] as String;
}

Map<String, dynamic> _$FlaggedEvents$Query$FlaggedEvents$NodesToJson(
        FlaggedEvents$Query$FlaggedEvents$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'updatedAt': fromDartDateTimeToGraphQLDateTime(instance.updatedAt),
      'title': instance.title,
      'description': instance.description,
      'creator': instance.creator.toJson(),
      'invited': instance.invited.map((e) => e.toJson()).toList(),
      'wannago': instance.wannago.map((e) => e.toJson()).toList(),
      'time': fromDartDateTimeToGraphQLDateTime(instance.time),
      'location': instance.location,
      'pictureUrl': instance.pictureUrl,
      'relatedInterests':
          instance.relatedInterests.map((e) => e.toJson()).toList(),
      'filterLocation': instance.filterLocation,
      'filterRadius': instance.filterRadius,
      'filterGender': _$GenderEnumMap[instance.filterGender],
      'filterAge': instance.filterAge,
    };

FlaggedEvents$Query$FlaggedEvents$Errors
    _$FlaggedEvents$Query$FlaggedEvents$ErrorsFromJson(
        Map<String, dynamic> json) {
  return FlaggedEvents$Query$FlaggedEvents$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$FlaggedEvents$Query$FlaggedEvents$ErrorsToJson(
        FlaggedEvents$Query$FlaggedEvents$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

FlaggedEvents$Query$FlaggedEvents _$FlaggedEvents$Query$FlaggedEventsFromJson(
    Map<String, dynamic> json) {
  return FlaggedEvents$Query$FlaggedEvents()
    ..ok = json['ok'] as bool?
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map((e) => FlaggedEvents$Query$FlaggedEvents$Nodes.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => FlaggedEvents$Query$FlaggedEvents$Errors.fromJson(
            e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FlaggedEvents$Query$FlaggedEventsToJson(
        FlaggedEvents$Query$FlaggedEvents instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'nodes': instance.nodes?.map((e) => e.toJson()).toList(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

FlaggedEvents$Query _$FlaggedEvents$QueryFromJson(Map<String, dynamic> json) {
  return FlaggedEvents$Query()
    ..flaggedEvents = FlaggedEvents$Query$FlaggedEvents.fromJson(
        json['flaggedEvents'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FlaggedEvents$QueryToJson(
        FlaggedEvents$Query instance) =>
    <String, dynamic>{
      'flaggedEvents': instance.flaggedEvents.toJson(),
    };

MyEvents$Query$MyEvents$Nodes _$MyEvents$Query$MyEvents$NodesFromJson(
    Map<String, dynamic> json) {
  return MyEvents$Query$MyEvents$Nodes()
    ..id = json['id'] as int
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as String)
    ..updatedAt = fromGraphQLDateTimeToDartDateTime(json['updatedAt'] as String)
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..creator = EventFieldsMixin$Creator.fromJson(
        json['creator'] as Map<String, dynamic>)
    ..invited = (json['invited'] as List<dynamic>)
        .map(
            (e) => EventFieldsMixin$Invited.fromJson(e as Map<String, dynamic>))
        .toList()
    ..wannago = (json['wannago'] as List<dynamic>)
        .map(
            (e) => EventFieldsMixin$Wannago.fromJson(e as Map<String, dynamic>))
        .toList()
    ..time = fromGraphQLDateTimeToDartDateTime(json['time'] as String)
    ..location = json['location'] as String
    ..pictureUrl = json['pictureUrl'] as String?
    ..relatedInterests = (json['relatedInterests'] as List<dynamic>)
        .map((e) => EventFieldsMixin$RelatedInterests.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..filterLocation = json['filterLocation'] as String
    ..filterRadius = (json['filterRadius'] as num).toDouble()
    ..filterGender = _$enumDecode(_$GenderEnumMap, json['filterGender'],
        unknownValue: Gender.artemisUnknown)
    ..filterAge = json['filterAge'] as String;
}

Map<String, dynamic> _$MyEvents$Query$MyEvents$NodesToJson(
        MyEvents$Query$MyEvents$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'updatedAt': fromDartDateTimeToGraphQLDateTime(instance.updatedAt),
      'title': instance.title,
      'description': instance.description,
      'creator': instance.creator.toJson(),
      'invited': instance.invited.map((e) => e.toJson()).toList(),
      'wannago': instance.wannago.map((e) => e.toJson()).toList(),
      'time': fromDartDateTimeToGraphQLDateTime(instance.time),
      'location': instance.location,
      'pictureUrl': instance.pictureUrl,
      'relatedInterests':
          instance.relatedInterests.map((e) => e.toJson()).toList(),
      'filterLocation': instance.filterLocation,
      'filterRadius': instance.filterRadius,
      'filterGender': _$GenderEnumMap[instance.filterGender],
      'filterAge': instance.filterAge,
    };

MyEvents$Query$MyEvents$Errors _$MyEvents$Query$MyEvents$ErrorsFromJson(
    Map<String, dynamic> json) {
  return MyEvents$Query$MyEvents$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$MyEvents$Query$MyEvents$ErrorsToJson(
        MyEvents$Query$MyEvents$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

MyEvents$Query$MyEvents _$MyEvents$Query$MyEventsFromJson(
    Map<String, dynamic> json) {
  return MyEvents$Query$MyEvents()
    ..ok = json['ok'] as bool?
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map((e) =>
            MyEvents$Query$MyEvents$Nodes.fromJson(e as Map<String, dynamic>))
        .toList()
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) =>
            MyEvents$Query$MyEvents$Errors.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MyEvents$Query$MyEventsToJson(
        MyEvents$Query$MyEvents instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'nodes': instance.nodes?.map((e) => e.toJson()).toList(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

MyEvents$Query _$MyEvents$QueryFromJson(Map<String, dynamic> json) {
  return MyEvents$Query()
    ..myEvents = MyEvents$Query$MyEvents.fromJson(
        json['myEvents'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MyEvents$QueryToJson(MyEvents$Query instance) =>
    <String, dynamic>{
      'myEvents': instance.myEvents.toJson(),
    };

SearchInterests$Query$SearchInterests$Nodes
    _$SearchInterests$Query$SearchInterests$NodesFromJson(
        Map<String, dynamic> json) {
  return SearchInterests$Query$SearchInterests$Nodes()
    ..id = json['id'] as int
    ..title = json['title'] as String;
}

Map<String, dynamic> _$SearchInterests$Query$SearchInterests$NodesToJson(
        SearchInterests$Query$SearchInterests$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

SearchInterests$Query$SearchInterests$Errors
    _$SearchInterests$Query$SearchInterests$ErrorsFromJson(
        Map<String, dynamic> json) {
  return SearchInterests$Query$SearchInterests$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$SearchInterests$Query$SearchInterests$ErrorsToJson(
        SearchInterests$Query$SearchInterests$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

SearchInterests$Query$SearchInterests
    _$SearchInterests$Query$SearchInterestsFromJson(Map<String, dynamic> json) {
  return SearchInterests$Query$SearchInterests()
    ..ok = json['ok'] as bool?
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map((e) => SearchInterests$Query$SearchInterests$Nodes.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => SearchInterests$Query$SearchInterests$Errors.fromJson(
            e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$SearchInterests$Query$SearchInterestsToJson(
        SearchInterests$Query$SearchInterests instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'nodes': instance.nodes?.map((e) => e.toJson()).toList(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

SearchInterests$Query _$SearchInterests$QueryFromJson(
    Map<String, dynamic> json) {
  return SearchInterests$Query()
    ..searchInterests = SearchInterests$Query$SearchInterests.fromJson(
        json['searchInterests'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SearchInterests$QueryToJson(
        SearchInterests$Query instance) =>
    <String, dynamic>{
      'searchInterests': instance.searchInterests.toJson(),
    };

LastChat$Query$LastChat$Errors _$LastChat$Query$LastChat$ErrorsFromJson(
    Map<String, dynamic> json) {
  return LastChat$Query$LastChat$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$LastChat$Query$LastChat$ErrorsToJson(
        LastChat$Query$LastChat$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

LastChat$Query$LastChat$Nodes$Author
    _$LastChat$Query$LastChat$Nodes$AuthorFromJson(Map<String, dynamic> json) {
  return LastChat$Query$LastChat$Nodes$Author()
    ..id = json['id'] as int
    ..username = json['username'] as String
    ..profilePhotoUrl = json['profilePhotoUrl'] as String;
}

Map<String, dynamic> _$LastChat$Query$LastChat$Nodes$AuthorToJson(
        LastChat$Query$LastChat$Nodes$Author instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profilePhotoUrl': instance.profilePhotoUrl,
    };

LastChat$Query$LastChat$Nodes _$LastChat$Query$LastChat$NodesFromJson(
    Map<String, dynamic> json) {
  return LastChat$Query$LastChat$Nodes()
    ..id = json['id'] as int
    ..text = json['text'] as String
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as String)
    ..author = LastChat$Query$LastChat$Nodes$Author.fromJson(
        json['author'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LastChat$Query$LastChat$NodesToJson(
        LastChat$Query$LastChat$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'author': instance.author.toJson(),
    };

LastChat$Query$LastChat _$LastChat$Query$LastChatFromJson(
    Map<String, dynamic> json) {
  return LastChat$Query$LastChat()
    ..ok = json['ok'] as bool?
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) =>
            LastChat$Query$LastChat$Errors.fromJson(e as Map<String, dynamic>))
        .toList()
    ..nodes = json['nodes'] == null
        ? null
        : LastChat$Query$LastChat$Nodes.fromJson(
            json['nodes'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LastChat$Query$LastChatToJson(
        LastChat$Query$LastChat instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
      'nodes': instance.nodes?.toJson(),
    };

LastChat$Query _$LastChat$QueryFromJson(Map<String, dynamic> json) {
  return LastChat$Query()
    ..lastChat = LastChat$Query$LastChat.fromJson(
        json['lastChat'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LastChat$QueryToJson(LastChat$Query instance) =>
    <String, dynamic>{
      'lastChat': instance.lastChat.toJson(),
    };

Chats$Query$Chats$Nodes$Author _$Chats$Query$Chats$Nodes$AuthorFromJson(
    Map<String, dynamic> json) {
  return Chats$Query$Chats$Nodes$Author()
    ..id = json['id'] as int
    ..profilePhotoUrl = json['profilePhotoUrl'] as String
    ..username = json['username'] as String;
}

Map<String, dynamic> _$Chats$Query$Chats$Nodes$AuthorToJson(
        Chats$Query$Chats$Nodes$Author instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'username': instance.username,
    };

Chats$Query$Chats$Nodes _$Chats$Query$Chats$NodesFromJson(
    Map<String, dynamic> json) {
  return Chats$Query$Chats$Nodes()
    ..id = json['id'] as int
    ..createdAt = fromGraphQLDateTimeToDartDateTime(json['createdAt'] as String)
    ..text = json['text'] as String
    ..author = Chats$Query$Chats$Nodes$Author.fromJson(
        json['author'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Chats$Query$Chats$NodesToJson(
        Chats$Query$Chats$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': fromDartDateTimeToGraphQLDateTime(instance.createdAt),
      'text': instance.text,
      'author': instance.author.toJson(),
    };

Chats$Query$Chats$Errors _$Chats$Query$Chats$ErrorsFromJson(
    Map<String, dynamic> json) {
  return Chats$Query$Chats$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$Chats$Query$Chats$ErrorsToJson(
        Chats$Query$Chats$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

Chats$Query$Chats _$Chats$Query$ChatsFromJson(Map<String, dynamic> json) {
  return Chats$Query$Chats()
    ..ok = json['ok'] as bool?
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map(
            (e) => Chats$Query$Chats$Nodes.fromJson(e as Map<String, dynamic>))
        .toList()
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map(
            (e) => Chats$Query$Chats$Errors.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$Chats$Query$ChatsToJson(Chats$Query$Chats instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'nodes': instance.nodes?.map((e) => e.toJson()).toList(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

Chats$Query _$Chats$QueryFromJson(Map<String, dynamic> json) {
  return Chats$Query()
    ..chats = Chats$Query$Chats.fromJson(json['chats'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Chats$QueryToJson(Chats$Query instance) =>
    <String, dynamic>{
      'chats': instance.chats.toJson(),
    };

PopularInterests$Query$PopularInterests$Nodes
    _$PopularInterests$Query$PopularInterests$NodesFromJson(
        Map<String, dynamic> json) {
  return PopularInterests$Query$PopularInterests$Nodes()
    ..id = json['id'] as int
    ..title = json['title'] as String;
}

Map<String, dynamic> _$PopularInterests$Query$PopularInterests$NodesToJson(
        PopularInterests$Query$PopularInterests$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

PopularInterests$Query$PopularInterests$Errors
    _$PopularInterests$Query$PopularInterests$ErrorsFromJson(
        Map<String, dynamic> json) {
  return PopularInterests$Query$PopularInterests$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$PopularInterests$Query$PopularInterests$ErrorsToJson(
        PopularInterests$Query$PopularInterests$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

PopularInterests$Query$PopularInterests
    _$PopularInterests$Query$PopularInterestsFromJson(
        Map<String, dynamic> json) {
  return PopularInterests$Query$PopularInterests()
    ..ok = json['ok'] as bool?
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map((e) => PopularInterests$Query$PopularInterests$Nodes.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => PopularInterests$Query$PopularInterests$Errors.fromJson(
            e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$PopularInterests$Query$PopularInterestsToJson(
        PopularInterests$Query$PopularInterests instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'nodes': instance.nodes?.map((e) => e.toJson()).toList(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

PopularInterests$Query _$PopularInterests$QueryFromJson(
    Map<String, dynamic> json) {
  return PopularInterests$Query()
    ..popularInterests = PopularInterests$Query$PopularInterests.fromJson(
        json['popularInterests'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PopularInterests$QueryToJson(
        PopularInterests$Query instance) =>
    <String, dynamic>{
      'popularInterests': instance.popularInterests.toJson(),
    };

FlaggedUsers$Query$FlaggedUsers$Nodes
    _$FlaggedUsers$Query$FlaggedUsers$NodesFromJson(Map<String, dynamic> json) {
  return FlaggedUsers$Query$FlaggedUsers$Nodes()
    ..id = json['id'] as int
    ..profilePhotoUrl = json['profilePhotoUrl'] as String
    ..photoUrls = json['photoUrls'] as String
    ..email = json['email'] as String
    ..verified = json['verified'] as bool
    ..username = json['username'] as String
    ..birthday = fromGraphQLDateTimeToDartDateTime(json['birthday'] as String)
    ..bio = json['bio'] as String
    ..interests = (json['interests'] as List<dynamic>)
        .map((e) =>
            UserFieldsMixin$Interests.fromJson(e as Map<String, dynamic>))
        .toList()
    ..myEvents = (json['myEvents'] as List<dynamic>)
        .map(
            (e) => UserFieldsMixin$MyEvents.fromJson(e as Map<String, dynamic>))
        .toList()
    ..chatNotifications = (json['chatNotifications'] as List<dynamic>)
        .map((e) => UserFieldsMixin$ChatNotifications.fromJson(
            e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FlaggedUsers$Query$FlaggedUsers$NodesToJson(
        FlaggedUsers$Query$FlaggedUsers$Nodes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'photoUrls': instance.photoUrls,
      'email': instance.email,
      'verified': instance.verified,
      'username': instance.username,
      'birthday': fromDartDateTimeToGraphQLDateTime(instance.birthday),
      'bio': instance.bio,
      'interests': instance.interests.map((e) => e.toJson()).toList(),
      'myEvents': instance.myEvents.map((e) => e.toJson()).toList(),
      'chatNotifications':
          instance.chatNotifications.map((e) => e.toJson()).toList(),
    };

FlaggedUsers$Query$FlaggedUsers$Errors
    _$FlaggedUsers$Query$FlaggedUsers$ErrorsFromJson(
        Map<String, dynamic> json) {
  return FlaggedUsers$Query$FlaggedUsers$Errors()
    ..field = json['field'] as String?
    ..message = json['message'] as String;
}

Map<String, dynamic> _$FlaggedUsers$Query$FlaggedUsers$ErrorsToJson(
        FlaggedUsers$Query$FlaggedUsers$Errors instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

FlaggedUsers$Query$FlaggedUsers _$FlaggedUsers$Query$FlaggedUsersFromJson(
    Map<String, dynamic> json) {
  return FlaggedUsers$Query$FlaggedUsers()
    ..ok = json['ok'] as bool?
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map((e) => FlaggedUsers$Query$FlaggedUsers$Nodes.fromJson(
            e as Map<String, dynamic>))
        .toList()
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => FlaggedUsers$Query$FlaggedUsers$Errors.fromJson(
            e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FlaggedUsers$Query$FlaggedUsersToJson(
        FlaggedUsers$Query$FlaggedUsers instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'nodes': instance.nodes?.map((e) => e.toJson()).toList(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

FlaggedUsers$Query _$FlaggedUsers$QueryFromJson(Map<String, dynamic> json) {
  return FlaggedUsers$Query()
    ..flaggedUsers = FlaggedUsers$Query$FlaggedUsers.fromJson(
        json['flaggedUsers'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FlaggedUsers$QueryToJson(FlaggedUsers$Query instance) =>
    <String, dynamic>{
      'flaggedUsers': instance.flaggedUsers.toJson(),
    };

UserArguments _$UserArgumentsFromJson(Map<String, dynamic> json) {
  return UserArguments(
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$UserArgumentsToJson(UserArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

EventsArguments _$EventsArgumentsFromJson(Map<String, dynamic> json) {
  return EventsArguments(
    dateRange:
        DateRangeInput.fromJson(json['dateRange'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EventsArgumentsToJson(EventsArguments instance) =>
    <String, dynamic>{
      'dateRange': instance.dateRange.toJson(),
    };

EventUserPreviewArguments _$EventUserPreviewArgumentsFromJson(
    Map<String, dynamic> json) {
  return EventUserPreviewArguments(
    userIds: (json['userIds'] as List<dynamic>).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$EventUserPreviewArgumentsToJson(
        EventUserPreviewArguments instance) =>
    <String, dynamic>{
      'userIds': instance.userIds,
    };

ForumsByEventIdArguments _$ForumsByEventIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return ForumsByEventIdArguments(
    eventIds: (json['eventIds'] as List<dynamic>).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$ForumsByEventIdArgumentsToJson(
        ForumsByEventIdArguments instance) =>
    <String, dynamic>{
      'eventIds': instance.eventIds,
    };

SearchInterestsArguments _$SearchInterestsArgumentsFromJson(
    Map<String, dynamic> json) {
  return SearchInterestsArguments(
    partial: json['partial'] as String,
  );
}

Map<String, dynamic> _$SearchInterestsArgumentsToJson(
        SearchInterestsArguments instance) =>
    <String, dynamic>{
      'partial': instance.partial,
    };

LastChatArguments _$LastChatArgumentsFromJson(Map<String, dynamic> json) {
  return LastChatArguments(
    forumId: json['forumId'] as int,
  );
}

Map<String, dynamic> _$LastChatArgumentsToJson(LastChatArguments instance) =>
    <String, dynamic>{
      'forumId': instance.forumId,
    };

ChatsArguments _$ChatsArgumentsFromJson(Map<String, dynamic> json) {
  return ChatsArguments(
    forumId: json['forumId'] as int,
  );
}

Map<String, dynamic> _$ChatsArgumentsToJson(ChatsArguments instance) =>
    <String, dynamic>{
      'forumId': instance.forumId,
    };
